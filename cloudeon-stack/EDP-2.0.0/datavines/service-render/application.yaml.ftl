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
    allow-circular-references: true
  application:
    name: datavines-server
  datasource:
    driver-class-name: org.postgresql.Driver
    url: jdbc:postgresql://127.0.0.1:5432/datavines
    username: postgres
    password: 123456
    hikari:
      connection-test-query: select 1
      minimum-idle: 5
      auto-commit: true
      validation-timeout: 3000
      pool-name: datavines
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
      org.quartz.scheduler.instanceName: datavines
      org.quartz.threadPool.class: org.quartz.simpl.SimpleThreadPool
      org.quartz.jobStore.useProperties: false
      org.quartz.threadPool.makeThreadsDaemons: true
      org.quartz.threadPool.threadCount: 25
      org.quartz.jobStore.misfireThreshold: 60000
      org.quartz.scheduler.batchTriggerAcquisitionMaxCount: 1
      org.quartz.scheduler.makeSchedulerThreadDaemon: true
      org.quartz.jobStore.driverDelegateClass: org.quartz.impl.jdbcjobstore.PostgreSQLDelegate
      org.quartz.jobStore.clusterCheckinInterval: 5000
  mvc:
    pathmatch:
      matching-strategy: ant_path_matcher

mybatis-plus:
  type-enums-package: io.datavines.*.enums
#  configuration:
#    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl

server:
  port: ${conf['datavines.server.port']}

management:
  endpoints:
    web:
      exposure:
        include: '*'
  metrics:
    tags:
      application: ${r"${spring.application.name}"}

logging:
  config: classpath:server-logback.xml
---
spring:
  config:
    activate:
      on-profile: mysql
  datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://${conf['jdbc.mysql.host']}:${conf['jdbc.mysql.port']}/datavines?useUnicode=true&characterEncoding=UTF-8&useSSL=false&serverTimezone=Asia/Shanghai
    username: ${conf['jdbc.mysql.username']}
    password: ${conf['jdbc.mysql.password']}
  quartz:
    properties:
      org.quartz.jobStore.driverDelegateClass: org.quartz.impl.jdbcjobstore.StdJDBCDelegate
