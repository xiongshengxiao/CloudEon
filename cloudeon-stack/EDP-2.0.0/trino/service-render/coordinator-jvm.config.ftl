<#assign ramPercentage = conf['trino.coordinator.jvm.memory.percentage']?number>
<#assign ramMb = conf['trino.coordinator.container.limit.memory']?number>
<#assign serverHeap = (ramMb * ramPercentage /100)?floor?c>
-server
-Xmx${serverHeap}M
-agentpath:${TRINO_HOME}/bin/libjvmkill.so
-XX:InitialRAMPercentage=80
-XX:MaxRAMPercentage=80
-XX:G1HeapRegionSize=32M
-XX:+ExplicitGCInvokesConcurrent
-XX:+HeapDumpOnOutOfMemoryError
-XX:+ExitOnOutOfMemoryError
-XX:-OmitStackTraceInFastThrow
-XX:ReservedCodeCacheSize=256M
-XX:PerMethodRecompilationCutoff=10000
-XX:PerBytecodeRecompilationCutoff=10000
-Djdk.attach.allowAttachSelf=true
-Djdk.nio.maxCachedBufferSize=2000000
# Improve AES performance for S3, etc. on ARM64 (JDK-8271567)
-XX:+UnlockDiagnosticVMOptions
-XX:+UseAESCTRIntrinsics
# Disable Preventive GC for performance reasons (JDK-8293861)
-XX:-G1UsePreventiveGC
-Dfile.encoding=UTF-8
-Dcom.sun.management.jmxremote.port=9080
-Dcom.sun.management.jmxremote.rmi.port=9081
-Dcom.sun.management.jmxremote
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false
-javaagent:/opt/jmx_exporter/jmx_prometheus_javaagent.jar=8098:${TRINO_HOME}/conf/jmx_prometheus.yaml
-Xlog:gc*:file=/workspace/logs/gc-trino-coordinator.log:time
