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