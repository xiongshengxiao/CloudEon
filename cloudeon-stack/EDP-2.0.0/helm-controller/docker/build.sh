docker pull rancher/helm-controller:v0.16.5
docker tag rancher/helm-controller:v0.16.5 registry.cn-guangzhou.aliyuncs.com/bigdata200/helm-controller:v0.16.5
docker push  registry.cn-guangzhou.aliyuncs.com/bigdata200/helm-controller:v0.16.5

docker pull rancher/klipper-helm:v0.9.3-build20241008
docker tag rancher/klipper-helm:v0.9.3-build20241008 registry.cn-guangzhou.aliyuncs.com/bigdata200/helm-controller:klipper-helm-v0.9.3-build20241008
docker push  registry.cn-guangzhou.aliyuncs.com/bigdata200/helm-controller:klipper-helm-v0.9.3-build20241008

