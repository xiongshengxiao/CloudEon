# CloudEon集成Kafka4.0.0&3.9.0-KRaft模式

## 前言

==部署KRaft模式需要进行初始化Kafka集群。==

Kafka4.0.0和Kafka3.9.0通过CloudEon使用Kubernetes部署KRaft模式皆可参考一下步骤。

## 克隆CloudEon源码

```shell
git clone https://gitclone.com/github.com/dromara/CloudEon.git
```

## 修改相关配置文件

### Dockerfile

==该文件存在于docker路径下==

`如果集成Kafka的是3.9.0版本，可以考虑进行继续基于JDK8构建镜像`

`如果集成Kafka的是4.0.0版本，必须基于JDK11+构建镜像。最好是JDK17`

```shell
# FROM registry.cn-guangzhou.aliyuncs.com/bigdata200/jdk:8-ubuntu
FROM registry.cn-guangzhou.aliyuncs.com/bigdata200/jdk:17


ENV KAFKA_HOME=/opt/kafka \
    # KAFKA_VERSION=3.9.0
    KAFKA_VERSION=4.0.0
ENV PATH=${PATH}:${KAFKA_HOME}/bin

# 安装 bash
# RUN apk add --no-cache bash

# RUN wget https://mirrors.huaweicloud.com/apache/kafka/${KAFKA_VERSION}/kafka_2.12-${KAFKA_VERSION}.tgz \
RUN wget https://mirrors.aliyun.com/apache/kafka/${KAFKA_VERSION}/kafka_2.13-${KAFKA_VERSION}.tgz \
    && tar -zxvf kafka*.tgz -C /opt \
    && mv /opt/kafka* $KAFKA_HOME \
    && rm -f kafka*.tgz

# 生成 cluster_id 并写入文件
RUN $KAFKA_HOME/bin/kafka-storage.sh random-uuid > /cluster_id.txt

WORKDIR $KAFKA_HOME

```

>说明：在构建镜像的时候可以把先生成一个唯一的集群ID赋值到cluster_id.txt，后续格式化存储目录时需要用到。
>
>需要注意的是：**不要将cluster_id.txt生成到Kafka路径**，后面部署的时候Kafka路径下疑似**被覆盖找不到**。
>
>Kubernetes关于Kafka应该是做了挂载，所以会导致cluster_id.txt消失。如果你对Kubernetes不是很透，建议跟我一样生成到其他路径。已替你们踩好坑

### grafana-dashboard.yaml.ftl

==该文件存在于kube-prometheus-render路径下==

`删除Zookeeper相关的配置。删除2619~3117行相关Zookeeper的内容`

