apiVersion: v1
kind: ConfigMap
metadata:
  labels:
    name: yarn-config
  name: yarn-config
data:
  yarn-site.xml: |
    <?xml version="1.0" encoding="UTF-8" standalone="no"?>
    <#--Simple macro definition-->
    <#macro property key value>
    <property>
        <name>${key}</name>
        <value>${value}</value>
    </property>
    </#macro>
    <#--------------------------->
    <#assign
        serviceName=service.serviceName
        rm_port=conf['resourcemanager.port']
        rm_track_port=conf['resourcemanager.resource-tracker.port']
        rm_scheduler_port=conf['resourcemanager.scheduler.port']
        rm_admin_port=conf['resourcemanager.admin.port']
        rm_webapp_port=conf['resourcemanager.webapp.port']
    >
    <configuration>

<#--对外暴露的yarn-site.xml文件不需要提供存储位置-->
<#--        <@property "yarn.nodemanager.local-dirs" "/workspace/data/local"/>-->
<#--        <@property "yarn.nodemanager.log-dirs" "/workspace/logs"/>-->
        <#--handle dependencies.hdfs-->
        <#assign hdfs=dependencies.HDFS >
        <@property "yarn.nodemanager.remote-app-log-dir" "hdfs://${hdfs.conf['nameservices']}${conf['remote.app.log.dir']}"/>
        <@property "yarn.app.mapreduce.am.staging-dir" "hdfs://${hdfs.conf['nameservices']}${conf['mapreduce.am.staging.dir']}"/>

    <#if serviceRoles['YARN_RESOURCEMANAGER']?? && serviceRoles['YARN_RESOURCEMANAGER']?size gt 1>
        <@property "yarn.resourcemanager.ha.enabled" "true"/>
        <@property "yarn.resourcemanager.recovery.enabled" "true"/>
        <@property "yarn.resourcemanager.store.class" "org.apache.hadoop.yarn.server.resourcemanager.recovery.ZKRMStateStore"/>
        <#--handle dependencies.zookeeper-->
        <#if dependencies.ZOOKEEPER??>
            <#assign zookeeper=dependencies.ZOOKEEPER quorums=[]>
            <#list zookeeper.serviceRoles['ZOOKEEPER_SERVER'] as role>
                <#assign quorums += [role.hostname + ":" + zookeeper.conf["zookeeper.client.port"]]>
            </#list>
            <#assign quorum = quorums?join(",")>
        </#if>
        <@property "yarn.resourcemanager.zk-address" quorum/>
        <@property "yarn.resourcemanager.ha.automatic-failover.enabled" "true"/>
        <@property "yarn.resourcemanager.ha.automatic-failover.embedded" "true"/>
        <@property "yarn.resourcemanager.cluster-id" serviceName + "-cluster"/>
        <@property "yarn.resourcemanager.zk-state-store.parent-path" "/rmstore-" + serviceName/>
        <#assign  size=serviceRoles['YARN_RESOURCEMANAGER']?size rmIds=[]>
        <#list 0..size-1 as i>
            <#assign rmId = "rm" + (i + 1)>
            <#assign rmIds += [rmId]>
            <#assign rm = serviceRoles['YARN_RESOURCEMANAGER'][i]['hostname']>
            <@property "yarn.resourcemanager.address." + rmId rm + ":" + rm_port/>
            <@property "yarn.resourcemanager.resource-tracker.address." + rmId rm + ":" + rm_track_port/>
            <@property "yarn.resourcemanager.scheduler.address." + rmId rm + ":" + rm_scheduler_port/>
            <@property "yarn.resourcemanager.admin.address." + rmId rm + ":" + rm_admin_port/>
            <@property "yarn.resourcemanager.webapp.address." + rmId rm + ":" + rm_webapp_port/>
            <#if i==0>
                <@property "yarn.resourcemanager.ha.id" rmId/>
            </#if>
        </#list>
        <#assign rm_Ids = rmIds?join(",")>
        <@property "yarn.resourcemanager.ha.rm-ids" rm_Ids/>
    <#else>
        <#assign resourceManager=serviceRoles['YARN_RESOURCEMANAGER'][0]['hostname']>
        <@property "yarn.resourcemanager.address" resourceManager + ":" + rm_port/>
        <@property "yarn.resourcemanager.resource-tracker.address" resourceManager + ":" + rm_track_port/>
        <@property "yarn.resourcemanager.scheduler.address" resourceManager + ":" + rm_scheduler_port/>
        <@property "yarn.resourcemanager.admin.address" resourceManager + ":" + rm_admin_port/>
        <@property "yarn.resourcemanager.webapp.address" resourceManager + ":" + rm_webapp_port/>
    </#if>

    <#if serviceRoles['YARN_HISTORYSERVER']?? && serviceRoles['YARN_HISTORYSERVER']?size gt 0>
        <#assign historyServer=serviceRoles['YARN_HISTORYSERVER'][0]['hostname']>
        <@property "yarn.log.server.url" "http://" + historyServer + ":${conf['historyserver.http-port']}/jobhistory/logs/"/>
    </#if>

    <#if serviceRoles['YARN_TIMELINESERVER']?? && serviceRoles['YARN_TIMELINESERVER']?size gt 0>
        <#assign timelineServer=serviceRoles['YARN_TIMELINESERVER'][0]['hostname']>
        <@property "yarn.timeline-service.hostname" timelineServer/>
        <@property "yarn.timeline-service.webapp.https.address" timelineServer + ":8190"/>
        <@property "yarn.timeline-service.webapp.address" timelineServer + ":${conf['timelineserver.http.port']}"/>
    </#if>

        <@property "yarn.resourcemanager.nodes.exclude-path" "/opt/hadoop/etc/hadoop/yarn.exclude"/>
    <#--Take properties from the context-->
    <#list confFiles['yarn-site.xml'] as key, value>
        <@property key value/>
    </#list>
    </configuration>


  mapred-site.xml: |
    <?xml version="1.0" encoding="UTF-8" standalone="no"?>
    <#--Simple macro definition-->
    <#macro property key value>
    <property>
        <name>${key}</name>
        <value>${value}</value>
    </property>
    </#macro>
    <#--------------------------->
    <configuration>
        <#if serviceRoles['YARN_HISTORYSERVER']??>
        <#assign historyServer=serviceRoles['YARN_HISTORYSERVER'][0]['hostname']>
        <@property "mapreduce.jobhistory.address" historyServer + ":${conf['historyserver.port']}"/>
        <@property "mapreduce.jobhistory.webapp.address" historyServer + ":${conf['historyserver.http-port']}"/>
        <@property "mapreduce.jobhistory.admin.address" "0.0.0.0" + ":${conf['historyserver.admin-port']}"/>
        </#if>


    <#--Take properties from the context-->
    <#list confFiles['mapred-site.xml'] as key, value>
        <@property key value/>
    </#list>
    </configuration>
