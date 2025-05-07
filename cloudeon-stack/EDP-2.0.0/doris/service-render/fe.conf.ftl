CUR_DATE=`date +%Y%m%d-%H%M%S`

LOG_DIR = /workspace/logs

<#assign ramPercentage = conf['doris.fe.jvm.memory.percentage']?number>
<#assign ramMb = conf['doris.fe.container.limit.memory']?number>
<#assign serverHeap = (ramMb * ramPercentage /100)?floor?c>

JAVA_OPTS="-Djavax.security.auth.useSubjectCredsOnly=false -Xss4m -Xmx${serverHeap}M -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:+PrintGCDateStamps -XX:+PrintGCDetails -Xloggc:$LOG_DIR/fe.gc.log.$CUR_DATE -Dlog4j2.formatMsgNoLookups=true"

# For jdk 9+, this JAVA_OPTS_FOR_JDK_9 will be used as default G1 JVM options
JAVA_OPTS_FOR_JDK_9="-Djavax.security.auth.useSubjectCredsOnly=false -Xss4m -Xmx${serverHeap}M -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -Xlog:gc*:$LOG_DIR/fe.gc.log.$CUR_DATE:time -Dlog4j2.formatMsgNoLookups=true"

# For jdk 17+, this JAVA_OPTS will be used as default JVM options
JAVA_OPTS_FOR_JDK_17="-Djavax.security.auth.useSubjectCredsOnly=false -XX:+UseZGC -Xmx${serverHeap}M -Xms8192m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=$LOG_DIR/ -Xlog:gc*:$LOG_DIR/fe.gc.log.$CUR_DATE:time"

# INFO, WARN, ERROR, FATAL
sys_log_level = INFO

# NORMAL, BRIEF, ASYNC
sys_log_mode = NORMAL

# store metadata, must be created before start FE.
meta_dir =  /data/1/meta

<#list confFiles['fe.conf']?keys as key>
    ${key}=${confFiles['fe.conf'][key]}
</#list>


mysql_service_nio_enabled = true

audit_log_dir = /workspace/logs
sys_log_dir = /workspace/logs

priority_networks = ${nodeInfo[HOSTNAME].ip}/24


