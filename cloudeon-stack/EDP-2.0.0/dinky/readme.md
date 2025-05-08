
# 镜像制作要求
* 镜像所用操作系统基于 RockyLinux 9.5，或者 Ubuntu；
* 适配 Flink 1.20.1；
* 不依赖于 HADOOP（HDFS、YARN）；
* 不依赖于 ZooKeeper；
* 适配 K8s native application 模式提交；
* 支持 Python UDF；
* 包含 MySQL/Postgres/Oracle/SQL Server等常用关系数据库驱动；
* 包含 Kafka, Doris, Flink CDC, Paimon 等连接器及相关依赖；


[root@data-dev00 dinky]# tree dinky-release-1.20-1.2.3/extends/
dinky-release-1.20-1.2.3/extends/
├── avro-1.11.3.jar
├── commons-cli-1.7.0.jar
├── flink-cdc-common-3.3.0.jar
├── flink-cdc-pipeline-connector-doris-3.3.0.jar
├── flink-cdc-pipeline-connector-kafka-3.3.0.jar
├── flink-cdc-pipeline-connector-mysql-3.3.0.jar
├── flink-cdc-pipeline-connector-paimon-3.3.0.jar
├── flink-cdc-runtime-3.3.0.jar
├── flink-shaded-hadoop-3-uber-3.1.1.7.2.9.0-173-9.0.jar
├── flink-shaded-zookeeper-3.5.9.jar
├── flink-sql-connector-mysql-cdc-3.3.0.jar
├── flink-sql-connector-oracle-cdc-3.3.0.jar
├── flink-sql-connector-postgres-cdc-3.3.0.jar
├── flink-sql-connector-sqlserver-cdc-3.3.0.jar
├── flink1.20
│   ├── dinky
│   │   ├── dinky-catalog-mysql-1.20-1.2.3.jar
│   │   ├── dinky-catalog-postgres-1.20-1.2.3.jar
│   │   └── dinky-client-1.20-1.2.3.jar
│   ├── flink-avro-1.20.1.jar
│   ├── flink-cep-1.20.1.jar
│   ├── flink-connector-files-1.20.1.jar
│   ├── flink-connector-jdbc-3.2.0-1.19.jar
│   ├── flink-csv-1.20.1.jar
│   ├── flink-dist-1.20.1.jar
│   ├── flink-doris-connector-1.20-24.1.0.jar
│   ├── flink-json-1.20.1.jar
│   ├── flink-python-1.20.1.jar
│   ├── flink-scala_2.12-1.20.1.jar
│   ├── flink-sql-connector-kafka-3.4.0-1.20.jar
│   ├── flink-table-api-java-uber-1.20.1.jar
│   ├── flink-table-planner_2.12-1.20.1.jar
│   ├── flink-table-runtime-1.20.1.jar
│   └── paimon-flink-1.20-1.0.1.jar
├── javax.ws.rs-api-2.0.1.jar
├── kafka-clients-3.6.2.jar
├── kafka_2.12-3.6.2.jar
├── mssql-jdbc-12.6.1.jre8.jar
├── mysql-connector-j-8.4.0.jar
├── ojdbc8-23.6.0.24.10.jar
├── orai18n-23.6.0.24.10.jar
├── paimon-flink-action-1.0.1.jar
├── paimon-flink-cdc-1.0.1.jar
├── paimon-s3-1.0.1.jar
└── postgresql-42.7.3.jar
