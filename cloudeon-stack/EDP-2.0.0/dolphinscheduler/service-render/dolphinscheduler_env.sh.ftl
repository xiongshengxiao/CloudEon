

# Database related configuration, set database type, username and password
export DATABASE=mysql
# worker不能使用mysql环境，会报错
<#if ROLE_FULL_NAME != "ds-worker">
export SPRING_PROFILES_ACTIVE=$DATABASE
</#if>
export SPRING_DATASOURCE_URL="${conf['jdbc.mysql.address']}"
export SPRING_DATASOURCE_USERNAME=${conf['jdbc.mysql.username']}
export SPRING_DATASOURCE_PASSWORD=${conf['jdbc.mysql.password']}


# DolphinScheduler server related configuration
export SPRING_CACHE_TYPE=none
export SPRING_JACKSON_TIME_ZONE=GMT+8
<#--handle dependent.zookeeper-->
<#if dependencies.ZOOKEEPER??>
    <#assign zookeeper=dependencies.ZOOKEEPER quorum=[]>
    <#list zookeeper.serviceRoles['ZOOKEEPER_SERVER'] as role>
        <#assign quorum += [role.hostname + ":" + zookeeper.conf["zookeeper.client.port"]]>
    </#list>
</#if>
# Registry center configuration, determines the type and link of the registry center
export REGISTRY_TYPE=zookeeper
export REGISTRY_ZOOKEEPER_CONNECT_STRING=${quorum?join(",")}