```shell
apiVersion: v1
kind: ConfigMap
metadata:
  name: "${serviceFullName}-grafana-dashboard"
  labels:
    grafana_dashboard: "1"
    serviceName: "${serviceFullName}"
  annotations:
    folder: "${serviceFullName}"
data:
  k8s-dashboard.json: |
    <#noparse >
    {
      "annotations": {
        "list": [
          {
            "builtIn": 1,
            "datasource": {
              "type": "datasource",
              "uid": "grafana"
            },
            "enable": true,
            "hide": true,
            "iconColor": "rgba(0, 211, 255, 1)",
            "name": "Annotations & Alerts",
            "type": "dashboard"
          }
        ]
      },
      "description": "Kafka resource usage and throughput",
      "editable": true,
      "fiscalYearStartMonth": 0,
      "gnetId": 721,
      "graphTooltip": 0,
      "id": 43,
      "links": [
        {
          "asDropdown": false,
          "includeVars": true,
          "keepTime": true,
          "tags": [
            "kafka-integration"
          ],
          "title": "Integration dashboards",
          "type": "dashboards"
        }
      ],
      "liveNow": false,
      "panels": [
        {
          "collapsed": false,
          "datasource": {
            "uid": "$datasource"
          },
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 3
          },
          "id": 42,
          "panels": [],
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "refId": "A"
            }
          ],
          "title": "Healthcheck",
          "type": "row"
        },
        {
          "datasource": {
            "uid": "${datasource}"
          },
          "description": "Number of active controllers in the cluster.",
          "fieldConfig": {
            "defaults": {
              "mappings": [
                {
                  "options": {
                    "match": "null",
                    "result": {
                      "text": "N/A"
                    }
                  },
                  "type": "special"
                }
              ],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "#299c46",
                    "value": null
                  },
                  {
                    "color": "#e5ac0e",
                    "value": 2
                  },
                  {
                    "color": "#bf1b00"
                  }
                ]
              },
              "unit": "none"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 4,
            "x": 0,
            "y": 4
          },
          "id": 12,
          "maxDataPoints": 100,
          "options": {
            "colorMode": "value",
            "fieldOptions": {
              "calcs": [
                "lastNotNull"
              ]
            },
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "last"
              ],
              "fields": "",
              "values": false
            },
            "showPercentChange": false,
            "text": {},
            "textMode": "auto",
            "wideLayout": true
          },
          "pluginVersion": "11.1.0-69372",
          "targets": [
            {
              "datasource": {
                "uid": "${datasource}"
              },
              "expr": "sum(kafka_controller_kafkacontroller_activecontrollercount{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"})",
              "format": "time_series",
              "intervalFactor": 1,
              "refId": "A"
            }
          ],
          "title": "Active Controllers",
          "type": "stat"
        },
        {
          "datasource": {
            "uid": "${datasource}"
          },
          "description": "Number of Brokers Online",
          "fieldConfig": {
            "defaults": {
              "mappings": [
                {
                  "options": {
                    "match": "null",
                    "result": {
                      "text": "N/A"
                    }
                  },
                  "type": "special"
                }
              ],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "#d44a3a",
                    "value": null
                  },
                  {
                    "color": "rgba(237, 129, 40, 0.89)",
                    "value": 0
                  },
                  {
                    "color": "semi-dark-green",
                    "value": 2
                  }
                ]
              },
              "unit": "none"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 4,
            "x": 4,
            "y": 4
          },
          "id": 14,
          "maxDataPoints": 100,
          "options": {
            "colorMode": "value",
            "fieldOptions": {
              "calcs": [
                "lastNotNull"
              ]
            },
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "last"
              ],
              "fields": "",
              "values": false
            },
            "showPercentChange": false,
            "text": {},
            "textMode": "auto",
            "wideLayout": true
          },
          "pluginVersion": "11.1.0-69372",
          "repeatDirection": "h",
          "targets": [
            {
              "datasource": {
                "uid": "${datasource}"
              },
              "expr": "count(kafka_server_replicamanager_leadercount{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"})",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "",
              "refId": "A"
            }
          ],
          "title": "Brokers Online",
          "type": "stat"
        },
        {
          "datasource": {
            "uid": "${datasource}"
          },
          "description": "Unclean leader election rate",
          "fieldConfig": {
            "defaults": {
              "mappings": [
                {
                  "options": {
                    "match": "null",
                    "result": {
                      "text": "N/A"
                    }
                  },
                  "type": "special"
                }
              ],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "#299c46",
                    "value": null
                  },
                  {
                    "color": "rgba(237, 129, 40, 0.89)",
                    "value": 1
                  },
                  {
                    "color": "#d44a3a"
                  }
                ]
              },
              "unit": "none"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 4,
            "x": 8,
            "y": 4
          },
          "id": 16,
          "maxDataPoints": 100,
          "options": {
            "colorMode": "value",
            "fieldOptions": {
              "calcs": [
                "lastNotNull"
              ]
            },
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "last"
              ],
              "fields": "",
              "values": false
            },
            "showPercentChange": false,
            "text": {},
            "textMode": "auto",
            "wideLayout": true
          },
          "pluginVersion": "11.1.0-69372",
          "targets": [
            {
              "datasource": {
                "uid": "${datasource}"
              },
              "expr": "sum(kafka_controller_controllerstats_uncleanleaderelectionspersec{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"})",
              "format": "time_series",
              "intervalFactor": 1,
              "refId": "A"
            }
          ],
          "title": "Unclean Leader Election Rate",
          "type": "stat"
        },
        {
          "datasource": {
            "uid": "${datasource}"
          },
          "description": "",
          "fieldConfig": {
            "defaults": {
              "mappings": [
                {
                  "options": {
                    "match": "null",
                    "result": {
                      "text": "N/A"
                    }
                  },
                  "type": "special"
                }
              ],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "#299c46",
                    "value": null
                  },
                  {
                    "color": "rgba(237, 129, 40, 0.89)",
                    "value": 2
                  },
                  {
                    "color": "#d44a3a"
                  }
                ]
              },
              "unit": "none"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 4,
            "x": 12,
            "y": 4
          },
          "id": 33,
          "maxDataPoints": 100,
          "options": {
            "colorMode": "value",
            "fieldOptions": {
              "calcs": [
                "lastNotNull"
              ]
            },
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "last"
              ],
              "fields": "",
              "values": false
            },
            "showPercentChange": false,
            "text": {},
            "textMode": "auto",
            "wideLayout": true
          },
          "pluginVersion": "11.1.0-69372",
          "targets": [
            {
              "datasource": {
                "uid": "${datasource}"
              },
              "expr": "sum(kafka_controller_kafkacontroller_preferredreplicaimbalancecount{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"})",
              "format": "time_series",
              "intervalFactor": 1,
              "refId": "A"
            }
          ],
          "title": "Preferred Replica Imbalance",
          "type": "stat"
        },
        {
          "datasource": {
            "uid": "${datasource}"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "Bytes/s",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 2,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": true,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "Bps"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 8,
            "x": 16,
            "y": 4
          },
          "id": 84,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "${datasource}"
              },
              "expr": "sum(rate(kafka_server_brokertopicmetrics_bytesinpersec{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",topic!=\"\"}[$__rate_interval]))",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "Bytes in",
              "metric": "kafka_server_brokertopicmetrics_bytesinpersec",
              "refId": "A",
              "step": 4
            },
            {
              "datasource": {
                "uid": "${datasource}"
              },
              "expr": "sum(rate(kafka_server_brokertopicmetrics_bytesoutpersec{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",topic!=\"\"}[$__rate_interval]))",
              "format": "time_series",
              "hide": false,
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "Bytes out",
              "metric": "kafka_server_brokertopicmetrics_bytesinpersec",
              "refId": "B",
              "step": 4
            }
          ],
          "title": "Broker network throughput",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "${datasource}"
          },
          "description": "Number of partitions that dont have an active leader and are hence not writable or readable.",
          "fieldConfig": {
            "defaults": {
              "mappings": [
                {
                  "options": {
                    "match": "null",
                    "result": {
                      "text": "N/A"
                    }
                  },
                  "type": "special"
                }
              ],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "semi-dark-green",
                    "value": null
                  },
                  {
                    "color": "#bf1b00",
                    "value": 1
                  }
                ]
              },
              "unit": "none"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 4,
            "x": 0,
            "y": 8
          },
          "id": 22,
          "maxDataPoints": 100,
          "options": {
            "colorMode": "value",
            "fieldOptions": {
              "calcs": [
                "lastNotNull"
              ]
            },
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "last"
              ],
              "fields": "",
              "values": false
            },
            "showPercentChange": false,
            "text": {},
            "textMode": "auto",
            "wideLayout": true
          },
          "pluginVersion": "11.1.0-69372",
          "targets": [
            {
              "datasource": {
                "uid": "${datasource}"
              },
              "expr": "sum(kafka_controller_kafkacontroller_offlinepartitionscount{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"})",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 1,
              "legendFormat": "",
              "refId": "A"
            }
          ],
          "title": "Offline Partitions Count",
          "type": "stat"
        },
        {
          "datasource": {
            "uid": "${datasource}"
          },
          "description": "Number of under-replicated partitions (| ISR | < | all replicas |).",
          "fieldConfig": {
            "defaults": {
              "mappings": [
                {
                  "options": {
                    "match": "null",
                    "result": {
                      "text": "N/A"
                    }
                  },
                  "type": "special"
                }
              ],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "semi-dark-green",
                    "value": null
                  },
                  {
                    "color": "rgba(237, 129, 40, 0.89)",
                    "value": 1
                  },
                  {
                    "color": "#bf1b00",
                    "value": 5
                  }
                ]
              },
              "unit": "none"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 4,
            "x": 4,
            "y": 8
          },
          "id": 20,
          "maxDataPoints": 100,
          "options": {
            "colorMode": "value",
            "fieldOptions": {
              "calcs": [
                "lastNotNull"
              ]
            },
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "last"
              ],
              "fields": "",
              "values": false
            },
            "showPercentChange": false,
            "text": {},
            "textMode": "auto",
            "wideLayout": true
          },
          "pluginVersion": "11.1.0-69372",
          "targets": [
            {
              "datasource": {
                "uid": "${datasource}"
              },
              "expr": "sum(kafka_server_replicamanager_underreplicatedpartitions{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"})",
              "format": "time_series",
              "hide": false,
              "intervalFactor": 2,
              "refId": "A"
            }
          ],
          "title": "Under Replicated Partitions",
          "type": "stat"
        },
        {
          "datasource": {
            "uid": "${datasource}"
          },
          "description": "Number of partitions under min insync replicas.",
          "fieldConfig": {
            "defaults": {
              "mappings": [
                {
                  "options": {
                    "match": "null",
                    "result": {
                      "text": "N/A"
                    }
                  },
                  "type": "special"
                }
              ],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "semi-dark-green",
                    "value": null
                  },
                  {
                    "color": "#bf1b00",
                    "value": 1
                  }
                ]
              },
              "unit": "none"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 4,
            "x": 8,
            "y": 8
          },
          "id": 32,
          "maxDataPoints": 100,
          "options": {
            "colorMode": "value",
            "fieldOptions": {
              "calcs": [
                "lastNotNull"
              ]
            },
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "last"
              ],
              "fields": "",
              "values": false
            },
            "showPercentChange": false,
            "text": {},
            "textMode": "auto",
            "wideLayout": true
          },
          "pluginVersion": "11.1.0-69372",
          "targets": [
            {
              "datasource": {
                "uid": "${datasource}"
              },
              "expr": "sum(kafka_cluster_partition_underminisr{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"})",
              "format": "time_series",
              "hide": false,
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "",
              "refId": "A"
            }
          ],
          "title": "Under Min ISR Partitions",
          "type": "stat"
        },
        {
          "datasource": {
            "uid": "${datasource}"
          },
          "description": "Partitions that are online",
          "fieldConfig": {
            "defaults": {
              "mappings": [
                {
                  "options": {
                    "match": "null",
                    "result": {
                      "text": "N/A"
                    }
                  },
                  "type": "special"
                }
              ],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "#d44a3a",
                    "value": null
                  },
                  {
                    "color": "rgba(237, 129, 40, 0.89)",
                    "value": 0
                  },
                  {
                    "color": "#299c46",
                    "value": 0
                  }
                ]
              },
              "unit": "none"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 4,
            "x": 12,
            "y": 8
          },
          "id": 18,
          "maxDataPoints": 100,
          "options": {
            "colorMode": "value",
            "fieldOptions": {
              "calcs": [
                "lastNotNull"
              ]
            },
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "last"
              ],
              "fields": "",
              "values": false
            },
            "showPercentChange": false,
            "text": {},
            "textMode": "auto",
            "wideLayout": true
          },
          "pluginVersion": "11.1.0-69372",
          "targets": [
            {
              "datasource": {
                "uid": "${datasource}"
              },
              "expr": "sum(kafka_server_replicamanager_partitioncount{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"})",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 1,
              "legendFormat": "",
              "refId": "A"
            }
          ],
          "title": "Online Partitions",
          "type": "stat"
        },
        {
          "collapsed": false,
          "datasource": {
            "uid": "$datasource"
          },
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 12
          },
          "id": 40,
          "panels": [],
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "refId": "A"
            }
          ],
          "title": "System",
          "type": "row"
        },
        {
          "datasource": {
            "uid": "${datasource}"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "Cores",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 2,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": true,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "percent"
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "localhost:7071"
                },
                "properties": [
                  {
                    "id": "color",
                    "value": {
                      "fixedColor": "#629E51",
                      "mode": "fixed"
                    }
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 0,
            "y": 13
          },
          "id": 27,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "${datasource}"
              },
              "expr": "irate(process_cpu_seconds_total{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"}[$__rate_interval])*100",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "{{instance}}",
              "metric": "process_cpu_secondspersec",
              "refId": "A",
              "step": 4
            }
          ],
          "title": "CPU Usage",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "${datasource}"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "Memory",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 2,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": true,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "bytes"
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "localhost:7071"
                },
                "properties": [
                  {
                    "id": "color",
                    "value": {
                      "fixedColor": "#BA43A9",
                      "mode": "fixed"
                    }
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 8,
            "y": 13
          },
          "id": 2,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "${datasource}"
              },
              "expr": "sum without(area)(jvm_memory_bytes_used{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"})",
              "intervalFactor": 2,
              "legendFormat": "{{instance}}",
              "metric": "jvm_memory_bytes_used",
              "refId": "A",
              "step": 4
            }
          ],
          "title": "JVM Memory Used",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "${datasource}"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "% time in GC",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 2,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": true,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "percentunit"
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "localhost:7071"
                },
                "properties": [
                  {
                    "id": "color",
                    "value": {
                      "fixedColor": "#890F02",
                      "mode": "fixed"
                    }
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 16,
            "y": 13
          },
          "id": 3,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "${datasource}"
              },
              "expr": "sum without(gc)(rate(jvm_gc_collection_seconds_sum{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"}[$__rate_interval]))",
              "intervalFactor": 2,
              "legendFormat": "{{instance}}",
              "metric": "jvm_gc_collection_seconds_sum",
              "refId": "A",
              "step": 4
            }
          ],
          "title": "Time spent in GC",
          "type": "timeseries"
        },
        {
          "collapsed": false,
          "datasource": {
            "uid": "$datasource"
          },
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 20
          },
          "id": 29,
          "panels": [],
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "refId": "A"
            }
          ],
          "title": "Throughput In/Out",
          "type": "row"
        },
        {
          "datasource": {
            "uid": "${datasource}"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "Messages/s",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 2,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": true,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "iops"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 0,
            "y": 21
          },
          "id": 4,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "${datasource}"
              },
              "expr": "sum without(instance)(rate(kafka_server_brokertopicmetrics_messagesinpersec{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",topic=~\"$topic\"}[$__rate_interval]))",
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "{{topic}}",
              "metric": "kafka_server_brokertopicmetrics_messagesinpersec",
              "refId": "A",
              "step": 4
            }
          ],
          "title": "Messages In Per Topic",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "${datasource}"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "Bytes/s",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 2,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": true,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "Bps"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 8,
            "y": 21
          },
          "id": 5,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "${datasource}"
              },
              "expr": "sum without(instance)(rate(kafka_server_brokertopicmetrics_bytesinpersec{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",topic=~\"$topic\"}[$__rate_interval]))",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "{{topic}}",
              "metric": "kafka_server_brokertopicmetrics_bytesinpersec",
              "refId": "A",
              "step": 4
            }
          ],
          "title": "Bytes In Per Topic",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "${datasource}"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "Bytes/s",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 2,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": true,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "Bps"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 16,
            "y": 21
          },
          "id": 6,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "${datasource}"
              },
              "expr": "sum without(instance)(rate(kafka_server_brokertopicmetrics_bytesoutpersec{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",topic=~\"$topic\"}[$__rate_interval]))",
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "{{topic}}",
              "metric": "kafka_server_brokertopicmetrics_bytesinpersec",
              "refId": "A",
              "step": 4
            }
          ],
          "title": "Bytes Out Per Topic",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "${datasource}"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "Messages/s",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 2,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": true,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "iops"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 0,
            "y": 28
          },
          "id": 10,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "${datasource}"
              },
              "expr": "sum without(topic)(rate(kafka_server_brokertopicmetrics_messagesinpersec{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",topic=~\"$topic\"}[$__rate_interval]))",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "{{instance}}",
              "metric": "kafka_server_brokertopicmetrics_messagesinpersec",
              "refId": "A",
              "step": 4
            }
          ],
          "title": "Messages In Per Broker",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "${datasource}"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "Bytes/s",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 2,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": true,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "Bps"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 8,
            "y": 28
          },
          "id": 7,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "${datasource}"
              },
              "expr": "sum without(topic)(rate(kafka_server_brokertopicmetrics_bytesinpersec{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",topic=~\"$topic\"}[$__rate_interval]))",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "{{instance}}",
              "metric": "kafka_server_brokertopicmetrics_bytesinpersec",
              "refId": "A",
              "step": 4
            }
          ],
          "title": "Bytes In Per Broker",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "${datasource}"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "min": 0,
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 16,
            "y": 28
          },
          "id": 9,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "${datasource}"
              },
              "expr": "sum without(topic)(rate(kafka_server_brokertopicmetrics_bytesoutpersec{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",topic=~\"$topic\"}[$__rate_interval]))",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 1,
              "legendFormat": "{{instance}}",
              "refId": "A"
            }
          ],
          "title": "Bytes Out Per Broker",
          "type": "timeseries"
        },
        {
          "collapsed": false,
          "datasource": {
            "uid": "$datasource"
          },
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 35
          },
          "id": 117,
          "panels": [],
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "refId": "A"
            }
          ],
          "title": "Replication",
          "type": "row"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "$datasource"
          },
          "description": "Offline partitions over time",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 36
          },
          "id": 122,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "none"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "editorMode": "code",
              "expr": "sum(kafka_server_replicamanager_partitioncount{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"})",
              "interval": "",
              "legendFormat": "",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "Online Partitions",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "Offline partitions over time",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 36
          },
          "id": 121,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "none"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(kafka_controller_kafkacontroller_offlinepartitionscount{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"})",
              "interval": "",
              "legendFormat": "",
              "refId": "A"
            }
          ],
          "title": "Offline Partitions",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "Under replicated partitions over time",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 44
          },
          "id": 120,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "none"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(kafka_cluster_partition_underreplicated{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"})",
              "interval": "",
              "legendFormat": "",
              "refId": "A"
            }
          ],
          "title": "Under Replicated Partitions",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "Under min in sync replicas partitions over time",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 44
          },
          "id": 119,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "none"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(kafka_cluster_partition_underminisr{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"})",
              "interval": "",
              "legendFormat": "",
              "refId": "A"
            }
          ],
          "title": "Under Min ISR Partitions",
          "type": "timeseries"
        },
        {
          "collapsed": false,
          "datasource": {
            "uid": "$datasource"
          },
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 52
          },
          "id": 44,
          "panels": [],
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "refId": "A"
            }
          ],
          "title": "Thread utilization",
          "type": "row"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "Average fraction of time the network processor threads are idle. Values are between 0 (all resources are used) and 100 (all resources are available) ",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "percentunit"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 53
          },
          "id": 24,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "asc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_network_socketserver_networkprocessoravgidlepercent{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"}",
              "legendFormat": "{{instance}}",
              "refId": "A"
            }
          ],
          "title": "Network Processor Avg Idle Percent",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "Average fraction of time the request handler threads are idle. Values are between 0 (all resources are used) and 100 (all resources are available). ",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "percentunit"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 53
          },
          "id": 25,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "asc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_server_kafkarequesthandlerpool_requesthandleravgidlepercent_total{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"}",
              "legendFormat": "{{instance}}",
              "refId": "A"
            }
          ],
          "title": "Request Handler Avg Idle Percent",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 61
          },
          "id": 126,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "none"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_network_requestchannel_requestqueuesize{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"}",
              "interval": "",
              "legendFormat": "{{instance}}",
              "refId": "A"
            }
          ],
          "title": "Request Queue Size",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 61
          },
          "id": 127,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "none"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_network_requestchannel_responsequeuesize{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",processor=\"\"}",
              "interval": "",
              "legendFormat": "{{instance}}",
              "refId": "A"
            }
          ],
          "title": "Response Queue Size",
          "type": "timeseries"
        },
        {
          "collapsed": false,
          "datasource": {
            "uid": "$datasource"
          },
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 94
          },
          "id": 82,
          "panels": [],
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "refId": "A"
            }
          ],
          "title": "Isr Shrinks / Expands",
          "type": "row"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": ": The number of in-sync replicas (ISRs) for a particular partition should remain fairly static, the only exceptions are when you are expanding your broker cluster or removing partitions. In order to maintain high availability, a healthy Kafka cluster requires a minimum number of ISRs for failover. A replica could be removed from the ISR pool for a couple of reasons: it is too far behind the leaders offset (user-configurable by setting the replica.lag.max.messages configuration parameter), or it has not contacted the leader for some time (configurable with the replica.socket.timeout.ms parameter). No matter the reason, an increase in IsrShrinksPerSec without a corresponding increase in IsrExpandsPerSec shortly thereafter is cause for concern and requires user intervention.The Kafka documentation provides a wealth of information on the user-configurable parameters for brokers.",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "ops"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 95
          },
          "id": 80,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_server_replicamanager_isrshrinkspersec{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"}",
              "legendFormat": "{{instance}}",
              "refId": "A"
            }
          ],
          "title": "IsrShrinks per Sec",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": ": The number of in-sync replicas (ISRs) for a particular partition should remain fairly static, the only exceptions are when you are expanding your broker cluster or removing partitions. In order to maintain high availability, a healthy Kafka cluster requires a minimum number of ISRs for failover. A replica could be removed from the ISR pool for a couple of reasons: it is too far behind the leaders offset (user-configurable by setting the replica.lag.max.messages configuration parameter), or it has not contacted the leader for some time (configurable with the replica.socket.timeout.ms parameter). No matter the reason, an increase in IsrShrinksPerSec without a corresponding increase in IsrExpandsPerSec shortly thereafter is cause for concern and requires user intervention.The Kafka documentation provides a wealth of information on the user-configurable parameters for brokers.",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "ops"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 95
          },
          "id": 83,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_server_replicamanager_isrexpandspersec{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"}",
              "hide": false,
              "legendFormat": "{{instance}}",
              "refId": "A"
            }
          ],
          "title": "IsrExpands per Sec",
          "type": "timeseries"
        },
        {
          "collapsed": false,
          "datasource": {
            "uid": "$datasource"
          },
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 103
          },
          "id": 53,
          "panels": [],
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "refId": "A"
            }
          ],
          "title": "Logs size",
          "type": "row"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "decbytes"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 104
          },
          "id": 55,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(kafka_log_log_size{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",topic=~\"$topic\"}) by (topic)",
              "interval": "",
              "legendFormat": "{{topic}}",
              "refId": "A"
            }
          ],
          "title": "Log size per Topic",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "decbytes"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 104
          },
          "id": 56,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(kafka_log_log_size{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",topic=~\"$topic\"}) by (instance)",
              "interval": "",
              "legendFormat": "{{instance}}",
              "refId": "A"
            }
          ],
          "title": "Log size per Broker",
          "type": "timeseries"
        },
        {
          "collapsed": false,
          "datasource": {
            "uid": "$datasource"
          },
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 112
          },
          "id": 58,
          "panels": [],
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "refId": "A"
            }
          ],
          "title": "Producer Performance",
          "type": "row"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "A high value can imply there aren't enough IO threads or the CPU is a bottleneck, or the request queue isnt large enough. The request queue size should match the number of connections.",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "ms"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 113
          },
          "id": 60,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_network_requestmetrics_requestqueuetimems{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",quantile=~\"$percentile\",request=\"Produce\"}",
              "hide": false,
              "legendFormat": "{{instance}} - {{quantile}}",
              "refId": "A"
            }
          ],
          "title": "Producer - RequestQueueTimeMs",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "In most cases, a high value can imply slow local storage or the storage is a bottleneck. One should also investigate LogFlushRateAndTimeMs to know how long page flushes are taking, which will also indicate a slow disk. In the case of FetchFollower requests, time spent in LocalTimeMs can be the result of a ZooKeeper write to change the ISR.",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "ms"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 113
          },
          "id": 61,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_network_requestmetrics_localtimems{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",quantile=~\"$percentile\",request=\"Produce\"}",
              "hide": false,
              "legendFormat": "{{instance}} - {{quantile}}",
              "refId": "A"
            }
          ],
          "title": "Producer - LocalTimeMs",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "A high value can imply a slow network connection. For fetch request, if the remote time is high, it could be that there is not enough data to give in a fetch response. This can happen when the consumer or replica is caught up and there is no new incoming data. If this is the case, remote time will be close to the max wait time, which is normal. Max wait time is configured via replica.fetch.wait.max.ms and fetch.max.wait.ms. ",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "ms"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 121
          },
          "id": 62,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_network_requestmetrics_remotetimems{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",quantile=~\"$percentile\",request=\"Produce\"}",
              "hide": false,
              "legendFormat": "{{instance}} - {{quantile}}",
              "refId": "A"
            }
          ],
          "title": "Producer - RemoteTimeMs",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "A high value can imply there aren't enough network threads or the network cant dequeue responses quickly enough, causing back pressure in the response queue. ",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "ms"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 121
          },
          "id": 63,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_network_requestmetrics_responsequeuetimems{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",quantile=~\"$percentile\",request=\"Produce\"}",
              "hide": false,
              "legendFormat": "{{instance}} - {{quantile}}",
              "refId": "A"
            }
          ],
          "title": "Producer - ResponseQueueTimeMs",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "A high value can imply the zero-copy from disk to the network is slow, or the network is the bottleneck because the network cant dequeue responses of the TCP socket as quickly as theyre being created. If the network buffer gets full, Kafka will block. ",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "ms"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 129
          },
          "id": 64,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_network_requestmetrics_responsesendtimems{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",quantile=~\"$percentile\",request=\"Produce\"}",
              "hide": false,
              "legendFormat": "{{instance}} - {{quantile}}",
              "refId": "A"
            }
          ],
          "title": "Producer - ResponseSendTimeMs",
          "type": "timeseries"
        },
        {
          "collapsed": false,
          "datasource": {
            "uid": "$datasource"
          },
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 137
          },
          "id": 68,
          "panels": [],
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "refId": "A"
            }
          ],
          "title": "Consumer Performance",
          "type": "row"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "A high value can imply there aren't enough IO threads or the CPU is a bottleneck, or the request queue isnt large enough. The request queue size should match the number of connections.",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "ms"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 138
          },
          "id": 69,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_network_requestmetrics_requestqueuetimems{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",quantile=~\"$percentile\",request=\"Fetch\"}",
              "hide": false,
              "legendFormat": "{{instance}} - {{quantile}}",
              "refId": "A"
            }
          ],
          "title": "Consumer - RequestQueueTimeMs",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "In most cases, a high value can imply slow local storage or the storage is a bottleneck. One should also investigate LogFlushRateAndTimeMs to know how long page flushes are taking, which will also indicate a slow disk. In the case of FetchFollower requests, time spent in LocalTimeMs can be the result of a ZooKeeper write to change the ISR.",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "ms"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 138
          },
          "id": 70,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_network_requestmetrics_localtimems{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",quantile=~\"$percentile\",request=\"Fetch\"}",
              "hide": false,
              "legendFormat": "{{instance}} - {{quantile}}",
              "refId": "A"
            }
          ],
          "title": "Consumer - LocalTimeMs",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "A high value can imply a slow network connection. For fetch request, if the remote time is high, it could be that there is not enough data to give in a fetch response. This can happen when the consumer or replica is caught up and there is no new incoming data. If this is the case, remote time will be close to the max wait time, which is normal. Max wait time is configured via replica.fetch.wait.max.ms and fetch.max.wait.ms. ",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "ms"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 146
          },
          "id": 71,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_network_requestmetrics_remotetimems{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",quantile=~\"$percentile\",request=\"Fetch\"}",
              "hide": false,
              "legendFormat": "{{instance}} - {{quantile}}",
              "refId": "A"
            }
          ],
          "title": "Consumer - RemoteTimeMs",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "A high value can imply there aren't enough network threads or the network cant dequeue responses quickly enough, causing back pressure in the response queue. ",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "ms"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 146
          },
          "id": 72,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_network_requestmetrics_responsequeuetimems{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",quantile=~\"$percentile\",request=\"Fetch\"}",
              "hide": false,
              "legendFormat": "{{instance}} - {{quantile}}",
              "refId": "A"
            }
          ],
          "title": "Consumer - ResponseQueueTimeMs",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "A high value can imply the zero-copy from disk to the network is slow, or the network is the bottleneck because the network cant dequeue responses of the TCP socket as quickly as theyre being created. If the network buffer gets full, Kafka will block. ",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "ms"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 154
          },
          "id": 73,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_network_requestmetrics_responsesendtimems{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",quantile=~\"$percentile\",request=\"Fetch\"}",
              "hide": false,
              "legendFormat": "{{instance}} - {{quantile}}",
              "refId": "A"
            }
          ],
          "title": "Consumer - ResponseSendTimeMs",
          "type": "timeseries"
        },
        {
          "collapsed": false,
          "datasource": {
            "uid": "$datasource"
          },
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 162
          },
          "id": 66,
          "panels": [],
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "refId": "A"
            }
          ],
          "title": "Fetch Follower Performance",
          "type": "row"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "A high value can imply there aren't enough IO threads or the CPU is a bottleneck, or the request queue isnt large enough. The request queue size should match the number of connections.",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "ms"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 163
          },
          "id": 74,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_network_requestmetrics_requestqueuetimems{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",quantile=~\"$percentile\",request=\"FetchFollower\"}",
              "hide": false,
              "legendFormat": "{{instance}} - {{quantile}}",
              "refId": "A"
            }
          ],
          "title": "FetchFollower - RequestQueueTimeMs",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "In most cases, a high value can imply slow local storage or the storage is a bottleneck. One should also investigate LogFlushRateAndTimeMs to know how long page flushes are taking, which will also indicate a slow disk. In the case of FetchFollower requests, time spent in LocalTimeMs can be the result of a ZooKeeper write to change the ISR.",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "ms"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 163
          },
          "id": 75,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_network_requestmetrics_localtimems{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",quantile=~\"$percentile\",request=\"FetchFollower\"}",
              "hide": false,
              "legendFormat": "{{instance}} - {{quantile}}",
              "refId": "A"
            }
          ],
          "title": "FetchFollower - LocalTimeMs",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "A high value can imply a slow network connection. For fetch request, if the remote time is high, it could be that there is not enough data to give in a fetch response. This can happen when the consumer or replica is caught up and there is no new incoming data. If this is the case, remote time will be close to the max wait time, which is normal. Max wait time is configured via replica.fetch.wait.max.ms and fetch.max.wait.ms. ",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "ms"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 171
          },
          "id": 76,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_network_requestmetrics_remotetimems{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",quantile=~\"$percentile\",request=\"FetchFollower\"}",
              "hide": false,
              "legendFormat": "{{instance}} - {{quantile}}",
              "refId": "A"
            }
          ],
          "title": "FetchFollower - RemoteTimeMs",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "A high value can imply there aren't enough network threads or the network cant dequeue responses quickly enough, causing back pressure in the response queue. ",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "ms"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 171
          },
          "id": 77,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_network_requestmetrics_responsequeuetimems{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",quantile=~\"$percentile\",request=\"FetchFollower\"}",
              "hide": false,
              "legendFormat": "{{instance}} - {{quantile}}",
              "refId": "A"
            }
          ],
          "title": "FetchFollower - ResponseQueueTimeMs",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "A high value can imply the zero-copy from disk to the network is slow, or the network is the bottleneck because the network cant dequeue responses of the TCP socket as quickly as theyre being created. If the network buffer gets full, Kafka will block. ",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "ms"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 179
          },
          "id": 78,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_network_requestmetrics_responsesendtimems{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",quantile=~\"$percentile\",request=\"FetchFollower\"}",
              "hide": false,
              "legendFormat": "{{instance}} - {{quantile}}",
              "refId": "A"
            }
          ],
          "title": "FetchFollower - ResponseSendTimeMs",
          "type": "timeseries"
        },
        {
          "collapsed": false,
          "datasource": {
            "uid": "$datasource"
          },
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 187
          },
          "id": 97,
          "panels": [],
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "refId": "A"
            }
          ],
          "title": "Group Coordinator",
          "type": "row"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "Number of consumer groups per group coordinator",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 188
          },
          "id": 99,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_coordinator_group_groupmetadatamanager_numgroups{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"}",
              "instant": false,
              "interval": "",
              "legendFormat": "{{instance}}",
              "refId": "A"
            }
          ],
          "title": "Consumer groups number per coordinator",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "Number of consumer group per state",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 188
          },
          "id": 100,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(kafka_coordinator_group_groupmetadatamanager_numgroupsstable{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"})",
              "instant": false,
              "interval": "",
              "legendFormat": "stable",
              "refId": "A"
            },
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(kafka_coordinator_group_groupmetadatamanager_numgroupspreparingrebalance{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"})",
              "interval": "",
              "legendFormat": "preparing-rebalance",
              "refId": "B"
            },
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(kafka_coordinator_group_groupmetadatamanager_numgroupsdead{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"})",
              "interval": "",
              "legendFormat": "dead",
              "refId": "C"
            },
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(kafka_coordinator_group_groupmetadatamanager_numgroupscompletingrebalance{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"})",
              "interval": "",
              "legendFormat": "completing-rebalance",
              "refId": "D"
            },
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(kafka_coordinator_group_groupmetadatamanager_numgroupsempty{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"})",
              "interval": "",
              "legendFormat": "empty",
              "refId": "E"
            }
          ],
          "title": "Nb consumer groups per state",
          "type": "timeseries"
        },
        {
          "collapsed": false,
          "datasource": {
            "uid": "$datasource"
          },
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 196
          },
          "id": 102,
          "panels": [],
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "refId": "A"
            }
          ],
          "title": "Connections",
          "type": "row"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 197
          },
          "id": 104,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(kafka_server_socketservermetrics_connection_count{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"}) by (listener)",
              "interval": "",
              "legendFormat": "{{listener}}",
              "refId": "A"
            }
          ],
          "title": "Connections count per listener",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 197
          },
          "id": 105,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(kafka_server_socketservermetrics_connection_count{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"}) by (instance)",
              "interval": "",
              "legendFormat": "{{instance}}",
              "refId": "A"
            }
          ],
          "title": "Connections count per broker",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 205
          },
          "id": 106,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(kafka_server_socketservermetrics_connection_creation_rate{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"}) by (listener)",
              "interval": "",
              "legendFormat": "{{listener}}",
              "refId": "A"
            }
          ],
          "title": "Connections creation rate per listener",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 205
          },
          "id": 107,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(kafka_server_socketservermetrics_connection_creation_rate{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"}) by (instance)",
              "interval": "",
              "legendFormat": "{{instance}}",
              "refId": "A"
            }
          ],
          "title": "Connections creation rate per instance",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 213
          },
          "id": 108,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(kafka_server_socketservermetrics_connection_close_rate{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"}) by (listener)",
              "interval": "",
              "legendFormat": "{{listener}}",
              "refId": "A"
            }
          ],
          "title": "Connections close rate per listener",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 213
          },
          "id": 110,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(kafka_server_socketservermetrics_connection_close_rate{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"}) by (instance)",
              "interval": "",
              "legendFormat": "{{instance}}",
              "refId": "A"
            }
          ],
          "title": "Connections close rate per instance",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "Tracks the amount of time Acceptor is blocked from accepting connections. See KIP-402 for more details.",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "percent"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 221
          },
          "id": 124,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "kafka_network_acceptor_acceptorblockedpercent{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"}",
              "interval": "",
              "legendFormat": "{{instance}} - {{listener}}",
              "refId": "A"
            }
          ],
          "title": "Acceptor Blocked Percentage",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 221
          },
          "id": 113,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(kafka_server_socketservermetrics_connections{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"}) by (client_software_name, client_software_version)",
              "interval": "",
              "legendFormat": "{{client_software_name}} {{client_software_version}}",
              "refId": "A"
            }
          ],
          "title": "Connections per client version",
          "type": "timeseries"
        },
        {
          "collapsed": false,
          "datasource": {
            "uid": "$datasource"
          },
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 229
          },
          "id": 31,
          "panels": [],
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "refId": "A"
            }
          ],
          "title": "Request rate",
          "type": "row"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "Total request rate.",
          "fieldConfig": {
            "defaults": {
              "mappings": [
                {
                  "options": {
                    "match": "null",
                    "result": {
                      "text": "N/A"
                    }
                  },
                  "type": "special"
                }
              ],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  }
                ]
              },
              "unit": "none"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 4,
            "x": 0,
            "y": 230
          },
          "id": 37,
          "maxDataPoints": 100,
          "options": {
            "colorMode": "value",
            "fieldOptions": {
              "calcs": [
                "lastNotNull"
              ]
            },
            "graphMode": "area",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "last"
              ],
              "fields": "",
              "values": false
            },
            "text": {},
            "textMode": "auto",
            "wideLayout": true
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(rate(kafka_network_requestmetrics_requestspersec{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"}[$__rate_interval]))",
              "interval": "",
              "legendFormat": "",
              "refId": "A"
            }
          ],
          "title": "Total Request Per Sec",
          "type": "stat"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "Produce request rate.",
          "fieldConfig": {
            "defaults": {
              "mappings": [
                {
                  "options": {
                    "match": "null",
                    "result": {
                      "text": "N/A"
                    }
                  },
                  "type": "special"
                }
              ],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  }
                ]
              },
              "unit": "none"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 4,
            "x": 4,
            "y": 230
          },
          "id": 112,
          "maxDataPoints": 100,
          "options": {
            "colorMode": "value",
            "fieldOptions": {
              "calcs": [
                "lastNotNull"
              ]
            },
            "graphMode": "area",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "last"
              ],
              "fields": "",
              "values": false
            },
            "text": {},
            "textMode": "auto",
            "wideLayout": true
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(rate(kafka_network_requestmetrics_requestspersec{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",request=\"Produce\"}[$__rate_interval]))",
              "interval": "",
              "legendFormat": "",
              "refId": "A"
            }
          ],
          "title": "Produce Request Per Sec",
          "type": "stat"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "Fetch request rate.",
          "fieldConfig": {
            "defaults": {
              "mappings": [
                {
                  "options": {
                    "match": "null",
                    "result": {
                      "text": "N/A"
                    }
                  },
                  "type": "special"
                }
              ],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  }
                ]
              },
              "unit": "none"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 4,
            "x": 8,
            "y": 230
          },
          "id": 111,
          "maxDataPoints": 100,
          "options": {
            "colorMode": "value",
            "fieldOptions": {
              "calcs": [
                "lastNotNull"
              ]
            },
            "graphMode": "area",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "last"
              ],
              "fields": "",
              "values": false
            },
            "text": {},
            "textMode": "auto",
            "wideLayout": true
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(rate(kafka_network_requestmetrics_requestspersec{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",request=\"FetchConsumer\"}[$__rate_interval]))",
              "interval": "",
              "legendFormat": "",
              "refId": "A"
            }
          ],
          "title": "Fetch Request Per Sec",
          "type": "stat"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "Offset Commit request rate.",
          "fieldConfig": {
            "defaults": {
              "mappings": [
                {
                  "options": {
                    "match": "null",
                    "result": {
                      "text": "N/A"
                    }
                  },
                  "type": "special"
                }
              ],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  }
                ]
              },
              "unit": "none"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 4,
            "x": 12,
            "y": 230
          },
          "id": 38,
          "maxDataPoints": 100,
          "options": {
            "colorMode": "value",
            "fieldOptions": {
              "calcs": [
                "lastNotNull"
              ]
            },
            "graphMode": "area",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "last"
              ],
              "fields": "",
              "values": false
            },
            "text": {},
            "textMode": "auto",
            "wideLayout": true
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(rate(kafka_network_requestmetrics_requestspersec{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",request=\"OffsetCommit\"}[$__rate_interval]))",
              "interval": "",
              "legendFormat": "",
              "refId": "A"
            }
          ],
          "title": "Offset Commit Request Per Sec",
          "type": "stat"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "Metadata request rate.",
          "fieldConfig": {
            "defaults": {
              "mappings": [
                {
                  "options": {
                    "match": "null",
                    "result": {
                      "text": "N/A"
                    }
                  },
                  "type": "special"
                }
              ],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  }
                ]
              },
              "unit": "none"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 4,
            "x": 16,
            "y": 230
          },
          "id": 36,
          "maxDataPoints": 100,
          "options": {
            "colorMode": "value",
            "fieldOptions": {
              "calcs": [
                "lastNotNull"
              ]
            },
            "graphMode": "area",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "last"
              ],
              "fields": "",
              "values": false
            },
            "text": {},
            "textMode": "auto",
            "wideLayout": true
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(rate(kafka_network_requestmetrics_requestspersec{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",request=\"Metadata\"}[$__rate_interval]))",
              "interval": "",
              "legendFormat": "",
              "refId": "A"
            }
          ],
          "title": "Metadata Request Per Sec",
          "type": "stat"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 234
          },
          "id": 94,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(rate(kafka_server_brokertopicmetrics_totalproducerequestspersec{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",topic=~\"$topic\"}[$__rate_interval])) by (topic)",
              "interval": "",
              "legendFormat": "{{topic}}",
              "refId": "A"
            }
          ],
          "title": "Produce request per sec per topic",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 234
          },
          "id": 95,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(rate(kafka_server_brokertopicmetrics_totalfetchrequestspersec{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\",topic=~\"$topic\"}[$__rate_interval])) by (topic)",
              "interval": "",
              "legendFormat": "{{topic}}",
              "refId": "A"
            }
          ],
          "title": "Fetch request per sec per topic",
          "type": "timeseries"
        },
        {
          "collapsed": false,
          "datasource": {
            "uid": "$datasource"
          },
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 242
          },
          "id": 46,
          "panels": [],
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "refId": "A"
            }
          ],
          "title": "Message Conversion",
          "type": "row"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "The number of messages produced converted to match the log.message.format.version.",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "iops"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 243
          },
          "id": 48,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(rate(kafka_server_brokertopicmetrics_producemessageconversionspersec{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"}[$__rate_interval]))",
              "hide": false,
              "interval": "",
              "legendFormat": "",
              "refId": "A"
            }
          ],
          "title": "Number of procuded message conversion",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "${datasource}"
          },
          "description": "The number of messages consumed converted at consumer to match the log.message.format.version.",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "links": [],
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "iops"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 243
          },
          "id": 51,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "10.2.3",
          "targets": [
            {
              "datasource": {
                "uid": "${datasource}"
              },
              "expr": "sum(rate(kafka_server_brokertopicmetrics_fetchmessageconversionspersec{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"}[$__rate_interval]))",
              "hide": false,
              "interval": "",
              "legendFormat": "{{topic}}",
              "refId": "A"
            }
          ],
          "title": "Number of consumed message conversion",
          "type": "timeseries"
        },
        {
          "datasource": {
            "uid": "$datasource"
          },
          "description": "Number of connection per client version",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                }
              },
              "mappings": []
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 251
          },
          "id": 115,
          "options": {
            "displayLabels": [],
            "legend": {
              "displayMode": "list",
              "placement": "right",
              "showLegend": true,
              "values": []
            },
            "pieType": "pie",
            "reduceOptions": {
              "calcs": [
                "lastNotNull"
              ],
              "fields": "",
              "values": false
            },
            "text": {},
            "tooltip": {
              "mode": "single",
              "sort": "none"
            }
          },
          "targets": [
            {
              "datasource": {
                "uid": "$datasource"
              },
              "expr": "sum(kafka_server_socketservermetrics_connections{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"}) by (client_software_name, client_software_version) ",
              "interval": "",
              "legendFormat": "{{client_software_name}} - {{client_software_version}}",
              "refId": "A"
            }
          ],
          "title": "Client version repartition",
          "type": "piechart"
        }
      ],
      "refresh": "30s",
      "schemaVersion": 39,
      "tags": [
        "kafka-integration"
      ],
      "templating": {
        "list": [
          {
            "current": {
              "selected": false,
              "text": "default",
              "value": "default"
            },
            "hide": 2,
            "includeAll": false,
            "label": "Data source",
            "multi": false,
            "name": "datasource",
            "options": [],
            "query": "prometheus",
            "refresh": 1,
            "regex": "",
            "skipUrlSync": false,
            "type": "datasource"
          },
          {
            "allValue": ".+",
            "current": {
              "selected": false,
              "text": "All",
              "value": "$__all"
            },
            "datasource": {
              "type": "prometheus",
              "uid": "${datasource}"
            },
            "definition": "",
            "hide": 2,
            "includeAll": true,
            "label": "Job",
            "multi": true,
            "name": "job",
            "options": [],
            "query": "label_values(kafka_server_kafkaserver_brokerstate{job=~\"$job\"}, job)",
            "refresh": 2,
            "regex": "",
            "skipUrlSync": false,
            "sort": 1,
            "type": "query"
          },
          {
            "allValue": ".*",
            "current": {
              "selected": false,
              "text": "${namespace}",
              "value": "${namespace}"
            },
            "datasource": {
              "uid": "$datasource"
            },
            "definition": "",
            "hide": 0,
            "includeAll": true,
            "label": "Namespace",
            "multi": true,
            "name": "namespace",
            "options": [],
            "query": "label_values({pod=~\".*kafka.*\",job!=\"kubelet\",job!=\"kube-state-metrics\"},namespace)",
            "refresh": 2,
            "regex": "",
            "skipUrlSync": false,
            "sort": 1,
            "tagValuesQuery": "",
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          },
          {
            "allValue": ".+",
            "current": {
              "selected": false,
              "text": "All",
              "value": "$__all"
            },
            "datasource": {
              "type": "prometheus",
              "uid": "${datasource}"
            },
            "definition": "",
            "hide": 0,
            "includeAll": true,
            "label": "Instance",
            "multi": true,
            "name": "instance",
            "options": [],
            "query": "label_values({namespace=~\"$namespace\",pod=~\".*kafka.*\",job!=\"kubelet\",job!=\"kube-state-metrics\"}, instance)",
            "refresh": 2,
            "regex": "",
            "skipUrlSync": false,
            "sort": 1,
            "type": "query"
          },
          {
            "allValue": ".+",
            "current": {
              "selected": true,
              "text": [
                "All"
              ],
              "value": [
                "$__all"
              ]
            },
            "datasource": {
              "uid": "${datasource}"
            },
            "definition": "label_values(kafka_network_requestmetrics_requestqueuetimems{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"}, quantile)",
            "hide": 0,
            "includeAll": true,
            "label": "Percentile",
            "multi": true,
            "name": "percentile",
            "options": [],
            "query": "label_values(kafka_network_requestmetrics_requestqueuetimems{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"}, quantile)",
            "refresh": 2,
            "regex": "",
            "skipUrlSync": false,
            "sort": 0,
            "tagValuesQuery": "",
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          },
          {
            "allValue": ".+",
            "current": {
              "selected": false,
              "text": "All",
              "value": "$__all"
            },
            "datasource": {
              "uid": "${datasource}"
            },
            "definition": "label_values(kafka_log_log_size{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"},topic)",
            "hide": 0,
            "includeAll": true,
            "label": "Topic",
            "multi": true,
            "name": "topic",
            "options": [],
            "query": "label_values(kafka_log_log_size{job=~\"$job\",namespace=~\"$namespace\",instance=~\"$instance\"},topic)",
            "refresh": 2,
            "regex": "",
            "skipUrlSync": false,
            "sort": 0,
            "tagValuesQuery": "",
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          }
        ]
      },
      "time": {
        "from": "now-30m",
        "to": "now"
      },
      "timeRangeUpdatedDuringEditOrView": false,
      "timepicker": {
        "refresh_intervals": [
          "10s",
          "30s",
          "1m",
          "5m",
          "15m",
          "30m",
          "1h",
          "2h",
          "1d"
        ],
        "time_options": [
          "5m",
          "15m",
          "1h",
          "6h",
          "12h",
          "24h",
          "2d",
          "7d",
          "30d"
        ]
      },
      "timezone": "browser",
      "title": "Kafka Overview",
      "uid": "kafka001",
      "version": 1,
      "weekStart": ""
    }
    </#noparse>
```

