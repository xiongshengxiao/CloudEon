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
<#assign hdfs=dependencies.HDFS>
<#if hdfs.serviceRoles['HDFS_NAMENODE']?size gt 1>
    <#assign fs_default_uri = "hdfs://" + hdfs.conf['nameservices']>
<#else >
    <#assign
    namenode=hdfs.serviceRoles['HDFS_NAMENODE'][0].hostname
    namenodeport=hdfs.conf['namenode.rpc-port']
    fs_default_uri = "hdfs://" + namenode + ":" + namenodeport
    >
</#if>
<#assign  ns=hdfs.conf['nameservices']>
seatunnel:
  engine:
    history-job-expire-minutes: 1440
    backup-count: 1
    queue-type: blockingqueue
    print-execution-info-interval: 60
    print-job-metrics-info-interval: 60
    slot-service:
      dynamic-slot: true
    telemetry:
      metric:
        enabled: false
    checkpoint:
      interval: 10000
      timeout: 60000
      storage:
        type: hdfs
        max-retained: 3
        plugin-config:
          namespace: ${conf['seatunnel.checkpoint.storage']?ensure_ends_with("/")}
          storage.type: hdfs
          disable.cache: false
          fs.defaultFS: ${fs_default_uri}
          seatunnel.hadoop.dfs.nameservices: ${hdfs.conf['nameservices']}
          hdfs_site_path: /opt/seatunnel/hadoop_conf/hdfs-site.xml
  map:
   engine*:
    map-store:
      enabled: true
      initial-mode: EAGER
      factory-class-name: org.apache.seatunnel.engine.server.persistence.FileMapStoreFactory
      properties:
        type: hdfs
        namespace: ${conf['seatunnel.imap.storage']?ensure_ends_with("/")}
        clusterName: seatunnel-cluster
        storage.type: hdfs
        fs.defaultFS: ${fs_default_uri}
        seatunnel.hadoop.dfs.nameservices: ${hdfs.conf['nameservices']}
        hdfs_site_path: /opt/seatunnel/hadoop_conf/hdfs-site.xml
