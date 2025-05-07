# Docker部署

## 容器运行

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
docker rm -f cloudeon
image=registry.cn-guangzhou.aliyuncs.com/bigdata200/cloudeon:v2.0.0-beta.2
conf_path_dir=/opt/cloudeon
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

镜像启动成功后，在浏览器中访问 http://docker_ip:7700 进入登录页。
镜像中提供初始账户，用户名 admin 密码 admin

## 操作

### 新增集群

点击右上角"新增集群"，在弹窗中输入/选择以下配置

- 集群名称：自定义即可
- kubernetes命名空间：需提前创建，参考命令为 `kubectl create ns cloudeon`
- 框架：EDP-2.0.0
- kubeConfig：k8s配置信息，获取命令可以参考`cat $HOME/.kube/config`或`kubectl config view --minify --raw`

点击确定，成功添加集群。

### 添加节点

点击以上步骤添加的集群，然后点击右上角"新增节点",选择k8s节点

### 添加服务

点击左侧列表服务，然后点击右上角"新增服务"，选择要按照的服务组件，点击下一步，自定义组件的节点分布配置，然后点击下一步，开始安装服务。

遇到问题优先在指令界面查看日志，未能解决则需使用k8s相关命令进一步排查

k8s有以下常用指令，也可以用一些k8s可视化运维工具：

```shell
# 获取命名空间下所有deployment
kubectl -n=命名空间 get deployment
# 获取命名空间下所有pod
kubectl -n=命名空间 get pod
# 查看pod状态及具体信息：通常是环境问题，比方说因镜像拉取失败导致无法运行
kubectl -n=命名空间 describe pod ${pod_name}
# 追踪pod日志：通常用于发现启动脚本报错或组件自身报错
kubectl -n=命名空间 logs -f --tail=100 ${pod_name}
# 进入pod内部进行排查
kubectl -n=命名空间 exec -it ${pod_name} bash

```



