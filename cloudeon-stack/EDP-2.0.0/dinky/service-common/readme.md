# 1. 创建yarn集群，填入如下配置

Hadoop配置文件路径：/opt/hadoop/etc/hadoop
Flink Lib 路径：hdfs:///dinky/flink-lib/1.15.4
Flink 配置文件路径: /opt/flink/conf
Jar 文件路径: hdfs:///dinky/jar/dinky-app-1.15-1.1.0.jar

# 2. 在yarn集群下启动session集群

# 3. 可以在flink实例里面看到自动注册的session集群

# 4. 在数据开发界面创建sql任务，内容如下

可以选择本地运行或 yarn application 模式运行

```shell
DROP table if exists datagen;
CREATE TABLE datagen (
  a INT,
  b varchar
) WITH (
  'connector' = 'datagen',
  'rows-per-second' = '1',
  'number-of-rows' = '50'
);
DROP table if exists print_table;
CREATE TABLE print_table (
  a INT,
  b varchar
) WITH (
  'connector'='print'
);


insert into print_table  select a,b from datagen ;
```