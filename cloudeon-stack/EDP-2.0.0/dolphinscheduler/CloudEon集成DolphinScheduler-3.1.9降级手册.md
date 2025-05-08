# CloudEon集成DolphinScheduler-3.1.9降级手册

## 前言

据说：截止到目前，DolphinScheduler3.1.9+以上版本存在BUG，不适合用于生产，所以决定使用大家公认好评的3.1.9版本

## 构建镜像

```dockerfile
FROM registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/hadoop:3.3.4

ENV FLINK_HOME=/opt/flink
ENV FLINK_VERSION=1.20.1
ENV PATH=$PATH:$FLINK_HOME/bin

WORKDIR /tmp

# 下载并安装 Flink
#RUN wget https://mirrors.huaweicloud.com/apache/flink/flink-${FLINK_VERSION}/flink-${FLINK_VERSION}-bin-scala_2.12.tgz \
RUN wget https://mirrors.aliyun.com/apache/flink/flink-${FLINK_VERSION}/flink-${FLINK_VERSION}-bin-scala_2.12.tgz \
    && tar -zxvf flink-*.tgz -C /opt \
    && rm -f flink-*.tgz && mv /opt/flink-*  ${FLINK_HOME}

# 下载并安装 Spark
ENV SPARK_HOME=/opt/spark
ENV SPARK_VERSION=3.2.3
ENV PATH=$PATH:$SPARK_HOME/bin

RUN wget https://mirrors.huaweicloud.com/apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.2.tgz \
    && tar -zxvf spark-*.tgz -C /opt \
    && rm -f spark-*.tgz && mv /opt/spark-*  ${SPARK_HOME}

# 支持 Iceberg
# support iceberg
# RUN wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-3.2_2.12/1.2.1/iceberg-spark-runtime-3.2_2.12-1.2.1.jar \
RUN wget https://maven.aliyun.com/repository/public/org/apache/iceberg/iceberg-spark-runtime-3.2_2.12/1.2.1/iceberg-spark-runtime-3.2_2.12-1.2.1.jar \
    && mv iceberg-spark-runtime*.jar ${SPARK_HOME}/jars/


ENV HIVE_HOME=/opt/hive
ENV HIVE_VERSION=3.1.3
ENV PATH=$PATH:$HIVE_HOME/bin

WORKDIR /tmp

# 下载并安装 Hive
RUN wget https://mirrors.huaweicloud.com/apache/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz \
    && tar -zxvf apache-hive-*.tar.gz -C /opt \
    && rm -f apache-hive-*-bin.tar.gz && mv /opt/apache-hive-*  $HIVE_HOME

# 安装 MySQL Connector
#ENV MYSQL_CONN_VERSION=8.0.20
ENV MYSQL_CONN_VERSION=8.0.30
ENV MYSQL_CONN_URL=https://downloads.mysql.com/archives/get/p/3/file/mysql-connector-java-${MYSQL_CONN_VERSION}.tar.gz
RUN  curl -fSL $MYSQL_CONN_URL -o /tmp/mysql-connector-java.tar.gz     && tar -xzvf /tmp/mysql-connector-java.tar.gz -C /tmp/   \
  && cp /tmp/mysql-connector-java-${MYSQL_CONN_VERSION}/mysql-connector-java-${MYSQL_CONN_VERSION}.jar $HIVE_HOME/lib/mysql-connector-java.jar  \
  && rm -rf /tmp/mysql-connector-*

ENV DOLPHINSCHEDULER_HOME=/opt/dolphinscheduler
ENV DOLPHINSCHEDULER_VERSION=3.1.9
ENV PATH=$PATH:$DOLPHINSCHEDULER_HOME/bin

# 下载并安装 DolphinScheduler
RUN wget https://mirrors.huaweicloud.com/apache/dolphinscheduler/${DOLPHINSCHEDULER_VERSION}/apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin.tar.gz \
    && tar -zxvf apache-dolphinscheduler-*.tar.gz -C /opt \
    && rm -f apache-dolphinscheduler-*.tar.gz && mv /opt/*dolphinscheduler*  $DOLPHINSCHEDULER_HOME

# 替换 start.sh 脚本中的 CLASSPATH 配置
RUN for server in alert-server api-server master-server worker-server; do \
        sed -i 's|-cp "\$DOLPHINSCHEDULER_HOME/conf":"\$DOLPHINSCHEDULER_HOME/libs/\*"|-cp "\$DOLPHINSCHEDULER_HOME/'"$server"'/conf":"\$DOLPHINSCHEDULER_HOME/'"$server"'/libs/\*"|g' $DOLPHINSCHEDULER_HOME/$server/bin/start.sh; \
    done

# 安装 MySQL Connector 到 DolphinScheduler 的各个服务中
# RUN wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.30/mysql-connector-java-8.0.30.jar \
RUN wget https://maven.aliyun.com/repository/public/mysql/mysql-connector-java/8.0.30/mysql-connector-java-8.0.30.jar \
    && cp mysql-connector-java-8.0.30.jar $DOLPHINSCHEDULER_HOME/alert-server/libs/mysql-connector-java-8.0.30.jar \
    && cp mysql-connector-java-8.0.30.jar $DOLPHINSCHEDULER_HOME/api-server/libs/mysql-connector-java-8.0.30.jar \
    && cp mysql-connector-java-8.0.30.jar $DOLPHINSCHEDULER_HOME/master-server/libs/mysql-connector-java-8.0.30.jar \
    && cp mysql-connector-java-8.0.30.jar $DOLPHINSCHEDULER_HOME/tools/libs/mysql-connector-java-8.0.30.jar \
    && cp mysql-connector-java-8.0.30.jar $DOLPHINSCHEDULER_HOME/worker-server/libs/mysql-connector-java-8.0.30.jar \
    && rm -f mysql-connector-java-8.0.30.jar

RUN apt-get install -y mysql-client


# 更新包列表并安装必要的工具
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    # 添加国内加速的 PPA 源
    echo "deb https://launchpad.proxy.ustclug.org/deadsnakes/ppa/ubuntu jammy main" > /etc/apt/sources.list.d/deadsnakes-ppa.list && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.11 python3.11-dev python3.11-venv python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 设置默认的 Python 版本
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1

# 设置 PYTHON_HOME
ENV PYTHON_HOME=/usr/bin/python
ENV PYTHON_LAUNCHER=/usr/bin/python

# 设置 python 和 pip 命令指向 Python 3.11
RUN ln -sf /usr/bin/python3.11 /usr/bin/python && \
    rm -f /usr/bin/pip && \
    ln -s /usr/bin/pip3 /usr/bin/pip

# 验证 Python 和 pip 版本
RUN python --version && pip --version

RUN chsrc set python first

#RUN \cp -f /opt/hive/lib/mysql-connector-java.jar $DOLPHINSCHEDULER_HOME/libs/
RUN \cp -f /opt/hive/lib/mysql-connector-java.jar $DOLPHINSCHEDULER_HOME/alert-server/libs/ \
    && \cp -f /opt/hive/lib/mysql-connector-java.jar $DOLPHINSCHEDULER_HOME/api-server/libs/ \
    && \cp -f /opt/hive/lib/mysql-connector-java.jar $DOLPHINSCHEDULER_HOME/master-server/libs/ \
    && \cp -f /opt/hive/lib/mysql-connector-java.jar $DOLPHINSCHEDULER_HOME/tools/libs/ \
    && \cp -f /opt/hive/lib/mysql-connector-java.jar $DOLPHINSCHEDULER_HOME/worker-server/libs/

RUN apt-get update && apt-get install -y sudo

#RUN cp /opt/hadoop/etc/hadoop/core-site.xml $DOLPHINSCHEDULER_HOME/alert-server/conf/ && \
#    cp /opt/hadoop/etc/hadoop/core-site.xml $DOLPHINSCHEDULER_HOME/alert-server/conf/ && \
#    cp /opt/hadoop/etc/hadoop/hdfs-site.xml $DOLPHINSCHEDULER_HOME/api-server/conf/ && \
#    cp /opt/hadoop/etc/hadoop/hdfs-site.xml $DOLPHINSCHEDULER_HOME/api-server/conf/ && \
#    cp /opt/hadoop/etc/hadoop/core-site.xml $DOLPHINSCHEDULER_HOME/master-server/conf/ && \
#    cp /opt/hadoop/etc/hadoop/core-site.xml $DOLPHINSCHEDULER_HOME/master-server/conf/ && \
#    cp /opt/hadoop/etc/hadoop/hdfs-site.xml $DOLPHINSCHEDULER_HOME/tools/conf/ && \
#    cp /opt/hadoop/etc/hadoop/hdfs-site.xml $DOLPHINSCHEDULER_HOME/tools/conf/ && \
#    cp /opt/hadoop/etc/hadoop/hdfs-site.xml $DOLPHINSCHEDULER_HOME/worker-server/conf/ && \
#    cp /opt/hadoop/etc/hadoop/hdfs-site.xml $DOLPHINSCHEDULER_HOME/worker-server/conf/

WORKDIR $DOLPHINSCHEDULER_HOME

```

