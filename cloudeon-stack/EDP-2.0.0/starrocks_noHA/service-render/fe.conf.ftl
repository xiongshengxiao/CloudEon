LOG_DIR = /workspace/logs

CUR_DATE=`date +%Y%m%d-%H%M%S`

<#assign LOG_DIR = "/workspace/logs">
<#assign STARROCKS_HOME = "/opt/starrocks/fe">
<#assign ramPercentage = conf['starrocks.fe.jvm.memory.percentage']?number>
<#assign ramMb = conf['starrocks.fe.container.limit.memory']?number>
<#assign serverHeap = (ramMb * ramPercentage /100)?floor?c>

JAVA_OPTS="-Dlog4j2.formatMsgNoLookups=true -Xmx${serverHeap}m -XX:+UseG1GC -Xlog:gc*:${LOG_DIR}/fe.gc.log.$DATE:time -XX:ErrorFile=${LOG_DIR}/hs_err_pid%p.log -Djava.security.policy=${STARROCKS_HOME}/conf/udf_security.policy"

# INFO, WARN, ERROR, FATAL
sys_log_level = INFO

<#list confFiles['fe.conf']?keys as key>
${key}=${confFiles['fe.conf'][key]}
</#list>

priority_networks = ${nodeInfo[HOSTNAME].ip}/24

sys_log_dir = /workspace/logs
audit_log_dir = /workspace/logs


