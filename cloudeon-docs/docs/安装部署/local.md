

# 本地部署
## 环境准备

- JDK 1.8+
- MySql5.7+ (可选，内置H2)
- Cloudeon 安装包（cloudeon-assembly-*-release.zip)
- Kubernetes 1.21 +

## 部署包准备
https://github.com/dromara/CloudEon/releases
如果还没发布，可以源码编译：
执行以下命令生成 Cloudeon 安装包：

```shell
mvn clean package -Dmaven.test.skip
```

生成的安装包位于 cloudeon-assembly/target 目录下，格式为 .tar.gz 或 .zip。

## 文件结构
首先下载安装包，并且解压安装包。
```
unzip cloudeon-assembly-*-release.zip
```
解压之后的文件结构如下
```
├── bin               # 执行脚本目录
├── conf            # 配置文件目录
├── lib               # 项目依赖目录
├── stack            # 大数据服务安装包插件
└── LICENSE
```
## 启动应用
运行 bin 目录下的脚本来启动应用，Linux 用户使用 `bin/server.sh`，命令列表如下：
```
${CLOUDEON_HOME}/bin/server.sh start       # 启动
${CLOUDEON_HOME}/bin/server.sh stop        # 停止
${CLOUDEON_HOME}/bin/server.sh status      # 查看状态
${CLOUDEON_HOME}/bin/server.sh restart     # 重启
```
### 直接运行
安装包解压后，即可直接运行脚本启动应用。**需要注意的是，直接启动时使用的是内置的 H2 数据库作为应用数据库。**
启动之后通过 http://127.0.0.1:7700 地址访问应用主页，内置初始账户，用户名 admin 密码 admin
### 配置应用数据库 ( 非必须)

可在conf文件夹下通过application.yaml修改数据库连接配置

**注意：在初次连接时会自动创建并初始化数据库**
**首次连接数据库时,建议使用一个权限较高的数据库账号登录(建议 root 账号)。因为首次连接会执行数据库初始化脚本，如果使用的数据库账号权限太低，会导致数据库初始化失败**

