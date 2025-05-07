# 1. 进入api实例的web界面

默认账号密码：admin/dolphinscheduler123

# 2. 创建环境

安全中心-环境管理-创建环境，填入以下配置：

```shell
export PYTHON_HOME=/usr/bin/python
export PYTHON_LAUNCHER=/usr/bin/python
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export FLINK_HOME=/opt/flink
export HIVE_HOME=/opt/hive
export HADOOP_HOME=/opt/hadoop
export SPARK_HOME=/opt/spark
export PATH=$FLINK_HOME/bin:$HIVE_HOME/bin:$HADOOP_HOME/bin:$SPARK_HOME/bin:$JAVA_HOME/bin:$PYTHON_HOME:$PATH
export HADOOP_CLASSPATH=$(hadoop classpath)
```

# 3. 创建项目

# 4. 创建工作流