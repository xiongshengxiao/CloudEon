# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

status = INFO
name = HiveExecLog4j2
packages = org.apache.hadoop.hive.ql.log

# list of properties
property.hive.log.level = INFO
property.hive.root.logger = FA
property.hive.query.id = hadoop
property.hive.log.dir = /workspace/logs
property.hive.log.file = ${r"${sys:hive.query.id}"}.log

# list of all appenders
appenders = console, FA

# console appender
appender.console.type = Console
appender.console.name = console
appender.console.target = SYSTEM_ERR
appender.console.layout.type = PatternLayout
appender.console.layout.pattern = %d{yyyy-MM-dd HH:mm:ss} %p %c{2}: %m%n

# simple file appender
appender.FA.type = RandomAccessFile
appender.FA.name = FA
appender.FA.fileName = ${r"${sys:hive.log.dir}"}/${r"${sys:hive.log.file}"}
appender.FA.layout.type = PatternLayout
appender.FA.layout.pattern =  %d{yyyy-MM-dd HH:mm:ss} %p %c{2}: %m%n

# list of all loggers
loggers = NIOServerCnxn, ClientCnxnSocketNIO, DataNucleus, Datastore, JPOX

logger.NIOServerCnxn.name = org.apache.zookeeper.server.NIOServerCnxn
logger.NIOServerCnxn.level = WARN

logger.ClientCnxnSocketNIO.name = org.apache.zookeeper.ClientCnxnSocketNIO
logger.ClientCnxnSocketNIO.level = WARN

logger.DataNucleus.name = DataNucleus
logger.DataNucleus.level = ERROR

logger.Datastore.name = Datastore
logger.Datastore.level = ERROR

logger.JPOX.name = JPOX
logger.JPOX.level = ERROR

# root logger
rootLogger.level = ${r"${sys:hive.log.level}"}
rootLogger.appenderRefs = root
rootLogger.appenderRef.root.ref = ${r"${sys:hive.root.logger}"}
