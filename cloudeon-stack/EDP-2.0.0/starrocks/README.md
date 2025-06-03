

## 注意：

如果需要部署Doris的存算一体非高可用集群，需要将 [k8s-render](k8s-render) 下metrics-service-noHa.yaml.ftl、 [service-common](service-common) 下的bootstrap-noHa.sh以及alert-rule-noHa.yaml、service-info-noHa.yaml进行重命名（去掉-noHa）

>值得注意的是：以上部署需要在添加CloudEon集群前操作，否则修改了之后也会不生效