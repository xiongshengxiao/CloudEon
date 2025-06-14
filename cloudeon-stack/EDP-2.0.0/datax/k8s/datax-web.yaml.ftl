<#if conf["data.path.list"]??&& conf["data.path.list"]?trim?has_content>
  <#assign primeDataPathList=conf["data.path.list"]?trim?split(",")>
<#else >
  <#assign primeDataPathList=[conf['global.persistence.basePath']]>
</#if>
<#assign dataPathList = []>
<#list primeDataPathList as dataPath>
  <#if dataPath?ends_with("/")>
    <#assign dataPathList = dataPathList + [dataPath+ roleFullName]>
  <#else>
    <#assign dataPathList = dataPathList + [dataPath+"/"+ roleFullName]>
  </#if>
</#list>
---
apiVersion: "apps/v1"
kind: "Deployment"
metadata:
  labels:
    name: "${roleServiceFullName}"
    sname: "${serviceFullName}"
    roleFullName: "${roleFullName}"
  name: "${roleServiceFullName}"
spec:
  replicas: ${roleNodeCnt}
  selector:
    matchLabels:
      app: "${roleServiceFullName}"
      sname: "${serviceFullName}"
      roleFullName: "${roleFullName}"
  strategy:
    type: "RollingUpdate"
    rollingUpdate:
      maxSurge: 0
      maxUnavailable: 1
  minReadySeconds: 5
  revisionHistoryLimit: 10
  template:
    metadata:
      labels:
        name: "${roleServiceFullName}"
        sname: "${serviceFullName}"
        roleFullName: "${roleFullName}"
        app: "${roleServiceFullName}"
        podConflictName: "${roleServiceFullName}"
        inject-filebeat: "true"
    spec:
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            - labelSelector:
                matchLabels:
                  name: "${roleServiceFullName}"
                  podConflictName: "${roleServiceFullName}"
              topologyKey: "kubernetes.io/hostname"
      hostPID: false
      hostNetwork: true
      nodeSelector:
        ${roleServiceFullName}: "true"
      terminationGracePeriodSeconds: 30
      containers:
<#if dependencies.FILEBEAT??>
      - name: filebeat
        image: "${dependencies.FILEBEAT.conf['webImage']}"
        imagePullPolicy: "${conf['global.imagePullPolicy']}"
    # 设置root用户运行，避免写入filebeat.registry失败
        securityContext:
          runAsUser: 0
        env:
          - name: NODE_NAME
            valueFrom:
              fieldRef:
                fieldPath: spec.nodeName
          - name: POD_NAME
            valueFrom:
              fieldRef:
                fieldPath: metadata.name
          - name: POD_IP
            valueFrom:
              fieldRef:
                fieldPath: status.podIP
        resources:
          limits:
            cpu: "1"
            memory: 200Mi
          requests:
            cpu: 10m
            memory: 100Mi
        volumeMounts:
        - mountPath: /usr/share/filebeat/filebeat.yml
          name: filebeat-config
          subPath: filebeat.yml
        - mountPath: "/workspace/filebeat"
          name: "workspace"
          subPath: filebeat
        - mountPath: "/workspace/logs"
          name: "workspace"
          subPath: logs
