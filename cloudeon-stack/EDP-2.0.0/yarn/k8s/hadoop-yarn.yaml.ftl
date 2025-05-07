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
      containers:
<#if dependencies.FILEBEAT??>
      - name: filebeat
        image: "${dependencies.FILEBEAT.conf['serverImage']}"
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
    <#--禁用filebeat 检测，避免因filebeat状态异常影响安装-->
    <#--    readinessProbe:-->
    <#--      exec:-->
    <#--        command:-->
    <#--        - sh-->
    <#--        - -c-->
    <#--        - |-->
    <#--          #!/usr/bin/env bash -e-->
    <#--          filebeat test output-->
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
      - image: "${conf['serverImage']}"
        imagePullPolicy: "${conf['global.imagePullPolicy']}"
        name: "${roleServiceFullName}"
        command: ["/bin/bash","-c"]
        args:
          - |
            /bin/bash /opt/global/bootstrap.sh && \
            /bin/bash /opt/service-common/bootstrap.sh;
<#switch roleFullName>
  <#case "hadoop-yarn-resourcemanager">
        readinessProbe:
          exec:
            command:
            - "/bin/bash"
            - "-c"
            - "curl --fail --connect-timeout 15 --max-time 15 \"http://`hostname`:${conf['resourcemanager.webapp.port']}/?user.name=yarn\"\
            \n"
          failureThreshold: 3
          initialDelaySeconds: 10
          periodSeconds: 10
          successThreshold: 1
          timeoutSeconds: 1
        resources:
          requests:
            memory: "${conf['hadop.yarn.rm.container.request.memory']}Mi"
            cpu: "${conf['hadop.yarn.rm.container.request.cpu']}"
          limits:
            memory: "${conf['hadop.yarn.rm.container.limit.memory']}Mi"
            cpu: "${conf['hadop.yarn.rm.container.limit.cpu']}"
      <#break>
  <#case "hadoop-yarn-nodemanager">
        readinessProbe:
          exec:
            command:
            - "/bin/bash"
            - "-c"
            - "curl --fail --connect-timeout 15 --max-time 15 \"http://`hostname`:${conf['nodemanager.webapp.port']}/?user.name=yarn\"\
              \n"
          failureThreshold: 3
          initialDelaySeconds: 10
          periodSeconds: 10
          successThreshold: 1
          timeoutSeconds: 1
        resources:
          requests:
            memory: "${conf['hadop.yarn.nm.container.request.memory']}Mi"
            cpu: "${conf['hadop.yarn.nm.container.request.cpu']}"
          limits:
            memory: "${conf['hadop.yarn.nm.container.limit.memory']}Mi"
            cpu: "${conf['hadop.yarn.nm.container.limit.cpu']}"
    <#break>
  <#case "hadoop-yarn-historyserver">
        readinessProbe:
          exec:
            command:
              - "/bin/bash"
              - "-c"
              - "curl --fail --connect-timeout 15 --max-time 15 \"http://`hostname`:${conf['historyserver.http-port']}/?user.name=yarn\"\
              \n"
          failureThreshold: 3
          initialDelaySeconds: 10
          periodSeconds: 10
          successThreshold: 1
          timeoutSeconds: 1
        resources:
          requests:
            memory: "${conf['hadop.yarn.hs.container.request.memory']}Mi"
            cpu: "${conf['hadop.yarn.hs.container.request.cpu']}"
          limits:
            memory: "${conf['hadop.yarn.hs.container.limit.memory']}Mi"
            cpu: "${conf['hadop.yarn.hs.container.limit.cpu']}"
    <#break>
  <#case "hadoop-yarn-timelineserver">
        readinessProbe:
          tcpSocket:
            port: ${conf['timelineserver.http.port']}
          failureThreshold: 3
          initialDelaySeconds: 10
          periodSeconds: 10
          successThreshold: 1
          timeoutSeconds: 1
        resources:
          requests:
            memory: "${conf['hadop.yarn.tl.container.request.memory']}Mi"
            cpu: "${conf['hadop.yarn.tl.container.request.cpu']}"
          limits:
            memory: "${conf['hadop.yarn.tl.container.limit.memory']}Mi"
            cpu: "${conf['hadop.yarn.tl.container.limit.cpu']}"
    <#break>
</#switch>
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
        - name: hdfs-config
          mountPath: /etc/hdfs-config
        - mountPath: "/workspace"
          name: "workspace"
<#list dataPathList as dataPath>
        - name: local-data-${dataPath?index+1}
          mountPath: /data/${dataPath?index+1}
</#list>
      nodeSelector:
        ${roleServiceFullName}: "true"
      terminationGracePeriodSeconds: 30
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
          name: yarn-service-render
      - name: service-common
        configMap:
          name: yarn-service-common
      - name: hdfs-config
        configMap:
          name: hdfs-config
      - name: "workspace"
        hostPath:
          type: DirectoryOrCreate
          path: "${dataPathList[0]}/workspace"
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