>RUN for server in alert-server api-server master-server worker-server; do \
>        sed -i 's|-cp "\$DOLPHINSCHEDULER_HOME/conf":"\$DOLPHINSCHEDULER_HOME/libs/\*"|-cp "\$DOLPHINSCHEDULER_HOME/'"$server"'/conf":"\$DOLPHINSCHEDULER_HOME/'"$server"'/libs/\*"|g' $DOLPHINSCHEDULER_HOME/$server/bin/start.sh; \
>    done
>
>这里需要多做一步，将原先的对应组件中start.sh脚本中的`-cp "$DOLPHINSCHEDULER_HOME/conf":"$DOLPHINSCHEDULER_HOME/libs/*"`替换成比如：`-cp "$DOLPHINSCHEDULER_HOME/master-server/conf":"$DOLPHINSCHEDULER_HOME/master-server/libs/*"`。否则在部署的时候会报错：**Error: Could not find or load main class org.apache.dolphinscheduler.server.master.MasterServer**

## 修改service-render下配置文件【可选】

`为了对应DOLPHINSCHEDULER_HOME3.1.9版本的配置文件，建议将service-render下相关的配置文件进行了调整。当然也可以直接不动-使用原先作者的也就是3.2.2版本的配置进行部署看看行不行，理论上是差不多的。`

