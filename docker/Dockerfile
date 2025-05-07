FROM openjdk:8

ARG BUILD_DATE
ARG CLOUDEON_VERSION=v0.0.0

ENV CLOUDEON_HOME=/opt/cloudeon \
    CLOUDEON_VERSION=${CLOUDEON_VERSION} \
    TZ=Asia/Shanghai \
    SERVER_PORT=7700 \
    DB_ACTIVE=h2 \
    PROFILE_ACTIVE=prod

# 设置时区
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 添加并解压 cloudeon 包
ADD cloudeon-assembly-*.tar.gz /opt/
RUN mv /opt/cloudeon-assembly-* $CLOUDEON_HOME

# 健康检查
HEALTHCHECK CMD curl -X GET -f http://localhost:$SERVER_PORT/actuator/health || exit 1

# 暴露端口
EXPOSE $SERVER_PORT

# 设置工作目录
WORKDIR $CLOUDEON_HOME

# 启动命令
ENTRYPOINT ["/bin/bash", "bin/server.sh", "start"]