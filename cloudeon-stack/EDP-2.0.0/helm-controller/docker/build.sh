docker pull rancher/helm-controller:v0.16.5
docker tag rancher/helm-controller:v0.16.5 registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/helm-controller:v0.16.5
docker push  registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/helm-controller:v0.16.5

docker pull rancher/klipper-helm:v0.9.3-build20241008
docker tag rancher/klipper-helm:v0.9.3-build20241008 registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/helm-controller:klipper-helm-v0.9.3-build20241008
docker push  registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/helm-controller:klipper-helm-v0.9.3-build20241008