### bootstrap.sh

==该文件存在于service-common路径下==

`添加格式化目录的操作`

```shell
#!/bin/bash
set -e

mkdir -p /workspace/logs

\cp -f /opt/service-render-output/* $KAFKA_HOME/config/

## 打印调试信息
#echo "当前工作目录: $(pwd)"
#echo "KAFKA_HOME: $KAFKA_HOME"
#
#echo "查找文件"
#ls -l /
#ls -l /cluster_id.txt

# 从 cluster_id.txt 文件中读取 CLUSTER_ID
if [[ -f "/cluster_id.txt" ]]; then
    CLUSTER_ID=$(cat /cluster_id.txt | tr -d '\r\n')
    echo "Cluster ID 读取成功: $CLUSTER_ID"
else
    echo "错误：未找到 cluster_id.txt 文件，请检查路径 /cluster_id.txt"
    exit 1
fi

# 格式化存储目录
$KAFKA_HOME/bin/kafka-storage.sh format -t "$CLUSTER_ID" -c $KAFKA_HOME/config/server.properties
#bin/kafka-storage.sh format --standalone -t $CLUSTER_ID -c config/server.properties

# 加载环境变量
source $KAFKA_HOME/config/kafka-env.sh
# 启动Kafka
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties

echo "---------------------------------------------开始----------------------------------------------"
tail -f /dev/null

# 功能测试，不会自动执行

kafka-topics.sh --zookeeper $HOSTNAME:$ZK_CLIENT_PORT/kafka --create --topic t1 --partitions 1 --replication-factor 1
kafka-topics.sh --zookeeper $HOSTNAME:$ZK_CLIENT_PORT/kafka --list

kafka-console-producer.sh --bootstrap-server $HOSTNAME:$KAFKA_PORT --topic t1
kafka-console-consumer.sh --bootstrap-server $HOSTNAME:$KAFKA_PORT --from-beginning  --topic t1
```

