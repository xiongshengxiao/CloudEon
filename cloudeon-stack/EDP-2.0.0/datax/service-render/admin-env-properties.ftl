# environment variables

#JAVA_HOME=""

WEB_LOG_PATH=/opt/datax-web/modules/datax-admin/logs
WEB_CONF_PATH=/opt/datax-web/modules/datax-admin/conf

DATA_PATH=/opt/datax-web/modules/datax-admin/data
# data-web端口
SERVER_PORT=${conf['datax.web.port']}

#PID_FILE_PATH=/opt/datax-web/modules/datax-admin/bin/dataxadmin.pid


# mail account
MAIL_USERNAME="${conf['MAIL_USERNAME']}"
MAIL_PASSWORD="${conf['MAIL_PASSWORD']}"


#debug
#REMOTE_DEBUG_SWITCH=true
#REMOTE_DEBUG_PORT=7003