jvm_args_env.sh.ftl和check_init_db.sh.ftl保持不变

### alert-application.yaml.ftl

```shell
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

spring:
  jackson:
    time-zone: UTC
    date-format: "yyyy-MM-dd HH:mm:ss"
  banner:
    charset: UTF-8
  datasource:
    driver-class-name: org.postgresql.Driver
    url: jdbc:postgresql://127.0.0.1:5432/dolphinscheduler
    username: root
    password: root
    hikari:
      connection-test-query: select 1
      minimum-idle: 5
      auto-commit: true
      validation-timeout: 3000
      pool-name: DolphinScheduler
      maximum-pool-size: 50
      connection-timeout: 30000
      idle-timeout: 600000
      leak-detection-threshold: 0
      initialization-fail-timeout: 1

server:
  port: ${conf['alert.server.port']}

management:
  endpoints:
    web:
      exposure:
        include: '*'
  endpoint:
    health:
      enabled: true
      show-details: always
  health:
    db:
      enabled: true
    defaults:
      enabled: false
  metrics:
    tags:
      application: ${r"${spring.application.name}"}

alert:
  port: ${conf['alert.rpc.port']}
  # Mark each alert of alert server if late after x milliseconds as failed.
  # Define value is (0 = infinite), and alert server would be waiting alert result.
  wait-timeout: 0

metrics:
  enabled: true

# Override by profile

---
spring:
  config:
    activate:
      on-profile: mysql
  datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: ${conf['jdbc.mysql.address']}
    username: ${conf['jdbc.mysql.username']}
    password: ${conf['jdbc.mysql.password']}

```

### api-application.yaml.ftl

