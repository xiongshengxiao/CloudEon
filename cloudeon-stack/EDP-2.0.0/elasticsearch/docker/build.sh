docker build -t registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/elasticsearch:7.16.3 .
docker push  registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/elasticsearch:7.16.3

docker pull prometheuscommunity/elasticsearch-exporter:v1.7.0
docker tag prometheuscommunity/elasticsearch-exporter:v1.7.0 registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/elasticsearch_exporter:v1.7.0
docker push registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/elasticsearch_exporter:v1.7.0
