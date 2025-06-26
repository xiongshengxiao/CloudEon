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
      "description": "MinIO Version: RELEASE.2025-04-22T22-12-26Z",
      "editable": true,
      "fiscalYearStartMonth": 0,
      "graphTooltip": 0,
      "id": 45,
      "links": [],
      "panels": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "",
          "fieldConfig": {
            "defaults": {
              "color": {
                "fixedColor": "rgb(31, 120, 193)",
                "mode": "thresholds"
              },
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
              "unit": "dtdurations"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 6,
            "w": 3,
            "x": 0,
            "y": 0
          },
          "id": 25,
          "maxDataPoints": 100,
          "options": {
            "colorMode": "value",
            "graphMode": "area",
            "justifyMode": "auto",
            "orientation": "auto",
            "percentChangeColorMode": "standard",
            "reduceOptions": {
              "calcs": [
                "mean"
              ],
              "fields": "",
              "values": false
            },
            "showPercentChange": false,
            "textMode": "auto",
            "wideLayout": true
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "datasource": {
                "uid": "${DS_PROMETHEUS}"
              },
              "editorMode": "code",
              "expr": "time() - max(process_start_time_seconds{})",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "Uptime",
              "metric": "process_start_time_seconds",
              "range": true,
              "refId": "A",
              "step": 60
            }
          ],
          "title": "Uptime",
          "type": "stat"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
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
              "mappings": [
                {
                  "options": {
                    "null": {
                      "index": 0,
                      "text": "N/A"
                    }
                  },
                  "type": "value"
                }
              ],
              "unit": "bytes"
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "Free"
                },
                "properties": [
                  {
                    "id": "color",
                    "value": {
                      "fixedColor": "green",
                      "mode": "fixed"
                    }
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Used"
                },
                "properties": [
                  {
                    "id": "color",
                    "value": {
                      "fixedColor": "orange",
                      "mode": "fixed"
                    }
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 6,
            "w": 3,
            "x": 3,
            "y": 0
          },
          "id": 26,
          "options": {
            "legend": {
              "displayMode": "table",
              "placement": "bottom",
              "showLegend": true,
              "values": [
                "percent"
              ]
            },
            "pieType": "donut",
            "reduceOptions": {
              "calcs": [
                "lastNotNull"
              ],
              "fields": "",
              "values": false
            },
            "tooltip": {
              "mode": "single",
              "sort": "none"
            }
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "editorMode": "code",
              "expr": "topk(1, sum(minio_capacity_usable_total{})) - topk(1, sum(minio_capacity_usable_free_total{}))",
              "interval": "1m",
              "legendFormat": "Used",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "topk(1, sum(minio_capacity_usable_free_total{}))",
              "hide": false,
              "interval": "1m",
              "legendFormat": "Free",
              "range": true,
              "refId": "B"
            }
          ],
          "title": "Capacity",
          "type": "piechart"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "Total capacity of disks in current MinIO server instances（集群总容量）",
          "fieldConfig": {
            "defaults": {
              "color": {
                "fixedColor": "rgb(31, 120, 193)",
                "mode": "fixed"
              },
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
            "overrides": []
          },
          "gridPos": {
            "h": 3,
            "w": 2,
            "x": 6,
            "y": 0
          },
          "id": 14,
          "maxDataPoints": 100,
          "options": {
            "colorMode": "none",
            "graphMode": "area",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "percentChangeColorMode": "standard",
            "reduceOptions": {
              "calcs": [
                "mean"
              ],
              "fields": "",
              "values": false
            },
            "showPercentChange": false,
            "textMode": "auto",
            "wideLayout": true
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "datasource": {
                "uid": "${DS_PROMETHEUS}"
              },
              "expr": "sum(disk_storage_total)",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "Total number of disks for current MinIO server instances",
              "metric": "process_start_time_seconds",
              "refId": "A",
              "step": 60
            }
          ],
          "title": "Total Capacity",
          "type": "stat"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "Number of total/offline disks for current MinIO server instances（集群实例状态）",
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
                "barWidthFactor": 0.6,
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
              "decimals": 0,
              "mappings": [],
              "min": 0,
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
              "unit": "short"
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "Offline 10.13.1.25:9000"
                },
                "properties": [
                  {
                    "id": "color",
                    "value": {
                      "fixedColor": "dark-red",
                      "mode": "fixed"
                    }
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "Total 10.13.1.25:9000"
                },
                "properties": [
                  {
                    "id": "color",
                    "value": {
                      "fixedColor": "blue",
                      "mode": "fixed"
                    }
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 6,
            "w": 8,
            "x": 8,
            "y": 0
          },
          "id": 10,
          "options": {
            "dataLinks": [],
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
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "datasource": {
                "uid": "${DS_PROMETHEUS}"
              },
              "expr": "sum(minio_disks_offline)",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "Offline instance",
              "metric": "process_start_time_seconds",
              "refId": "A",
              "step": 60
            },
            {
              "datasource": {
                "uid": "${DS_PROMETHEUS}"
              },
              "expr": "sum(minio_disks_total{})",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "Total instance",
              "metric": "process_start_time_seconds",
              "refId": "B",
              "step": 60
            }
          ],
          "title": "Total/Offline disks for current MinIO server instances",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "Storage space usage（硬盘使用率）",
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
                "barWidthFactor": 0.6,
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
              "mappings": [],
              "min": 0,
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
                  "options": "available 10.13.1.25:9000"
                },
                "properties": [
                  {
                    "id": "color",
                    "value": {
                      "fixedColor": "green",
                      "mode": "fixed"
                    }
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "used 10.13.1.25:9000"
                },
                "properties": [
                  {
                    "id": "color",
                    "value": {
                      "fixedColor": "blue",
                      "mode": "fixed"
                    }
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 6,
            "w": 8,
            "x": 16,
            "y": 0
          },
          "id": 12,
          "options": {
            "dataLinks": [],
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
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "datasource": {
                "uid": "${DS_PROMETHEUS}"
              },
              "editorMode": "code",
              "expr": "disk_storage_used{} / disk_storage_total{} * 100",
              "format": "time_series",
              "hide": false,
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "{{disk}}",
              "metric": "process_start_time_seconds",
              "range": true,
              "refId": "A",
              "step": 60
            }
          ],
          "title": "Storage usage",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "Used capacity of disks in current MinIO server instances（集群已使用空间）",
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
                    "color": "rgba(50, 172, 45, 0.97)",
                    "value": null
                  },
                  {
                    "color": "rgba(237, 129, 40, 0.89)",
                    "value": 1
                  },
                  {
                    "color": "rgba(245, 54, 54, 0.9)",
                    "value": 2
                  }
                ]
              },
              "unit": "decbytes"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 3,
            "w": 2,
            "x": 6,
            "y": 3
          },
          "id": 16,
          "maxDataPoints": 100,
          "options": {
            "colorMode": "value",
            "graphMode": "area",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "percentChangeColorMode": "standard",
            "reduceOptions": {
              "calcs": [
                "mean"
              ],
              "fields": "",
              "values": false
            },
            "showPercentChange": false,
            "textMode": "auto",
            "wideLayout": true
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "datasource": {
                "uid": "${DS_PROMETHEUS}"
              },
              "expr": "sum(disk_storage_used)",
              "format": "time_series",
              "interval": "",
              "intervalFactor": 2,
              "legendFormat": "Total number of offline disks for current MinIO server instances",
              "metric": "process_start_time_seconds",
              "refId": "A",
              "step": 60
            }
          ],
          "title": "Used Capacity",
          "type": "stat"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "Data sent by current MinIO server instance（集群内部节点数据传输(B/s)）",
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
                "barWidthFactor": 0.6,
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
              "unit": "decbytes"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 0,
            "y": 6
          },
          "id": 4,
          "options": {
            "dataLinks": [],
            "legend": {
              "calcs": [
                "lastNotNull",
                "sum"
              ],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "none"
            }
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "datasource": {
                "uid": "${DS_PROMETHEUS}"
              },
              "editorMode": "code",
              "expr": "rate(internode_tx_bytes_total{job=\"metrics-minio\"}[$interval])",
              "format": "time_series",
              "instant": false,
              "intervalFactor": 2,
              "legendFormat": "传输字节数:",
              "metric": "minio_network_sent_bytes_total",
              "refId": "A",
              "step": 10
            },
            {
              "datasource": {
                "uid": "${DS_PROMETHEUS}"
              },
              "editorMode": "code",
              "expr": "rate(internode_rx_bytes_total{job=\"metrics-minio\"}[$interval])",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "接收字节数:",
              "range": true,
              "refId": "B"
            }
          ],
          "title": "Ingress/Egress of Inter Node (B/s)",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "Data received x transmited by current MinIO server instance（S3数据输入/输出(KB/s)）",
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
                "barWidthFactor": 0.6,
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
              "unit": "decbytes"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 8,
            "y": 6
          },
          "id": 6,
          "options": {
            "dataLinks": [],
            "legend": {
              "calcs": [
                "lastNotNull"
              ],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "none"
            }
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "datasource": {
                "uid": "${DS_PROMETHEUS}"
              },
              "editorMode": "code",
              "expr": "rate(s3_rx_bytes_total{}[$interval])",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "Received: ",
              "metric": "minio_network_received_bytes_total",
              "range": true,
              "refId": "A",
              "step": 10
            },
            {
              "datasource": {
                "uid": "${DS_PROMETHEUS}"
              },
              "editorMode": "code",
              "expr": "rate(s3_tx_bytes_total{}[$interval])",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "Transmited:",
              "range": true,
              "refId": "B",
              "step": 10
            }
          ],
          "title": "S3 Ingress/Egress (KB/s)",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "Total user and system CPU time spent in seconds（CPU 使用率）",
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
                "barWidthFactor": 0.6,
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
                  "options": "alloc rate"
                },
                "properties": [
                  {
                    "id": "unit",
                    "value": "s"
                  },
                  {
                    "id": "custom.axisPlacement",
                    "value": "right"
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 7,
            "w": 8,
            "x": 16,
            "y": 6
          },
          "id": 18,
          "options": {
            "dataLinks": [],
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
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "datasource": {
                "uid": "${DS_PROMETHEUS}"
              },
              "editorMode": "code",
              "expr": "rate(process_cpu_seconds_total{job=\"metrics-minio\"}[$interval])",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "Total CPU {{instance}}",
              "metric": "go_memstats_alloc_bytes",
              "range": true,
              "refId": "A",
              "step": 4
            }
          ],
          "title": "CPU usage",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "Data received by current MinIO server instance（S3接口总请求）",
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
                "barWidthFactor": 0.6,
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
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 8,
            "x": 0,
            "y": 13
          },
          "id": 5,
          "options": {
            "dataLinks": [],
            "legend": {
              "calcs": [
                "lastNotNull"
              ],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "none"
            }
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "datasource": {
                "uid": "${DS_PROMETHEUS}"
              },
              "editorMode": "code",
              "expr": "s3_requests_total",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "{{api}}",
              "metric": "minio_network_received_bytes_total",
              "range": true,
              "refId": "A",
              "step": 10
            }
          ],
          "title": "S3 API Requests Total",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "S3接口当前总请求数",
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
                "barWidthFactor": 0.6,
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
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 8,
            "x": 8,
            "y": 13
          },
          "id": 22,
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
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "datasource": {
                "uid": "${DS_PROMETHEUS}"
              },
              "editorMode": "code",
              "expr": "sum(s3_requests_current{}) by (api)",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "{{api}}",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "Total S3 API Requests of Current Instance",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "S3接口总错误请求数",
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
                "barWidthFactor": 0.6,
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
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 8,
            "x": 16,
            "y": 13
          },
          "id": 20,
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
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "datasource": {
                "uid": "${DS_PROMETHEUS}"
              },
              "editorMode": "code",
              "expr": "sum(s3_errors_total{}) by (api)",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "{{api}}",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "uid": "${DS_PROMETHEUS}"
              },
              "expr": "sum(s3_requests_current{instance=\"$metrics_port\",job=\"$job\"}) by (api)",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "{{api}}",
              "refId": "B"
            }
          ],
          "title": "S3 API Request Errors Total",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "The current aggregate time spent servicing all HTTP requests  in seconds（S3接口延迟统计）",
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
                "barWidthFactor": 0.6,
                "drawStyle": "line",
                "fillOpacity": 0,
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
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
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
              }
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 21
          },
          "id": 7,
          "options": {
            "dataLinks": [],
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "single",
              "sort": "none"
            }
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "datasource": {
                "uid": "${DS_PROMETHEUS}"
              },
              "editorMode": "code",
              "expr": "s3_ttfb_seconds_sum{}",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "{{api}}",
              "metric": "minio_http_requests_duration_seconds_count",
              "range": true,
              "refId": "E",
              "step": 4
            }
          ],
          "title": "S3 Requests Time Taken Sum",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "description": "HTTP请求状态",
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
                "barWidthFactor": 0.6,
                "drawStyle": "line",
                "fillOpacity": 0,
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
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
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
              }
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 21
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
              "mode": "single",
              "sort": "none"
            }
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "datasource": {
                "uid": "${DS_PROMETHEUS}"
              },
              "editorMode": "code",
              "expr": "sum(promhttp_metric_handler_requests_total{}) by (code)",
              "format": "time_series",
              "intervalFactor": 1,
              "legendFormat": "{{code}}",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "HTTP Requests Total by HTTP Code(200/500/503)",
          "type": "timeseries"
        }
      ],
      "preload": false,
      "refresh": "10s",
      "schemaVersion": 40,
      "tags": [],
      "templating": {
        "list": [
          {
            "current": {
              "text": "cloudeon-v2",
              "value": "cloudeon-v2"
            },
            "definition": "label_values({pod=~\".*minio.*\", job!=\"kubelet\", job!=\"kube-state-metrics\"},namespace)",
            "label": "Namespace",
            "name": "namespace",
            "options": [],
            "query": {
              "qryType": 1,
              "query": "label_values({pod=~\".*minio.*\", job!=\"kubelet\", job!=\"kube-state-metrics\"},namespace)",
              "refId": "PrometheusVariableQueryEditor-VariableQuery"
            },
            "refresh": 1,
            "regex": "",
            "sort": 1,
            "type": "query"
          },
          {
            "current": {
              "text": "All",
              "value": [
                "$__all"
              ]
            },
            "definition": "label_values({namespace=~\"$namespace\", pod=~\".*minio.*\", job!=\"kubelet\", job!=\"kube-state-metrics\"},instance)",
            "includeAll": true,
            "label": "Instance",
            "multi": true,
            "name": "instance",
            "options": [],
            "query": {
              "qryType": 1,
              "query": "label_values({namespace=~\"$namespace\", pod=~\".*minio.*\", job!=\"kubelet\", job!=\"kube-state-metrics\"},instance)",
              "refId": "PrometheusVariableQueryEditor-VariableQuery"
            },
            "refresh": 1,
            "regex": "",
            "sort": 1,
            "type": "query"
          },
          {
            "auto": false,
            "auto_count": 30,
            "auto_min": "10s",
            "current": {
              "text": "1m",
              "value": "1m"
            },
            "name": "interval",
            "options": [
              {
                "selected": true,
                "text": "1m",
                "value": "1m"
              },
              {
                "selected": false,
                "text": "10m",
                "value": "10m"
              },
              {
                "selected": false,
                "text": "30m",
                "value": "30m"
              },
              {
                "selected": false,
                "text": "1h",
                "value": "1h"
              },
              {
                "selected": false,
                "text": "6h",
                "value": "6h"
              },
              {
                "selected": false,
                "text": "12h",
                "value": "12h"
              },
              {
                "selected": false,
                "text": "1d",
                "value": "1d"
              },
              {
                "selected": false,
                "text": "7d",
                "value": "7d"
              },
              {
                "selected": false,
                "text": "14d",
                "value": "14d"
              },
              {
                "selected": false,
                "text": "30d",
                "value": "30d"
              }
            ],
            "query": "1m,10m,30m,1h,6h,12h,1d,7d,14d,30d",
            "refresh": 2,
            "type": "interval"
          }
        ]
      },
      "time": {
        "from": "now-1h",
        "to": "now"
      },
      "timepicker": {},
      "timezone": "Asia/Shanghai",
      "title": "MinIO 监控-cloudeon",
      "uid": "minio001",
      "version": 13,
      "weekStart": ""
    }
    </#noparse>