```shell
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

server:
  port: ${conf['api.server.port']}
  servlet:
    session:
      timeout: 120m
    context-path: /dolphinscheduler/
  compression:
    enabled: true
    mime-types: text/html,text/xml,text/plain,text/css,text/javascript,application/javascript,application/json,application/xml
  jetty:
    max-http-form-post-size: 5000000

spring:
  banner:
    charset: UTF-8
  jackson:
    time-zone: UTC
    date-format: "yyyy-MM-dd HH:mm:ss"
  servlet:
    multipart:
      max-file-size: 1024MB
      max-request-size: 1024MB
  messages:
    basename: i18n/messages
  datasource:
    driver-class-name: org.postgresql.Driver
    url: jdbc:postgresql://127.0.0.1:5432/dolphinscheduler
    username: root
    password: root
    hikari:
      connection-test-query: select 1
      minimum-idle: 5
      auto-commit: true
      validation-timeout: 3000
      pool-name: DolphinScheduler
      maximum-pool-size: 50
      connection-timeout: 30000
      idle-timeout: 600000
      leak-detection-threshold: 0
      initialization-fail-timeout: 1
  quartz:
    auto-startup: false
    job-store-type: jdbc
    jdbc:
      initialize-schema: never
    properties:
      org.quartz.threadPool.threadPriority: 5
      org.quartz.jobStore.isClustered: true
      org.quartz.jobStore.class: org.springframework.scheduling.quartz.LocalDataSourceJobStore
      org.quartz.scheduler.instanceId: AUTO
      org.quartz.jobStore.tablePrefix: QRTZ_
      org.quartz.jobStore.acquireTriggersWithinLock: true
      org.quartz.scheduler.instanceName: DolphinScheduler
      org.quartz.threadPool.class: org.quartz.simpl.SimpleThreadPool
      org.quartz.jobStore.useProperties: false
      org.quartz.threadPool.makeThreadsDaemons: true
      org.quartz.threadPool.threadCount: 25
      org.quartz.jobStore.misfireThreshold: 60000
      org.quartz.scheduler.makeSchedulerThreadDaemon: true
      org.quartz.jobStore.driverDelegateClass: org.quartz.impl.jdbcjobstore.PostgreSQLDelegate
      org.quartz.jobStore.clusterCheckinInterval: 5000
  mvc:
    pathmatch:
      matching-strategy: ANT_PATH_MATCHER

management:
  endpoints:
    web:
      exposure:
        include: '*'
  endpoint:
    health:
      enabled: true
      show-details: always
  health:
    db:
      enabled: true
    defaults:
      enabled: false
  metrics:
    tags:
      application: ${r"${spring.application.name}"}

registry:
  type: zookeeper
  zookeeper:
    namespace: dolphinscheduler
    connect-string: ${r"${REGISTRY_ZOOKEEPER_CONNECT_STRING}"}
    retry-policy:
      base-sleep-time: 60ms
      max-sleep: 300ms
      max-retries: 5
    session-timeout: 30s
    connection-timeout: 9s
    block-until-connected: 600ms
    digest: ~

audit:
  enabled: false

metrics:
  enabled: true

python-gateway:
  # Weather enable python gateway server or not. The default value is true.
  enabled: true
  # Authentication token for connection from python api to python gateway server. Should be changed the default value
  # when you deploy in public network.
  auth-token: jwUDzpLsNKEFER4*a8gruBH_GsAurNxU7A@Xc
  # The address of Python gateway server start. Set its value to `0.0.0.0` if your Python API run in different
  # between Python gateway server. It could be be specific to other address like `127.0.0.1` or `localhost`
  gateway-server-address: 0.0.0.0
  # The port of Python gateway server start. Define which port you could connect to Python gateway server from
  # Python API side.
  gateway-server-port: 25333
  # The address of Python callback client.
  python-address: 127.0.0.1
  # The port of Python callback client.
  python-port: 25334
  # Close connection of socket server if no other request accept after x milliseconds. Define value is (0 = infinite),
  # and socket server would never close even though no requests accept
  connect-timeout: 0
  # Close each active connection of socket server if python program not active after x milliseconds. Define value is
  # (0 = infinite), and socket server would never close even though no requests accept
  read-timeout: 0

security:
  authentication:
    # Authentication types (supported types: PASSWORD,LDAP)
    type: PASSWORD
    # IF you set type `LDAP`, below config will be effective
    ldap:
      # ldap server config
      urls: ldap://ldap.forumsys.com:389/
      base-dn: dc=example,dc=com
      username: cn=read-only-admin,dc=example,dc=com
      password: password
      user:
        # admin userId when you use LDAP login
        admin: read-only-admin
        identity-attribute: uid
        email-attribute: mail
        # action when ldap user is not exist (supported types: CREATE,DENY)
        not-exist-action: CREATE

# Traffic control, if you turn on this config, the maximum number of request/s will be limited.
# global max request number per second
# default tenant-level max request number
traffic:
  control:
    global-switch: false
    max-global-qps-rate: 300
    tenant-switch: false
    default-tenant-qps-rate: 10
    #customize-tenant-qps-rate:
      # eg.
      #tenant1: 11
      #tenant2: 20


# Override by profile

---
spring:
  config:
    activate:
      on-profile: mysql
  datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: ${conf['jdbc.mysql.address']}
    username: ${conf['jdbc.mysql.username']}
    password: ${conf['jdbc.mysql.password']}
  quartz:
    properties:
      org.quartz.jobStore.driverDelegateClass: org.quartz.impl.jdbcjobstore.StdJDBCDelegate

```