</#if>
      - name: "server"
        imagePullPolicy: "${conf['global.imagePullPolicy']}"
        image: "${conf['webImage']}"
        command: ["/bin/bash","-c"]
        args:
          - |
            /bin/bash /opt/global/bootstrap.sh && \
            /bin/bash /opt/service-common/bootstrap.sh;
        readinessProbe:
          httpGet:
            path: /index.html
            port: ${conf['datax.web.port']}
          initialDelaySeconds: 10
          timeoutSeconds: 2
        resources:
          requests:
            cpu: "${conf['resources.requests.cpu']}"
            memory: "${conf['resources.requests.memory']}Mi"
          limits:
            cpu: "${conf['resources.limits.cpu']}"
            memory: "${conf['resources.limits.memory']}Mi"
        env:
          - name: NODE_NAME
            valueFrom:
              fieldRef:
                fieldPath: spec.nodeName
          - name: MEM_LIMIT
            valueFrom:
              resourceFieldRef:
                resource: limits.memory
          - name: RENDER_TPL_DIR
            value: "/opt/service-render"
          - name: RENDER_MODEL
            value: "/opt/service-common/values.json"
          - name: ROLE_FULL_NAME
            value: "${roleFullName}"
          - name: SERVER_PORT
            value: "${conf['datax.web.port']}"
          - name: DB_ACTIVE
            value: "mysql"
          - name: MYSQL_HOST
            value: "${conf['MysqlHostname']}"
          - name: MYSQL_PORT
            value: "${conf['MysqlPort']}"
          - name: MYSQL_ADDR
            value: "${conf['MysqlHostname']}:${conf['MysqlPort']}"
          - name: MYSQL_DATABASE
            value: "${conf['MysqlDatabase']}"
          - name: MYSQL_USERNAME
            value: "${conf['MysqlUserName']}"
          - name: MYSQL_PASSWORD
            value: "${conf['MysqlPassword']}"
          - name: JMX_PORT
            value: "${conf['datax_web.jmx.port']}"
          - name: JVM_MEM_PERCENTAGE
            value: "${conf['jvm.heap.memory.percentage']?number}"
          - name: PERM_SIZE_PERCENTAGE
            value: "${conf['jvm.perm_size.memory.percentage']?number}"
        volumeMounts:
        - mountPath: "/etc/localtime"
          name: "timezone"
        - name: global-service-common
          mountPath: /opt/global/bootstrap.sh
          subPath: bootstrap.sh
        - name: global-render-config
          mountPath: /opt/global/10.render
        - name: global-usersync-config
          mountPath: /opt/global/20.usersync
        - name: global-copy-filebeat-config
          mountPath: /opt/global/30.copy-filebeat-config
        - name: service-render
          mountPath: /opt/service-render
        - name: service-common
          mountPath: /opt/service-common
        - mountPath: "/workspace"
          name: "workspace"
        - mountPath: "/opt/datax-web/modules/datax-admin/data"
          name: "datax-admin-data"
        - mountPath: "/opt/datax-web/modules/datax-admin/logs"
          name: "datax-admin-logs"
        - mountPath: "/opt/datax-web/modules/datax-executor/data"
          name: "datax-executor-data"
        - mountPath: "/opt/datax-web/modules/datax-executor/logs"
          name: "datax-executor-logs"
<#list dataPathList as dataPath>
        - name: local-data-${dataPath?index+1}
          mountPath: /data/${dataPath?index+1}
</#list>
      volumes:
      - hostPath:
          path: "/etc/localtime"
        name: "timezone"
      - name: global-service-common
        configMap:
          name: global-service-common
      - name: global-render-config
        configMap:
          name: global-render-config
      - name: global-usersync-config
        configMap:
          name: global-usersync-config
      - name: global-copy-filebeat-config
        configMap:
          name: global-copy-filebeat-config
      - name: service-render
        configMap:
          name: datax-service-render
      - name: service-common
        configMap:
          name: datax-service-common
      - name: "workspace"
        hostPath:
          type: DirectoryOrCreate
          path: "${dataPathList[0]}/workspace"
      - name: "datax-admin-data"
        hostPath:
          type: DirectoryOrCreate
          path: "${dataPathList[0]}/datax-admin/data"
      - name: "datax-admin-logs"
        hostPath:
          type: DirectoryOrCreate
          path: "${dataPathList[0]}/datax-admin/logs"
      - name: "datax-executor-data"
        hostPath:
          type: DirectoryOrCreate
          path: "${dataPathList[0]}/datax-executor/data"
      - name: "datax-executor-logs"
        hostPath:
          type: DirectoryOrCreate
          path: "${dataPathList[0]}/datax-executor/logs"
<#list dataPathList as dataPath>
      - name: local-data-${dataPath?index+1}
        hostPath:
          path: ${dataPath}/data
          type: DirectoryOrCreate
</#list>
<#if dependencies.FILEBEAT??>
      - configMap:
          name: filebeat-common-config
        name: filebeat-config
</#if>

