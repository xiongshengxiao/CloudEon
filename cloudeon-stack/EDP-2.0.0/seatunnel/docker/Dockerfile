FROM registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/jdk:8-ubuntu

# ENV SEATUNNEL_VERSION="2.3.7"
ENV SEATUNNEL_VERSION="2.3.8"
ENV SEATUNNEL_HOME="/opt/seatunnel"
ENV PATH=$PATH:$SEATUNNEL_HOME/bin
ENV MAVEN_HOME="/opt/maven"
ENV PATH=$PATH:$MAVEN_HOME/bin

# Install Maven
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://mirrors.aliyun.com/apache/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.tar.gz && \
    tar -xzf apache-maven-3.8.8-bin.tar.gz -C /opt && \
    mv /opt/apache-maven-3.8.8 $MAVEN_HOME && \
    rm apache-maven-3.8.8-bin.tar.gz

# Configure Maven to use Aliyun mirrors
RUN mkdir -p /root/.m2 && \
    echo '<?xml version="1.0" encoding="UTF-8"?>\
    <settings xmlns="http://maven.apache.org/SETTINGS/1.0.0" \
              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" \
              xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">\
        <mirrors>\
            <mirror>\
                <id>aliyunmaven</id>\
                <mirrorOf>*</mirrorOf>\
                <name>阿里云公共仓库</name>\
                <url>https://maven.aliyun.com/repository/public</url>\
            </mirror>\
        </mirrors>\
    </settings>' > /root/.m2/settings.xml

# RUN wget https://dlcdn.apache.org/seatunnel/${SEATUNNEL_VERSION}/apache-seatunnel-${SEATUNNEL_VERSION}-bin.tar.gz
RUN wget https://mirrors.aliyun.com/apache/seatunnel/${SEATUNNEL_VERSION}/apache-seatunnel-${SEATUNNEL_VERSION}-bin.tar.gz
RUN tar -xzvf apache-seatunnel-${SEATUNNEL_VERSION}-bin.tar.gz
RUN mv apache-seatunnel-${SEATUNNEL_VERSION} ${SEATUNNEL_HOME}

WORKDIR $SEATUNNEL_HOME

# Replace mvnw with mvn in install-plugin.sh
RUN sed -i 's|${SEATUNNEL_HOME}/mvnw|mvn|g' bin/install-plugin.sh
RUN install-plugin.sh ${SEATUNNEL_VERSION}