### kafka-env.sh.ftl【可选】

==该文件位于service-render路径下==

`根据你选择的JDK版本，选择相关的JDK启动配置`

```shell
export LOG_DIR="/workspace/logs"
<#assign heapRamPercentage = conf['kafka.server.heap.memory.percentage']?number>
<#assign directRamPercentage = conf['kafka.server.direct.memory.percentage']?number>
export heapRam=$[ $MEM_LIMIT / 1024 / 1024  * ${heapRamPercentage} / 100 ]M
export directRam=$[ $MEM_LIMIT / 1024 / 1024  * ${directRamPercentage} / 100 ]M

# 环境变量由kafka-run-class.sh注入
export JMX_PORT=${conf['kafka.jmx.port']}
export KAFKA_HEAP_OPTS="-Xmx$heapRam -Xms$heapRam -XX:MaxDirectMemorySize=$directRam"

<#--如果选择JDK8版本-->
<#--export KAFKA_OPTS="$KAFKA_OPTS -javaagent:/opt/jmx_exporter/jmx_prometheus_javaagent.jar=5551:$KAFKA_HOME/config/jmx_prometheus.yaml"-->
<#--export KAFKA_OPTS="$KAFKA_OPTS -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:/workspace/logs/gc-kafka-broker.log"-->
<#--如果选择JDK17版本-->
export KAFKA_OPTS="$KAFKA_OPTS -javaagent:/opt/jmx_exporter/jmx_prometheus_javaagent.jar=5551:$KAFKA_HOME/config/jmx_prometheus.yaml"
export KAFKA_OPTS="$KAFKA_OPTS -Xlog:gc*:file=/workspace/logs/gc-kafka-broker.log:time,tags,uptime,pid:filecount=10,filesize=10M"
```