### common.properties.ftl

```shell
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# user data local directory path, please make sure the directory exists and have read write permissions
data.basedir.path=/data/1

# resource view suffixs
#resource.view.suffixs=txt,log,sh,bat,conf,cfg,py,java,sql,xml,hql,properties,json,yml,yaml,ini,js

# resource storage type: HDFS, S3, OSS, NONE
resource.storage.type=HDFS
# resource store on HDFS/S3 path, resource file will store to this base path, self configuration, please make sure the directory exists on hdfs and have read write permissions. "/dolphinscheduler" is recommended
resource.storage.upload.base.path=/dolphinscheduler

# The AWS access key. if resource.storage.type=S3 or use EMR-Task, This configuration is required
resource.aws.access.key.id=minioadmin
# The AWS secret access key. if resource.storage.type=S3 or use EMR-Task, This configuration is required
resource.aws.secret.access.key=minioadmin
# The AWS Region to use. if resource.storage.type=S3 or use EMR-Task, This configuration is required
resource.aws.region=cn-north-1
# The name of the bucket. You need to create them by yourself. Otherwise, the system cannot start. All buckets in Amazon S3 share a single namespace; ensure the bucket is given a unique name.
resource.aws.s3.bucket.name=dolphinscheduler
# You need to set this parameter when private cloud s3. If S3 uses public cloud, you only need to set resource.aws.region or set to the endpoint of a public cloud such as S3.cn-north-1.amazonaws.com.cn
resource.aws.s3.endpoint=http://localhost:9000

# alibaba cloud access key id, required if you set resource.storage.type=OSS
resource.alibaba.cloud.access.key.id=<your-access-key-id>
# alibaba cloud access key secret, required if you set resource.storage.type=OSS
resource.alibaba.cloud.access.key.secret=<your-access-key-secret>
# alibaba cloud region, required if you set resource.storage.type=OSS
resource.alibaba.cloud.region=cn-hangzhou
# oss bucket name, required if you set resource.storage.type=OSS
resource.alibaba.cloud.oss.bucket.name=dolphinscheduler
# oss bucket endpoint, required if you set resource.storage.type=OSS
resource.alibaba.cloud.oss.endpoint=https://oss-cn-hangzhou.aliyuncs.com

# if resource.storage.type=HDFS, the user must have the permission to create directories under the HDFS root path
resource.hdfs.root.user=hdfs
<#assign hdfs=dependencies.HDFS />
<#if hdfs.serviceRoles['HDFS_NAMENODE']?size gt 1>
<#assign fs_default_uri = "hdfs://" + hdfs.conf['nameservices']>
</#if>
# if resource.storage.type=S3, the value like: s3a://dolphinscheduler; if resource.storage.type=HDFS and namenode HA is enabled, you need to copy core-site.xml and hdfs-site.xml to conf dir
resource.hdfs.fs.defaultFS=${fs_default_uri}

# whether to startup kerberos
hadoop.security.authentication.startup.state=false

# java.security.krb5.conf path
java.security.krb5.conf.path=/opt/krb5.conf

# login user from keytab username
login.user.keytab.username=hdfs-mycluster@ESZ.COM

# login user from keytab path
login.user.keytab.path=/opt/hdfs.headless.keytab

# kerberos expire time, the unit is hour
kerberos.expire.time=2

<#assign yarn=dependencies.YARN />
<#assign
rm_port=yarn.conf['resourcemanager.port']
rm_webapp_port=yarn.conf['resourcemanager.webapp.port']
>
<#assign rmIds = []>
<#list yarn.serviceRoles['YARN_RESOURCEMANAGER'] as rm>
    <#assign rmIds = rmIds + [rm.hostname + ":" + rm_port]>
</#list>
<#assign rm_Ids = rmIds?join(",")>
# resourcemanager port, the default value is 8088 if not specified
resource.manager.httpaddress.port=${rm_webapp_port}
# if resourcemanager HA is enabled, please set the HA IPs; if resourcemanager is single, keep this value empty
yarn.resourcemanager.ha.rm.ids=${rm_Ids}
# if resourcemanager HA is enabled or not use resourcemanager, please keep the default value; If resourcemanager is single, you only need to replace ds1 to actual resourcemanager hostname
yarn.application.status.address=http://ds1:%s/ws/v1/cluster/apps/%s
# job history status url when application number threshold is reached(default 10000, maybe it was set to 1000)
yarn.job.history.status.address=http://ds1:19888/ws/v1/history/mapreduce/jobs/%s

# datasource encryption enable
datasource.encryption.enable=false

# datasource encryption salt
datasource.encryption.salt=!@#$%^&*

# data quality option
data-quality.jar.name=dolphinscheduler-data-quality-dev-SNAPSHOT.jar

#data-quality.error.output.path=/tmp/data-quality-error-data

# Network IP gets priority, default inner outer

# Whether hive SQL is executed in the same session
support.hive.oneSession=false

# use sudo or not, if set true, executing user is tenant user and deploy user needs sudo permissions; if set false, executing user is the deploy user and doesn't need sudo permissions
sudo.enable=true
setTaskDirToTenant.enable=false

# network interface preferred like eth0, default: empty
#dolphin.scheduler.network.interface.preferred=

# network IP gets priority, default: inner outer
#dolphin.scheduler.network.priority.strategy=default

# system env path
#dolphinscheduler.env.path=dolphinscheduler_env.sh

# development state
development.state=false

# rpc port
alert.rpc.port=${conf['alert.rpc.port']}

# set path of conda.sh
conda.path=/opt/anaconda3/etc/profile.d/conda.sh

# Task resource limit state
task.resource.limit.state=false

# mlflow task plugin preset repository
ml.mlflow.preset_repository=https://github.com/apache/dolphinscheduler-mlflow
# mlflow task plugin preset repository version
ml.mlflow.preset_repository_version="main"
```

