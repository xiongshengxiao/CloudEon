<#assign jvmRamPercentage = conf['seatunnel.worker.jvm.memory.percentage']?number>
<#assign metaspaceRamPercentage = conf['seatunnel.worker.metaspace.memory.percentage']?number>
<#assign limitMb = conf['seatunnel.worker.container.limit.memory']?number>
<#assign jvmHeapMb = (limitMb * jvmRamPercentage /100)?floor?c>
<#assign metaspaceMb = (limitMb * metaspaceRamPercentage /100)?floor?c>
# JVM Heap
-Xms${jvmHeapMb}M
-Xmx${jvmHeapMb}M

# JVM Dump
-XX:+HeapDumpOnOutOfMemoryError
-XX:HeapDumpPath=/data/1/dump/zeta-server

# Metaspace
-XX:MaxMetaspaceSize=${metaspaceMb}M

# G1GC
-XX:+UseG1GC
