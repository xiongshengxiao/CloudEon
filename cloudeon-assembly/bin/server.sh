#!/bin/bash
set -e

# description: Auto-starts cloudeon server

# Configuration
BASE_DIR=$(cd "$(dirname "$0")/.." && pwd)
CLOUDEON_HOME="${BASE_DIR}"
CONF_DIR="${BASE_DIR}/conf"
LIB_DIR="${BASE_DIR}/lib"
LOG_DIR="${BASE_DIR}/log"
DB_DIR="${BASE_DIR}/db"
TMP_DIR="${BASE_DIR}/tmp"
PID_FILE="${BASE_DIR}/bin/server.pid"
APPLICATION_CONF="${CONF_DIR}/application.yaml"
SERVER_LOG="${LOG_DIR}/server.log"
STDOUT_LOG="${LOG_DIR}/stdout.log"
PID_TAG="CloudEonApplication"

# Default settings
JAVA=${JAVA:-$(which java)}
SERVER_PORT=${SERVER_PORT:-7700}
DB_ACTIVE=${DB_ACTIVE:-"h2"}
PROFILE_ACTIVE=${PROFILE_ACTIVE:-"prod"}
USR_JVM_SIZE=${USR_JVM_SIZE:-"-Xms1024m -Xmx2024m"}

# Functions
error_exit() {
    echo "ERROR: $1" >&2
    [ "${mode}" == "-s" ] && echo "$1" > "$STDOUT_LOG"
    exit 1
}

log_stdout() {
    echo "$1" >> "$STDOUT_LOG"
}

get_pid() {
    pgrep -f "$PID_TAG" || echo ""
}

start_server() {
    local pid=$(get_pid)
    if [ -n "$pid" ]; then
        echo "Server is already running (PID: $pid)"
        exit 0
    fi

    mkdir -p "$LOG_DIR" "$TMP_DIR" "$DB_DIR"
    [ -f "$APPLICATION_CONF" ] || error_exit "Cannot find $APPLICATION_CONF"

    local RUN_JAR=$(ls -t "${LIB_DIR}"/*.jar | head -1)
    [ -n "$RUN_JAR" ] || error_exit "No JAR file found in $LIB_DIR"

    # Set JVM options based on IN_CONTAINER
    if [ -n "$IN_CONTAINER" ]; then
        JAVA_OPTS="-XX:MaxRAMPercentage=75.0 -XX:MinRAMPercentage=25.0 -XX:InitialRAMPercentage=5.0"
    else
        JAVA_OPTS="$USR_JVM_SIZE"
    fi

    JAVA_OPTS="$JAVA_OPTS -XX:+UseG1GC -XX:MaxGCPauseMillis=250 -Djava.awt.headless=true -Dfile.encoding=UTF-8"
    JAVA_OPTS="$JAVA_OPTS -Dspring.config.location=$APPLICATION_CONF -Djava.io.tmpdir=$TMP_DIR"
    JAVA_OPTS="$JAVA_OPTS -Dcloudeon.home.path=$BASE_DIR -Djpom.application.tag=${PID_TAG}"

    echo "Starting server with command:" > "$STDOUT_LOG"
    echo "$JAVA $JAVA_OPTS -jar $RUN_JAR" >> "$STDOUT_LOG"

    nohup $JAVA $JAVA_OPTS -jar "$RUN_JAR" > "$STDOUT_LOG" 2>&1 &
    echo $! > "$PID_FILE"
    echo "Server started with PID: $!"

    if [ "${mode}" == "-s" ] || [ "${mode}" == "upgrade" ]; then
        echo "Silent mode, exiting"
        exit 0
    fi

    tail -00f "$STDOUT_LOG"
}

stop_server() {
    local pid=$(get_pid)
    if [ -z "$pid" ]; then
        echo "Server is not running"
        return
    fi

    echo "Stopping server (PID: $pid)"
    kill $pid
    for i in {1..30}; do
        if ! kill -0 $pid 2>/dev/null; then
            echo "Server stopped"
            rm -f "$PID_FILE"
            return
        fi
        sleep 1
    done

    echo "Server did not stop gracefully, forcing shutdown"
    kill -9 $pid
    rm -f "$PID_FILE"
}

# Main script
mode="$2"
case "$1" in
    start)
        start_server
        ;;
    stop)
        stop_server
        ;;
    restart)
        stop_server
        start_server
        ;;
    status)
        pid=$(get_pid)
        if [ -n "$pid" ]; then
            echo "Server is running (PID: $pid)"
        else
            echo "Server is not running"
        fi
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status} [-s]" >&2
        exit 1
        ;;
esac

exit 0