### dolphinscheduler_env.sh.ftl

```shell
# JAVA_HOME, will use it to start DolphinScheduler server
# export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Database related configuration, set database type, username and password
export DATABASE=mysql
# worker不能使用mysql环境，会报错
<#if ROLE_FULL_NAME != "ds-worker">
export SPRING_PROFILES_ACTIVE=$DATABASE
</#if>
export SPRING_DATASOURCE_URL="${conf['jdbc.mysql.address']}"
export SPRING_DATASOURCE_USERNAME=${conf['jdbc.mysql.username']}
export SPRING_DATASOURCE_PASSWORD=${conf['jdbc.mysql.password']}


# DolphinScheduler server related configuration
export SPRING_CACHE_TYPE=none
export SPRING_JACKSON_TIME_ZONE=GMT+8
<#--handle dependent.zookeeper-->
<#if dependencies.ZOOKEEPER??>
    <#assign zookeeper=dependencies.ZOOKEEPER quorum=[]>
    <#list zookeeper.serviceRoles['ZOOKEEPER_SERVER'] as role>
        <#assign quorum += [role.hostname + ":" + zookeeper.conf["zookeeper.client.port"]]>
    </#list>
</#if>
# Registry center configuration, determines the type and link of the registry center
export REGISTRY_TYPE=zookeeper
export REGISTRY_ZOOKEEPER_CONNECT_STRING=${quorum?join(",")}

```

### master-application.yaml.ftl

