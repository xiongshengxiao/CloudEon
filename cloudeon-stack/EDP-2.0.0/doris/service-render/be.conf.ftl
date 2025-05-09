<#list confFiles['be.conf']?keys as key>
${key}=${confFiles['be.conf'][key]}
</#list>
CUR_DATE=`date +%Y%m%d-%H%M%S`

PPROF_TMPDIR=/workspace/logs

<#assign ramPercentage = conf['doris.be.jvm.memory.percentage']?number>
<#assign ramMb = conf['doris.be.container.limit.memory']?number>
<#assign serverHeap = (ramMb * ramPercentage /100)?floor?c>

JAVA_OPTS="-Xmx${serverHeap}M -DlogPath=/workspace/logs/jni.log -Xloggc:/workspace/logs/be.gc.log.$CUR_DATE -Djavax.security.auth.useSubjectCredsOnly=false -Dsun.security.krb5.debug=true -Dsun.java.command=DorisBE -XX:-CriticalJNINatives"

# For jdk 9+, this JAVA_OPTS will be used as default JVM options
JAVA_OPTS_FOR_JDK_9="-Xmx${serverHeap}M -DlogPath=/workspace/logs/jni.log -Xlog:gc:/workspace/logs/be.gc.log.$CUR_DATE -Djavax.security.auth.useSubjectCredsOnly=false -Dsun.security.krb5.debug=true -Dsun.java.command=DorisBE -XX:-CriticalJNINatives"

# For jdk 17+, this JAVA_OPTS will be used as default JVM options
JAVA_OPTS_FOR_JDK_17="-Xmx${serverHeap}M -DlogPath=/workspace/logs/jni.log -Xlog:gc:/workspace/logs/be.gc.log.$CUR_DATE -Djavax.security.auth.useSubjectCredsOnly=false -Dsun.security.krb5.debug=true -Dsun.java.command=DorisBE -XX:-CriticalJNINatives --add-opens=java.base/java.net=ALL-UNNAMED"

# https://github.com/apache/doris/blob/master/docs/zh-CN/community/developer-guide/debug-tool.md#jemalloc-heap-profile
# https://jemalloc.net/jemalloc.3.html
JEMALLOC_CONF="percpu_arena:percpu,background_thread:true,metadata_thp:auto,muzzy_decay_ms:15000,dirty_decay_ms:15000,oversize_threshold:0,prof:false,lg_prof_interval:32,lg_prof_sample:19,prof_gdump:false,prof_accum:false,prof_leak:false,prof_final:false"
JEMALLOC_PROF_PRFIX=""

enable_https = false

priority_networks = ${nodeInfo[HOSTNAME].ip}/24

storage_root_path = /data/1/storage


sys_log_dir = /workspace/logs