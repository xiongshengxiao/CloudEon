<#list confFiles['be.conf']?keys as key>
    ${key}=${confFiles['be.conf'][key]}
</#list>

priority_networks = ${nodeInfo[HOSTNAME].ip}/24

sys_log_dir = /workspace/logs