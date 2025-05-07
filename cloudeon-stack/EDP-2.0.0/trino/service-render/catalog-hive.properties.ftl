connector.name=hive

<#if dependencies.HIVE??>
    <#assign hive=dependencies.HIVE>
    <#assign metastore=hive.serviceRoles['HIVE_METASTORE'] metastore_uri=[]>
    <#list metastore as role>
        <#assign metastore_uri += ["thrift://"+role.hostname + ":" + hive.conf["hive.metastore.thrift.port"]]>
    </#list>
hive.metastore.uri=${metastore_uri?join(",")}
</#if>

hive.config.resources=${TRINO_HOME}/conf/core-site.xml,${TRINO_HOME}/conf/hdfs-site.xml
