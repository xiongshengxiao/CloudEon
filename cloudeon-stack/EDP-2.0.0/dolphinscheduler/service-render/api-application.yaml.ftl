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
