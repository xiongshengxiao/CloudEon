<#if conf["data.path.list"]?? && conf["data.path.list"]?trim?has_content>
    <#assign dataPathListSize=conf["data.path.list"]?trim?split(",")?size>
<#else>
    <#assign dataPathListSize=1>
</#if>

<#assign hosts=serviceRoles['KAFKA_BROKER']>
<#list hosts as host>
    <#if host.hostname == HOSTNAME>
        broker.id=${host.id % 254 + 1}
        node.id=${host.id % 254 + 1}
    </#if>
</#list>

<#--<#assign concatenatedPaths="">-->
<#--<#list 1..dataPathListSize as dataPathIndex>-->
<#--    <#assign concatenatedPaths = concatenatedPaths + "/data/${dataPathIndex}">-->
<#--    <#if dataPathIndex < dataPathListSize>-->
<#--        <#assign concatenatedPaths = concatenatedPaths + ",">-->
<#--    </#if>-->
<#--</#list>-->
<#--log.dirs=${concatenatedPaths}-->
log.dirs=/data/kafka

listeners=PLAINTEXT://${HOSTNAME}:${conf['kafka.listeners.port']},CONTROLLER://${HOSTNAME}:9093
listener.security.protocol.map=PLAINTEXT:PLAINTEXT,CONTROLLER:PLAINTEXT
<#--advertised.listeners=PLAINTEXT://${HOSTNAME}:${conf['kafka.listeners.port']}-->

<!-- 新增：KRaft 模式相关配置 -->
process.roles=broker,controller
controller.quorum.voters=<#list hosts as host>${host.id % 254 + 1}@${host.hostname}:9093<#if host_has_next>,</#if></#list>
controller.listener.names=CONTROLLER

<#--启用控制器选举，确保集群的稳定性。-->
controller-election.enable=true

<#list confFiles['server.properties']?keys as key>
    ${key}=${confFiles['server.properties'][key]}
</#list>