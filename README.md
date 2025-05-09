<div align="center">
<h1>Dromara CloudEon云原生大数据平台</h1>

[![GitHub Pull Requests](https://img.shields.io/github/stars/dromara/CloudEon)](https://github.com/dromara/CloudEon/stargazers)
[![Gitee Star](https://gitee.com/dromara/cloudeon/badge/star.svg?theme=gvp)](https://gitee.com/dromara/CloudEon/stargazers)



[![HitCount](https://views.whatilearened.today/views/github/dromara/CloudEon.svg)](https://github.com/dromara/CloudEon)
[![Commits](https://img.shields.io/github/commit-activity/m/dromara/CloudEon?color=ffff00)](https://github.com/dromara/CloudEon/commits/main)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)
[![All Contributors](https://img.shields.io/github/all-contributors/dromara/CloudEon)](#contributors-)
[![GitHub license](https://img.shields.io/github/license/dromara/CloudEon)](https://github.com/dromara/CloudEon/LICENSE)

<p> 🌉 构建于kubernetes集群之上的大数据管理平台 🌉</p>

<img src="https://camo.githubusercontent.com/82291b0fe831bfc6781e07fc5090cbd0a8b912bb8b8d4fec0696c881834f81ac/68747470733a2f2f70726f626f742e6d656469612f394575424971676170492e676966" width="800"  height="3">
</div><br>



## ℹ️ 项目简介

CloudEon 是基于 Kubernetes 的资源安装部署开源大数据组件，实现开源大数据平台的容器化运行，您可减少对于底层资源的运维关注。

>该项目搬运于[Dromara CloudEon](https://github.com/dromara/CloudEon)，是在CloudEon:dev2.0的基础上进行升级改造。

## 🔗 文档快链

项目相关介绍，使用，最佳实践等相关内容，都会在官方文档呈现，如有疑问，请先阅读官方文档，以下列举以下常用快链。


- [项目文档](https://cloudeon.dromara.org)
- [旧版1.x文档](https://docs.cloudeon.top/en/v1.3.0/)



## 👨‍💻 开源地址

| 分类 |                        GitHub                        |                        Gitee                        |
| :--: | :--------------------------------------------------: | :-------------------------------------------------: |
| 后端 |  https://github.com/dromara/CloudEon   | https://gitee.com/dromara/CloudEon  |
| 前端 | https://github.com/dromara/CloudEon/tree/master/cloudeon-ui | https://gitee.com/dromara/CloudEon/tree/master/cloudeon-ui  |
| 大数据组件 | https://github.com/dromara/CloudEon/tree/master/cloudeon-stack | https://gitee.com/dromara/CloudEon/tree/master/cloudeon-stack  |

## 👍集成组件

| 序号 |           名称           |         版本         |                            描述                            |
| :--: | :----------------------: | :------------------: | :--------------------------------------------------------: |
|  1   |        Prometheus        |        2.17.2        |                高性能监控指标采集与告警系统                |
|  2   |         Grafana          |        9.1.6         |                  监控分析与数据可视化套件                  |
|  3   |       AlertManager       |        0.23.0        |                      告警通知管理系统                      |
|  4   |          Global          |        1.0.0         |                          全局配置                          |
|  5   |           Helm           |        0.15.4        |            简化 Kubernetes 应用部署和管理的工具            |
|  6   |           HDFS           |        3.3.4         |                      分布式大数据存储                      |
|  7   |           YARN           |        3.3.4         |                  分布式资源调度与管理平台                  |
|  8   |        ZooKeeper         |        3.7.1         |                       分布式协调系统                       |
|  9   |          Minio           | 2021-04-22T15-44-28Z |                    S3分布式对象存储系统                    |
|  10  |           Hive           |        3.1.3         |                        离线数据仓库                        |
|  11  |          Spark           |        3.2.3         |                       分布式计算系统                       |
|  12  |          Flink           |        1.20.1        |                        实时计算引擎                        |
|  13  |          Paimon          |        1.0.1         |                 流批统一的数据处理存储系统                 |
|  14  |          Dinky           |        1.2.3         |      流处理极速开发框架,流批一体&湖仓一体的云原生平台      |
|  15  |          Doris           |        2.1.9         |                 新一代极速全场景MPP数据库                  |
|  16  |        StarRocks         |        3.3.13        |                 新一代极速全场景MPP数据库                  |
|  17  |          Kafka           |        4.0.0         |               高吞吐量分布式发布订阅消息系统               |
|  18  |    DolphoinScheduler     |        3.1.9         |           分布式易扩展的可视化工作流任务调度平台           |
|  19  |          Hbase           |        2.4.16        |                    分布式列式存储数据库                    |
|  20  |      ElasticSearch       |        7.16.3        |                       高性能搜索引擎                       |
|  21  |        DataVines         |        1.0.0         | 一站式开源数据可观测性平台，内置元数据管理、数据质量管理等 |
|  22  | DataX & DataXWeb(单节点) |     3.0.0-2.1.2      |                  阿里巴巴开源数据同步工具                  |
|  23  | Seatunnel & SeatunnelWeb |     2.3.8-1.0.2      |                      海量数据同步引擎                      |
|  24  |         Filebeat         |        7.16.3        |                        日志采集工具                        |
|  25  |          Kylin           |        5.0.0         |                    大数据开源OLAP 引擎                     |
|  26  |          Trino           |         424          |            离线数据仓库分布式Sql交互式查询引擎             |
|  27  |          Kyuubi          |        1.7.0         |                  分布式和多租户的SQL网关                   |
|  28  |           Solr           |        8.11.4        |                    企业级的搜索引擎系统                    |

>注：排名不分先后

## 😵TODO

- [ ] 实现大数据相关组件集群进行横向扩容 -在原先部署好的服务进行添加新实例(苦恼中...)
- [x] 前后端新增添加用户(admin用户才有添加权限)和修改密码的功能,并修复前端页面在登录状态刷新就跳转到登录页面
- [x] 集成StarRocks，并添加监控
- [x] 集成升级Doris2.1.9高版本
- [x] 集成DataX && DataXWeb-单节点
- [x] 集成升级Kafka4.0.0&3.9.0-KRaft模式
- [x] 集成升级Dinky1.2.3
- [x] 集成Flink1.20.1升级-支持Flink全方面功能(原作者Flink只是部署History服务),包括Python、Minio、FlinkCDC、Kafka、Paimon等支持
- [x] 集成Minio:2021-04-22T15-44-28Z
- [x] 集成升级Seatunnel:2.3.8 && Seatunnel_Web:1.0.2
- [x] 集成DolphinScheduler-3.1.9降级-3.2+版本目前反馈有存在Bug，不适合用于生产
- [x] 集成DataVines:1.0.0(暂不支持 Flink 引擎)
- [ ] 集成Redis8.0.0(想法中)
- [ ] 集成Superset(想法中)
- [ ] 集成Ranger权限控制框架(在办)
- [x] 集成Solr
- [ ] ......

## 🤗 另外

- 如果觉得项目不错，麻烦动动小手点个⭐️star⭐️!
- 如果你还有其他想法或者需求，欢迎在issue中交流！


## 📝 使用登记

如果你所在公司使用了该项目，烦请在这里留下脚印，感谢支持🥳 [点我](https://github.com/xiongshengxiao/CloudEon/issues)

## 🥰 感谢

感谢如下优秀的项目，没有这些项目，不可能会有CloudEon：

- 后端技术栈
    - [springboot-v2.7.4](https://github.com/spring-projects/spring-boot)
    - [lombok-v1.18.12](https://github.com/projectlombok/lombok)
    - [hutool-v5.8.9](https://github.com/dromara/hutool)
    - [hibernate-v5.6.11](https://github.com/hibernate/hibernate-orm)
    - [freemarker-v2.3.31](https://github.com/apache/freemarker)
- 前端技术栈
    - [react](https://github.com/facebook/react)
    - [ant-design](https://github.com/ant-design/ant-design)

- 另外特别感谢
    - [Ambari](https://github.com/apache/ambari)  ：参考其对大数据组件的安全管理、可拓展大数据组件包管理
    - [datasophon](https://github.com/datasophon/datasophon) ：参考其优秀的监控告警体系


## ☎️社区交流
### 微信公众号
[![图片.png](https://cloudeon.dromara.org/images/gzh.jpg)](https://cloudeon.dromara.org/images/gzh.jpg)

### 原作者微信

[![图片.png](https://cloudeon.dromara.org/images/wx.png)](https://cloudeon.dromara.org/images/wx.png)（添加请备注CloudEon）

### 本人微信-欢迎志同道合的朋友一起交流技术

[<img src="https://raw.githubusercontent.com/xiongshengxiao/MyPicGo/img/img/3d84848615899c09a469891791f622e.jpg" alt="3d84848615899c09a469891791f622e" style="zoom: 25%;" />]()（添加请备注CloudEon）

## 🤝 贡献者

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/Pandas886"><img src="https://avatars.githubusercontent.com/u/123344357?v=4?s=100" width="100px;" alt="Pandas886"/><br /><sub><b>Pandas886</b></sub></a><br /><a href="https://github.com/dromara/CloudEon/commits?author=Pandas886" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/Mericol"><img src="https://avatars.githubusercontent.com/u/39690226?v=4?s=100" width="100px;" alt="Mericol"/><br /><sub><b>Mericol</b></sub></a><br /><a href="https://github.com/dromara/CloudEon/commits?author=Mericol" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/Koyfin"><img src="https://avatars.githubusercontent.com/u/18548053?v=4?s=100" width="100px;" alt="Koyfin"/><br /><sub><b>Koyfin</b></sub></a><br /><a href="#infra-Koyfin" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="https://github.com/dromara/CloudEon/commits?author=Koyfin" title="Tests">⚠️</a> <a href="https://github.com/dromara/CloudEon/commits?author=Koyfin" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/mechaelyoung"><img src="https://avatars.githubusercontent.com/u/44049993?v=4?s=100" width="100px;" alt="mechaelyoung"/><br /><sub><b>mechaelyoung</b></sub></a><br /><a href="https://github.com/dromara/CloudEon/commits?author=mechaelyoung" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://linshenkx.cn"><img src="https://avatars.githubusercontent.com/u/32978552?v=4?s=100" width="100px;" alt="且炼时光"/><br /><sub><b>且炼时光</b></sub></a><br /><a href="https://github.com/dromara/CloudEon/commits?author=linshenkx" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/tgluon"><img src="https://avatars.githubusercontent.com/u/26194129?v=4?s=100" width="100px;" alt="XiuhongTang"/><br /><sub><b>XiuhongTang</b></sub></a><br /><a href="https://github.com/dromara/CloudEon/commits?author=tgluon" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/KangTomwk"><img src="https://avatars.githubusercontent.com/u/25816207?v=4?s=100" width="100px;" alt="KangTomwk"/><br /><sub><b>KangTomwk</b></sub></a><br /><a href="https://github.com/dromara/CloudEon/commits?author=KangTomwk" title="Code">💻</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/pan3793"><img src="https://avatars.githubusercontent.com/u/26535726?v=4?s=100" width="100px;" alt="Cheng Pan"/><br /><sub><b>Cheng Pan</b></sub></a><br /><a href="https://github.com/dromara/CloudEon/commits?author=pan3793" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/limaiwang"><img src="https://avatars.githubusercontent.com/u/23052750?v=4?s=100" width="100px;" alt="maiwang li"/><br /><sub><b>maiwang li</b></sub></a><br /><a href="https://github.com/dromara/CloudEon/commits?author=limaiwang" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/liang281778527"><img src="https://avatars.githubusercontent.com/u/26902335?v=4?s=100" width="100px;" alt="liang281778527"/><br /><sub><b>liang281778527</b></sub></a><br /><a href="https://github.com/dromara/CloudEon/commits?author=liang281778527" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/anzhen-tech"><img src="https://avatars.githubusercontent.com/u/16895736?v=4?s=100" width="100px;" alt="anzhen-tech"/><br /><sub><b>anzhen-tech</b></sub></a><br /><a href="https://github.com/dromara/CloudEon/commits?author=anzhen-tech" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://lidong1665.github.io"><img src="https://avatars.githubusercontent.com/u/9442552?v=4?s=100" width="100px;" alt="奋斗吧少年"/><br /><sub><b>奋斗吧少年</b></sub></a><br /><a href="https://github.com/dromara/CloudEon/commits?author=lidong1665" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/rugalcrimson"><img src="https://avatars.githubusercontent.com/u/15381951?v=4?s=100" width="100px;" alt="rugalcrimson"/><br /><sub><b>rugalcrimson</b></sub></a><br /><a href="https://github.com/dromara/CloudEon/commits?author=rugalcrimson" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/q443048756"><img src="https://avatars.githubusercontent.com/u/47968271?v=4?s=100" width="100px;" alt="buer"/><br /><sub><b>buer</b></sub></a><br /><a href="https://github.com/dromara/CloudEon/commits?author=q443048756" title="Code">💻</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