### server.properties.ftl

==该文件位于service-render路径下==

`新增：KRaft 模式相关配置并写死log.dirs参数项`

```shell
<#if conf["data.path.list"]?? && conf["data.path.list"]?trim?has_content>
    <#assign dataPathListSize=conf["data.path.list"]?trim?split(",")?size>
<#else>
    <#assign dataPathListSize=1>
</#if>

<#assign hosts=serviceRoles['KAFKA_BROKER']>
<#list hosts as host>
    <#if host.hostname == HOSTNAME>
        broker.id=${host.id % 254 + 1}
        node.id=${host.id % 254 + 1}
    </#if>
</#list>

<#--<#assign concatenatedPaths="">-->
<#--<#list 1..dataPathListSize as dataPathIndex>-->
<#--    <#assign concatenatedPaths = concatenatedPaths + "/data/${dataPathIndex}">-->
<#--    <#if dataPathIndex < dataPathListSize>-->
<#--        <#assign concatenatedPaths = concatenatedPaths + ",">-->
<#--    </#if>-->
<#--</#list>-->
<#--log.dirs=${concatenatedPaths}-->
log.dirs=/data/kafka

listeners=PLAINTEXT://${HOSTNAME}:${conf['kafka.listeners.port']},CONTROLLER://${HOSTNAME}:9093
listener.security.protocol.map=PLAINTEXT:PLAINTEXT,CONTROLLER:PLAINTEXT
<#--advertised.listeners=PLAINTEXT://${HOSTNAME}:${conf['kafka.listeners.port']}-->

<!-- 新增：KRaft 模式相关配置 -->
process.roles=broker,controller
controller.quorum.voters=<#list hosts as host>${host.id % 254 + 1}@${host.hostname}:9093<#if host_has_next>,</#if></#list>
controller.listener.names=CONTROLLER

<#--启用控制器选举，确保集群的稳定性。-->
controller-election.enable=true

<#list confFiles['server.properties']?keys as key>
    ${key}=${confFiles['server.properties'][key]}
</#list>
```