```shell
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
spring:
  banner:
    charset: UTF-8
  jackson:
    time-zone: UTC
    date-format: "yyyy-MM-dd HH:mm:ss"
  cache:
    # default enable cache, you can disable by `type: none`
    type: none
    cache-names:
      - tenant
      - user
      - processDefinition
      - processTaskRelation
      - taskDefinition
    caffeine:
      spec: maximumSize=100,expireAfterWrite=300s,recordStats
  datasource:
    driver-class-name: org.postgresql.Driver
    url: jdbc:postgresql://127.0.0.1:5432/dolphinscheduler
    username: root
    password: root
    hikari:
      connection-test-query: select 1
      minimum-idle: 5
      auto-commit: true
      validation-timeout: 3000
      pool-name: DolphinScheduler
      maximum-pool-size: 50
      connection-timeout: 30000
      idle-timeout: 600000
      leak-detection-threshold: 0
      initialization-fail-timeout: 1
  quartz:
    job-store-type: jdbc
    jdbc:
      initialize-schema: never
    properties:
      org.quartz.threadPool.threadPriority: 5
      org.quartz.jobStore.isClustered: true
      org.quartz.jobStore.class: org.springframework.scheduling.quartz.LocalDataSourceJobStore
      org.quartz.scheduler.instanceId: AUTO
      org.quartz.jobStore.tablePrefix: QRTZ_
      org.quartz.jobStore.acquireTriggersWithinLock: true
      org.quartz.scheduler.instanceName: DolphinScheduler
      org.quartz.threadPool.class: org.quartz.simpl.SimpleThreadPool
      org.quartz.jobStore.useProperties: false
      org.quartz.threadPool.makeThreadsDaemons: true
      org.quartz.threadPool.threadCount: 25
      org.quartz.jobStore.misfireThreshold: 60000
      org.quartz.scheduler.batchTriggerAcquisitionMaxCount: 1
      org.quartz.scheduler.makeSchedulerThreadDaemon: true
      org.quartz.jobStore.driverDelegateClass: org.quartz.impl.jdbcjobstore.PostgreSQLDelegate
      org.quartz.jobStore.clusterCheckinInterval: 5000

registry:
  type: zookeeper
  zookeeper:
    namespace: dolphinscheduler
    connect-string: ${r"${REGISTRY_ZOOKEEPER_CONNECT_STRING}"}
    retry-policy:
      base-sleep-time: 60ms
      max-sleep: 300ms
      max-retries: 5
    session-timeout: 30s
    connection-timeout: 9s
    block-until-connected: 600ms
    digest: ~

master:
  listen-port: ${conf['master.server.listen.port']}
  # master fetch command num
  fetch-command-num: 10
  # master prepare execute thread number to limit handle commands in parallel
  pre-exec-threads: 10
  # master execute thread number to limit process instances in parallel
  exec-threads: 100
  # master dispatch task number per batch, if all the tasks dispatch failed in a batch, will sleep 1s.
  dispatch-task-number: 3
  # master host selector to select a suitable worker, default value: LowerWeight. Optional values include random, round_robin, lower_weight
  host-selector: lower_weight
  # master heartbeat interval
  heartbeat-interval: 10s
  # master commit task retry times
  task-commit-retry-times: 5
  # master commit task interval
  task-commit-interval: 1s
  state-wheel-interval: 5s
  # master max cpuload avg, only higher than the system cpu load average, master server can schedule. default value -1: the number of cpu cores * 2
  max-cpu-load-avg: -1
  # master reserved memory, only lower than system available memory, master server can schedule. default value 0.3, the unit is G
  reserved-memory: 0.3
  # failover interval, the unit is minute
  failover-interval: 10m
  # kill yarn jon when failover taskInstance, default true
  kill-yarn-job-when-task-failover: true
  registry-disconnect-strategy:
    # The disconnect strategy: stop, waiting
    strategy: waiting
    # The max waiting time to reconnect to registry if you set the strategy to waiting
    max-waiting-time: 100s
  worker-group-refresh-interval: 10s

server:
  port: ${conf['master.server.port']}

management:
  endpoints:
    web:
      exposure:
        include: '*'
  endpoint:
    health:
      enabled: true
      show-details: always
  health:
    db:
      enabled: true
    defaults:
      enabled: false
  metrics:
    tags:
      application: ${r"${spring.application.name}"}

metrics:
  enabled: true

# Override by profile

---
spring:
  config:
    activate:
      on-profile: mysql
  datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: ${conf['jdbc.mysql.address']}
    username: ${conf['jdbc.mysql.username']}
    password: ${conf['jdbc.mysql.password']}
  quartz:
    properties:
      org.quartz.jobStore.driverDelegateClass: org.quartz.impl.jdbcjobstore.StdJDBCDelegate

```

