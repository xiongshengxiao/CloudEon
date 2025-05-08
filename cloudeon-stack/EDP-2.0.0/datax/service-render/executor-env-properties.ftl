# environment variables

#JAVA_HOME=""

SERVICE_LOG_PATH=/opt/datax-web/modules/datax-executor/logs
SERVICE_CONF_PATH=/opt/datax-web/modules/datax-executor/conf
DATA_PATH=/opt/datax-web/modules/datax-executor/data


## datax json文件存放位置
JSON_PATH=/opt/datax-web/modules/datax-executor/json


## executor_port(执行器）的默认端口号是9999
EXECUTOR_PORT=${conf['executor.port']}


## 保持和datax-admin服务的端口一致；默认是9527，如果没改datax-admin的端口，可以忽略
DATAX_ADMIN_PORT=${conf['datax.web.port']}

## PYTHON脚本执行位置
#PYTHON_PATH=/home/hadoop/install/datax/bin/datax.py
PYTHON_PATH=${conf['PYTHON_PATH']}



## dataxweb 服务端口
SERVER_PORT=9504

#PID_FILE_PATH=/opt/datax-web/modules/datax-executor/bin/service.pid


#debug 远程调试端口
#REMOTE_DEBUG_SWITCH=true
#REMOTE_DEBUG_PORT=7004
