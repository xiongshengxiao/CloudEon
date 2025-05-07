#!/bin/bash

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
<#assign ramPercentage = conf['kylin.jvm.memory.percentage']?number>
<#assign ramMb = conf['kylin.container.limit.memory']?number>
<#assign serverHeap = (ramMb * ramPercentage /100)?floor?c>
<#assign serverHeapXms = (ramMb * ramPercentage /800)?floor?c>
export JAVA_VM_XMS=${serverHeapXms}M
export JAVA_VM_XMX=${serverHeap}M

# 以下两个如果不设置，会自动使用JAVA_VM_XMS和JAVA_VM_XMX的值
# export JAVA_VM_TOOL_XMS=1g
# export JAVA_VM_TOOL_XMX=8g

# uncomment following to for it to take effect(the values need adjusting to fit your env)
#export KYLIN_DEBUG_SETTINGS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false"

# uncomment following to for it to take effect(the values need adjusting to fit your env)
#export KYLIN_LD_LIBRARY_SETTINGS="-Djava.library.path=/apache/hadoop/lib/native/Linux-amd64-64"

# Newer versions of glibc use an arena memory allocator that causes virtual
# memory usage to explode. Tune the variable down to prevent vmem explosion.
# See HADOOP-7154.

<#noparse >
export MALLOC_ARENA_MAX=4
export KYLIN_JVM_SETTINGS="-server -Xms${JAVA_VM_XMS} -Xmx${JAVA_VM_XMX} -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:G1HeapRegionSize=16m -XX:+PrintFlagsFinal -XX:+PrintReferenceGC -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+PrintAdaptiveSizePolicy -XX:+UnlockDiagnosticVMOptions -XX:+G1SummarizeConcMark -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=${KYLIN_HOME}/logs -Xloggc:${KYLIN_HOME}/logs/gc-kylin-server.log  -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=64M -Dlog4j2.contextSelector=org.apache.logging.log4j.core.async.AsyncLoggerContextSelector -DAsyncLogger.RingBufferSize=8192"
export KYLIN_JVM_SETTINGS="$KYLIN_JVM_SETTINGS  -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=9926 -javaagent:/opt/jmx_exporter/jmx_prometheus_javaagent.jar=5556:${KYLIN_HOME}/conf/jmx_prometheus.yaml"
</#noparse>