### tool-application.yaml.ftl

```shell
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
spring:
  main:
    banner-mode: off
  datasource:
    driver-class-name: org.postgresql.Driver
    url: jdbc:postgresql://127.0.0.1:5432/dolphinscheduler
    username: root
    password: root
    hikari:
      connection-test-query: select 1
      minimum-idle: 5
      auto-commit: true
      validation-timeout: 3000
      pool-name: DolphinScheduler
      maximum-pool-size: 50
      connection-timeout: 30000
      idle-timeout: 600000
      leak-detection-threshold: 0
      initialization-fail-timeout: 1

# Override by profile

---
spring:
  config:
    activate:
      on-profile: mysql
  datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: ${conf['jdbc.mysql.address']}
    username: ${conf['jdbc.mysql.username']}
    password: ${conf['jdbc.mysql.password']}

---
spring:
  config:
    activate:
      on-profile: postgresql
  datasource:
    driver-class-name: org.postgresql.Driver

```

### worker-application.yaml.ftl

```shell
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
spring:
  banner:
    charset: UTF-8
  jackson:
    time-zone: UTC
    date-format: "yyyy-MM-dd HH:mm:ss"
  datasource:
    driver-class-name: org.postgresql.Driver
    url: jdbc:postgresql://127.0.0.1:5432/dolphinscheduler
    username: root
    password: root
    hikari:
      connection-test-query: select 1
      minimum-idle: 5
      auto-commit: true
      validation-timeout: 3000
      pool-name: DolphinScheduler
      maximum-pool-size: 50
      connection-timeout: 30000
      idle-timeout: 600000
      leak-detection-threshold: 0
      initialization-fail-timeout: 1

registry:
  type: zookeeper
  zookeeper:
    namespace: dolphinscheduler
    connect-string: ${r"${REGISTRY_ZOOKEEPER_CONNECT_STRING}"}
    retry-policy:
      base-sleep-time: 60ms
      max-sleep: 300ms
      max-retries: 5
    session-timeout: 30s
    connection-timeout: 9s
    block-until-connected: 600ms
    digest: ~

worker:
  # worker listener port
  listen-port: ${conf['worker.server.listener.port']}
  # worker execute thread number to limit task instances in parallel
  exec-threads: 100
  # worker heartbeat interval
  heartbeat-interval: 10s
  # worker host weight to dispatch tasks, default value 100
  host-weight: 100
  # tenant corresponds to the user of the system, which is used by the worker to submit the job. If system does not have this user, it will be automatically created after the parameter worker.tenant.auto.create is true.
  tenant-auto-create: true
  #Scenes to be used for distributed users.For example,users created by FreeIpa are stored in LDAP.This parameter only applies to Linux, When this parameter is true, worker.tenant.auto.create has no effect and will not automatically create tenants.
  tenant-distributed-user: false
  # worker max cpuload avg, only higher than the system cpu load average, worker server can be dispatched tasks. default value -1: the number of cpu cores * 2
  max-cpu-load-avg: -1
  # worker reserved memory, only lower than system available memory, worker server can be dispatched tasks. default value 0.3, the unit is G
  reserved-memory: 0.3
  # alert server listen host
  alert-listen-host: localhost
  alert-listen-port: 50052
  registry-disconnect-strategy:
    # The disconnect strategy: stop, waiting
    strategy: waiting
    # The max waiting time to reconnect to registry if you set the strategy to waiting
    max-waiting-time: 100s
  task-execute-threads-full-policy: REJECT

server:
  port: ${conf['worker.server.port']}

management:
  endpoints:
    web:
      exposure:
        include: '*'
  endpoint:
    health:
      enabled: true
      show-details: always
  health:
    db:
      enabled: true
    defaults:
      enabled: false
  metrics:
    tags:
      application: ${r"${spring.application.name}"}

metrics:
  enabled: true

# Override by profile

---
spring:
  config:
    activate:
      on-profile: mysql
  datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: ${conf['jdbc.mysql.address']}
    username: ${conf['jdbc.mysql.username']}
    password: ${conf['jdbc.mysql.password']}

```

## 安装部署

略