# CloudEon 安装指南

## 1. 生成安装包

执行以下命令生成 Cloudeon 安装包：

```shell
mvn clean package -Dmaven.test.skip
```

生成的安装包位于 cloudeon-assembly/target 目录下，格式为 .tar.gz 或 .zip。

## 二 构建并推送镜像

### 1.构建Docker镜像

```shell
file_path="../cloudeon-assembly/target/cloudeon-assembly-v2.0.0-beta.2-release.tar.gz"
# 提取文件名部分
filename="${file_path##*/}"
cp $file_path ./
# 去掉前缀和后缀
version="${filename#cloudeon-assembly-}"
version="${version%-release*}"

docker build --build-arg CLOUDEON_VERSION=$version \
             -t registry.cn-guangzhou.aliyuncs.com/bigdata200/cloudeon:$version .

rm -f ./$filename

```

### 2.推送 Docker 镜像

执行以下命令将镜像推送到 Docker 仓库：
```shell
docker push registry.cn-guangzhou.aliyuncs.com/bigdata200/cloudeon:$version

```

## 三 运行 Cloudeon 容器

### 1.内置H2数据库运行

/opt/cloudeon/db 将用来存储h2文件
```shell
image=registry.cn-guangzhou.aliyuncs.com/bigdata200/cloudeon:v2.0.0-beta.2

docker run -d --name cloudeon \
 -p 7700:7700 \
 -v /opt/cloudeon/db:/opt/cloudeon/db \
 $image

```

### 2.mysql数据库运行

使用默认配置运行 Cloudeon 容器：

```shell
image=registry.cn-guangzhou.aliyuncs.com/bigdata200/cloudeon:v2.0.0-beta.2

docker run -d --name cloudeon \
 -p 7700:7700 \
 -e DB_ACTIVE=mysql \
 -e MYSQL_HOST=host.docker.internal \
 -e MYSQL_PORT=3306 \
 -e MYSQL_DB_NAME=cloudeon \
 -e MYSQL_USER=root \
 -e MYSQL_PASSWORD=1qaz@WSX \
 $image

```

### 3.挂载自定义配置文件和组件模板运行

可以将配置文件和组件模板复制到外部，然后在容器中使用，以此获得最大灵活度。

#### 获取配置文件
```shell
image=registry.cn-guangzhou.aliyuncs.com/bigdata200/cloudeon:v2.0.0-beta.2
conf_path_dir=/opt/cloudeon

# 运行临时容器把配置文件复制到外部，如果已有配置文件则此步骤可以跳过
docker run --rm \
--entrypoint /bin/bash \
-v $conf_path_dir:/data/workspace \
$image \
-c "cp -r  /opt/cloudeon/conf /data/workspace/conf && cp -r /opt/cloudeon/stack /data/workspace/stack"

```

然后就可以根据需求配置文件或部署模板了

#### 挂载文件并运行

```
image=registry.cn-guangzhou.aliyuncs.com/bigdata200/cloudeon:v2.0.0-beta.2
conf_path_dir=/opt/cloudeon
docker rm -f cloudeon
docker run -d --name cloudeon \
 -e DB_ACTIVE=mysql \
 -e MYSQL_HOST=host.docker.internal \
 -e MYSQL_PORT=3306 \
 -e MYSQL_DB_NAME=cloudeon \
 -e MYSQL_USER=root \
 -e MYSQL_PASSWORD=1qaz@WSX \
-v $conf_path_dir/conf:/opt/cloudeon/conf \
-v $conf_path_dir/stack:/opt/cloudeon/stack \
-v $conf_path_dir/tmp:/opt/cloudeon/tmp \
-p 7700:7700 $image

docker logs --tail 100 -f cloudeon

```