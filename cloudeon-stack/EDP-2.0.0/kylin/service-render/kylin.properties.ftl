#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Kylin provides two configuration profiles: minimal and production(by default).
# To switch to minimal: uncomment the properties
kylin.storage.columnar.spark-conf.spark.driver.memory=512m
kylin.storage.columnar.spark-conf.spark.executor.memory=512m
kylin.storage.columnar.spark-conf.spark.executor.memoryOverhead=512m
<#noparse >
kylin.storage.columnar.spark-conf.spark.executor.extraJavaOptions=-Dhdp.version=current -Dlog4j.configurationFile=spark-executor-log4j.xml -Dlog4j.debug -Dkylin.hdfs.working.dir=${kylin.env.hdfs-working-dir} -Dkap.metadata.identifier=${kylin.metadata.url.identifier} -Dkap.spark.category=sparder -Dkap.spark.project=${job.project} -XX:MaxDirectMemorySize=512M
</#noparse>
kylin.storage.columnar.spark-conf.spark.yarn.am.memory=512m
kylin.storage.columnar.spark-conf.spark.executor.cores=1
kylin.storage.columnar.spark-conf.spark.executor.instances=1
kylin.storage.columnar.spark-conf.spark.sql.adaptive.coalescePartitions.minPartitionNum=1
kylin.metadata.history-source-usage-unwrap-computed-column=true
## Working folder in HDFS, better be qualified absolute path, make sure user has the right permission to this directory
kylin.env.hdfs-working-dir=/kylin
## The build engine writes data to this file system, which is the same as defaultFS in core-site-xml by default
#kylin.env.engine-write-fs=
## zookeeper is used for distributed locked, service discovery, leader selection, etc.
## example: kylin.env.zookeeper-connect-string=10.1.2.1:2181,10.1.2.2:2181,10.1.2.3:2181

<#if dependencies.ZOOKEEPER??>
    <#assign zookeeper=dependencies.ZOOKEEPER quorum=[]>
    <#list zookeeper.serviceRoles['ZOOKEEPER_SERVER'] as role>
        <#assign quorum += [role.hostname + ":" + zookeeper.conf["zookeeper.client.port"]]>
    </#list>

</#if>

server.port=${conf['kylin.ui.port']}
kylin.query.init-sparder-async=false
# 关闭随机生成，使ADMIN的密码为KYLIN，否则随机生成
kylin.metadata.random-admin-password.enabled=false
kylin.env.apache-hadoop-conf-dir=$HADOOP_CONF_DIR
kylin.env.apache-hive-conf-dir=$HIVE_HOME/conf
kylin.metadata.url=kylin@jdbc,driverClassName=${conf['ConnectionDriverName']},url=${conf['ConnectionURL']},username=${conf['ConnectionUserName']},password=${conf['ConnectionPassword']},maxTotal=50,maxIdle=8
kylin.env.zookeeper-connect-string=${quorum?join(",")}
kylin.env.hdfs-working-dir=${conf['kylin.hdfs.work.dir']}

<#list confFiles['kylin.properties'] as key, value>
    ${key}=${value}
</#list>