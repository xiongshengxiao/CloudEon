# 部署前提

本文介绍在部署 CloudEon前, 所需要准备的一些先决条件。

## Kubernetes环境（必须）
CloudEon需要一个可访问的Kubernetes集群，目前已知支持的版本是`1.21+` ，如果没有Kubernetes环境可以使用 [kubekey](https://github.com/kubesphere/kubekey) 快速搭建一个。
也支持在k3s上部署。

## HOSTNAME检查（必须）
每个绑定到Kubernetes集群的节点都需要一个唯一的主机名，CloudEon会使用主机名来标识节点，所以必须保证主机名唯一。
而且每个节点的主机名必须能够通过DNS解析，所以必须保证主机名能够被DNS解析。
可以在不同节点上用ping的方式来检查其他节点的主机名是否能够被DNS解析。

## 数据库环境（非必须）

CloudEon默认使用H2作为内置数据库
也支持Mysql作为数据库，可以通过修改 application.yaml 文件进行配置，数据库表会自动创建并完成格式化

## k8s命名空间（必须）

需提前创建k8s命名空间供cloudeon部署组件使用。
参考命令为 `kubectl create ns 命名空间`。
不建议使用default。