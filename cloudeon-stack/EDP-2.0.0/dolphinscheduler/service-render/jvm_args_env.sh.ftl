<#switch ROLE_FULL_NAME>
<#case "ds-master">
    <#assign jvmRamPercentage = conf['ds.master.jvm.memory.percentage']?number>
<#break>
<#case "ds-worker">
    <#assign jvmRamPercentage = conf['ds.worker.jvm.memory.percentage']?number>
<#break>
<#case "ds-api">
    <#assign jvmRamPercentage = conf['ds.api.jvm.memory.percentage']?number>
<#break>
<#case "ds-alert">
    <#assign jvmRamPercentage = conf['ds.alert.jvm.memory.percentage']?number>
<#break>
</#switch>

<#assign xmxJvmHeapMb = (MEM_LIMIT?number / 1024 / 1024 * jvmRamPercentage /100)?floor?c>
<#assign xmnJvmHeapMb = (MEM_LIMIT?number / 1024 / 1024 * jvmRamPercentage /200)?floor?c>
-Xms${xmxJvmHeapMb}M
-Xmx${xmxJvmHeapMb}M
-Xmn${xmnJvmHeapMb}M

-XX:+IgnoreUnrecognizedVMOptions
-XX:+PrintGCDateStamps
-XX:+PrintGCDetails
-Xloggc:gc.log

-XX:+ExitOnOutOfMemoryError
-XX:+HeapDumpOnOutOfMemoryError
-XX:HeapDumpPath=dump.hprof

-Duser.timezone=Asia/Shanghai