>注意：这里不推荐使用原先通过FreeMarker 模板动态生成 Kafka 的 `log.dirs` 配置项。如果部署的是多节点，那么会导致多次格式化目录报错。推荐直接写死log.dirs。

### service-info.yaml

==该文件直接位于Kafka路径下==

`删除Zookeeper相关配置项`

```shell
name: KAFKA
label: "Kafka"
description: "Kafka分布式事件流系统"
version: 3.9.0

supportKerberos: false

dashboard:
  uid: "kafka001"

roles:
  - name: KAFKA_BROKER
    label: "Kafka Broker"
    roleFullName: "kafka-broker"
    sortNum: 1
    type: DEPLOYMENT
    minNum : 1

customConfigFiles:
  - server.properties

configurations:
  - name: serverImage
    description: "服务镜像"
    recommendExpression: "registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/kafka:3.9.0"
    valueType: InputString
    configurableInWizard: true
    tag: "镜像"

  - name: data.path.list
    description: "持久化挂载路径列表，逗号分隔(但当前组件只有第一个路径生效)。当为空时使用默认路径：全局参数global.persistence.basePath/角色名称"
    recommendExpression: ""
    valueType: InputString
    configurableInWizard: true
    tag: "资源管理"

  - name: "kafka.listeners.port"
    recommendExpression: 9092
    valueType: InputNumber
    configurableInWizard: true
    description: "Kafka监听端口"
    tag: "端口"
  - name: "kafka.jmx.port"
    recommendExpression: 9921
    valueType: InputNumber
    configurableInWizard: true
    description: "Kafka JMX监听端口"
    tag: "端口"
  - name: kafka.container.limit.cpu
    description: "Kafka Server容器的CPU使用限额"
    recommendExpression: 1.0
    valueType: InputNumber
    configurableInWizard: true
    tag: "资源管理"
  - name: kafka.container.limit.memory
    description: "Kafka Server容器的内存使用限额，单位MB"
    recommendExpression: 2048
    valueType: InputNumber
    unit: Mi
    configurableInWizard: true
    tag: "资源管理"
  - name: kafka.container.request.cpu
    description: "Kafka Server容器的CPU请求量"
    recommendExpression: 0.2
    valueType: InputNumber
    configurableInWizard: true
    tag: "资源管理"
  - name: kafka.container.request.memory
    description: "Kafka Server容器的内存请求量，单位MB"
    recommendExpression: 1024
    valueType: InputNumber
    unit: Mi
    configurableInWizard: true
    tag: "资源管理"
  - name: kafka.server.heap.memory.percentage
    description: "Kafka Server 堆内存占容器内存限额的百分比，用于Kafka jvm，需预留内存供pagecache使用"
    recommendExpression: 25
    valueType: InputNumber
    unit: ".0"
    configurableInWizard: true
    tag: "资源管理"
  - name: kafka.server.direct.memory.percentage
    description: "Kafka Server 直接内存占容器内存限额的百分比，用于Kafka 网络IO，需预留内存供pagecache使用"
    recommendExpression: 25
    valueType: InputNumber
    unit: ".0"
    configurableInWizard: true
    tag: "资源管理"
  - name: "num.partitions"
    recommendExpression: 8
    valueType: InputNumber
    confFile:  "server.properties"
    description: "Kafka分区数"
    tag: "常用参数"
  - name: "offsets.topic.replication.factor"
    recommendExpression: 2
    valueType: InputNumber
    confFile:  "server.properties"
    description: "内置Topic副本数"
    tag: "常用参数"
  - name: "default.replication.factor"
    recommendExpression: 2
    valueType: InputNumber
    confFile:  "server.properties"
    description: "Topic副本数"
    tag: "常用参数"
  - name: "log.retention.hours"
    recommendExpression: 168
    valueType: InputNumber
    confFile:  "server.properties"
    description: "数据保留时间"
    unit: Hour
    tag: "常用参数"
  - name: "auto.create.topics.enable"
    recommendExpression: "false"
    valueType: Switch
    configurableInWizard: true
    description: 是否允许自动创建Topic
    confFile:  "server.properties"
    tag: "常用参数"
  - name: "unclean.leader.election.enable"
    recommendExpression: "false"
    valueType: Switch
    configurableInWizard: true
    description: "是否允许Unclean Leader选举"
    confFile:  "server.properties"
    tag: "高级参数"
  - name: "auto.leader.rebalance.enable"
    recommendExpression: "true"
    valueType: Switch
    configurableInWizard: true
    description: "是否允许Leader重平衡"
    confFile:  "server.properties"
    tag: "高级参数"
  - name: "message.max.bytes"
    recommendExpression: "1000012"
    valueType: InputNumber
    configurableInWizard: true
    unit: bytes
    description: "Broker能够接收的一条消息最大大小"
    confFile:  "server.properties"
    tag: "性能"
  - name: "message.max.bytes"
    recommendExpression: "1048576"
    valueType: InputNumber
    configurableInWizard: true
    unit: bytes
    description: "kafka接收单个消息size的最大限制,默认为1M左右 message.max.bytes必须小于等于replica.fetch.max.bytes"
    confFile:  "server.properties"
    tag: "性能"
  - name: "num.network.threads"
    recommendExpression: "3"
    valueType: InputNumber
    configurableInWizard: false
    description: "server用来处理网络请求的网络线程数目"
    confFile:  "server.properties"
    tag: "性能"
  - name: "num.io.threads"
    recommendExpression: "12"
    valueType: InputNumber
    configurableInWizard: true
    description: "server用来处理请求的I/O线程的数目；这个线程数目至少要等于硬盘的个数。"
    confFile:  "server.properties"
    tag: "性能"
  - name: "queued.max.requests"
    recommendExpression: "500"
    valueType: InputNumber
    configurableInWizard: false
    description: "在网络线程停止读取新请求之前，可以排队等待I/O线程处理的最大请求个数"
    confFile:  "server.properties"
    tag: "性能"
  - name: "socket.receive.buffer.bytes"
    recommendExpression: "102400"
    valueType: InputNumber
    configurableInWizard: false
    description: "socket接收服务的缓存区大小"
    confFile:  "server.properties"
    unit: bytes
    tag: "性能"
  - name: "socket.send.buffer.bytes"
    recommendExpression: "102400"
    valueType: InputNumber
    configurableInWizard: false
    description: "socket发送服务的缓存区大小"
    confFile:  "server.properties"
    unit: bytes
    tag: "性能"
  - name: "socket.request.max.bytes"
    recommendExpression: "102857600"
    valueType: InputNumber
    configurableInWizard: false
    description: "socket每次请求的最大字节数"
    confFile:  "server.properties"
    unit: bytes
    tag: "性能"
  - name: "log.flush.interval.messages"
    recommendExpression: "1000000"
    valueType: InputNumber
    configurableInWizard: false
    description: "在将消息刷新到磁盘之前，日志分区上累积的消息数，该值将影响PageCache的大小"
    confFile:  "server.properties"
    tag: "性能"
  - name: "log.flush.interval.ms"
    recommendExpression: "10000"
    valueType: InputNumber
    configurableInWizard: false
    description: "任何主题中的消息在刷新到磁盘之前保存在内存中的最长时间(以毫秒为单位)，该值将影响PageCache的大小"
    confFile:  "server.properties"
    unit: ms
    tag: "性能"
  - name: "log.flush.scheduler.interval.ms"
    recommendExpression: "10000"
    valueType: InputNumber
    configurableInWizard: false
    description: "日志刷新程序检查是否需要将日志刷新到磁盘的频率(以毫秒为单位)，该值将影响PageCache的大小"
    confFile:  "server.properties"
    unit: ms
    tag: "性能"

```

## 构建镜像

```shell
docker build -t kafka:4.0.0 . --no-cache
```

## 安装

略

## 拓展

>如果Cloudeon集成高版本Kafka-Zookeeper模式，比如安装Kafka3.9.0基于Zookeeper存储元数据，在源码的基础直接修改Dockerfile文件更改Kafka构建镜像安装即可。