FROM registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/hadoop:3.3.4

# 新增solr组件
ENV SOLR_VERSION=8.11.4
ENV SOLR_HOME=/opt/solr
ENV PATH=$PATH:$SOLR_HOME/bin

WORKDIR /tmp

# 该地址属于apache国外官网下载地址，可以考虑先下载到本地再上传上去
ARG SOLR_DOWNLOAD_URL=https://www.apache.org/dyn/closer.lua/lucene/solr/${SOLR_VERSION}/solr-${SOLR_VERSION}.tgz?action=download

RUN wget "$SOLR_DOWNLOAD_URL" -O /tmp/solr-${SOLR_VERSION}.tgz \
    && tar -zxvf solr-${SOLR_VERSION}.tgz -C /opt \
    && rm -f solr-${SOLR_VERSION}.tgz \
    && mv /opt/*solr*  $SOLR_HOME

WORKDIR $SOLR_HOME