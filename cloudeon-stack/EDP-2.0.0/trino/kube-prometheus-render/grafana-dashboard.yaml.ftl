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
              "type": "grafana",
              "uid": "-- Grafana --"
            },
            "enable": true,
            "hide": true,
            "iconColor": "rgba(0, 211, 255, 1)",
            "name": "Annotations & Alerts",
            "type": "dashboard"
          }
        ]
      },
      "description": "Trino deploy on k8s, collect jmx to monitor cluster",
      "editable": true,
      "fiscalYearStartMonth": 0,
      "gnetId": 20208,
      "graphTooltip": 0,
      "id": 46,
      "links": [],
      "liveNow": false,
      "panels": [
        {
          "collapsed": false,
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 0
          },
          "id": 16,
          "panels": [],
          "title": "集群状态概况",
          "type": "row"
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
                "pointSize": 1,
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
              },
              "unit": "none",
              "unitScale": true
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 8,
            "x": 0,
            "y": 1
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
              "mode": "single",
              "sort": "none"
            }
          },
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_failuredetector_HeartbeatFailureDetector_ActiveCount{job=~\"$job\",namespace=~\"$namespace\"}",
              "instant": false,
              "legendFormat": "今日",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_failuredetector_HeartbeatFailureDetector_ActiveCount{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
              "hide": false,
              "instant": false,
              "legendFormat": "昨日",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_failuredetector_HeartbeatFailureDetector_ActiveCount{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
              "hide": false,
              "instant": false,
              "legendFormat": "七日前",
              "range": true,
              "refId": "C"
            }
          ],
          "title": "active worker数量",
          "type": "timeseries"
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
                "pointSize": 1,
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
              },
              "unit": "none",
              "unitScale": true
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 8,
            "x": 8,
            "y": 1
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
              "mode": "single",
              "sort": "none"
            }
          },
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryPool_BlockedNodes{job=~\"$job\",namespace=~\"$namespace\"}",
              "instant": false,
              "legendFormat": "今日",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryPool_BlockedNodes{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
              "hide": false,
              "instant": false,
              "legendFormat": "昨日",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryPool_BlockedNodes{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
              "hide": false,
              "instant": false,
              "legendFormat": "7日前",
              "range": true,
              "refId": "C"
            }
          ],
          "title": "blocked worker数量",
          "type": "timeseries"
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
                "pointSize": 1,
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
              },
              "unit": "none",
              "unitScale": true
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 8,
            "x": 16,
            "y": 1
          },
          "id": 19,
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
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryManager_TotalAvailableProcessors{job=~\"$job\",namespace=~\"$namespace\"}",
              "instant": false,
              "legendFormat": "今日",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryManager_TotalAvailableProcessors{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
              "hide": false,
              "instant": false,
              "legendFormat": "昨日",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryManager_TotalAvailableProcessors{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
              "hide": false,
              "instant": false,
              "legendFormat": "七日前",
              "range": true,
              "refId": "C"
            }
          ],
          "title": "CPU总核数",
          "type": "timeseries"
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
                "pointSize": 1,
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
              },
              "unit": "bytes",
              "unitScale": true
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 6,
            "x": 0,
            "y": 9
          },
          "id": 26,
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
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryPool_TotalDistributedBytes{job=~\"$job\",namespace=~\"$namespace\"}",
              "instant": false,
              "legendFormat": "今日",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryPool_TotalDistributedBytes{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
              "hide": false,
              "instant": false,
              "legendFormat": "昨日",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryPool_TotalDistributedBytes{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
              "hide": false,
              "instant": false,
              "legendFormat": "7日前",
              "range": true,
              "refId": "C"
            }
          ],
          "title": "Total Distributed Bytes (cluster memory pool)",
          "type": "timeseries"
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
                "pointSize": 1,
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
              },
              "unit": "bytes",
              "unitScale": true
            },
            "overrides": [
              {
                "__systemRef": "hideSeriesFrom",
                "matcher": {
                  "id": "byNames",
                  "options": {
                    "mode": "exclude",
                    "names": [
                      "lilith-trino-tb-master-今日"
                    ],
                    "prefix": "All except:",
                    "readOnly": true
                  }
                },
                "properties": [
                  {
                    "id": "custom.hideFrom",
                    "value": {
                      "legend": false,
                      "tooltip": false,
                      "viz": true
                    }
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 8,
            "w": 6,
            "x": 6,
            "y": 9
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
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryPool_FreeDistributedBytes{job=~\"$job\",namespace=~\"$namespace\"}",
              "instant": false,
              "legendFormat": "今日",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryPool_FreeDistributedBytes{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
              "hide": false,
              "instant": false,
              "legendFormat": "昨日",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryPool_FreeDistributedBytes{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
              "hide": false,
              "instant": false,
              "legendFormat": "7日前",
              "range": true,
              "refId": "C"
            }
          ],
          "title": "Free Distributed Bytes (cluster memory pool)",
          "type": "timeseries"
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
                "pointSize": 1,
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
              },
              "unit": "bytes",
              "unitScale": true
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 6,
            "x": 12,
            "y": 9
          },
          "id": 28,
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
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryPool_ReservedRevocableDistributedBytes{job=~\"$job\",namespace=~\"$namespace\"}",
              "instant": false,
              "legendFormat": "今日",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryPool_ReservedRevocableDistributedBytes{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
              "hide": false,
              "instant": false,
              "legendFormat": "昨日",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryPool_ReservedRevocableDistributedBytes{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
              "hide": false,
              "instant": false,
              "legendFormat": "7日前",
              "range": true,
              "refId": "C"
            }
          ],
          "title": "Reserved Revocable Distributed Bytes (cluster memory pool)",
          "type": "timeseries"
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
                "pointSize": 1,
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
              },
              "unit": "bytes",
              "unitScale": true
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 6,
            "x": 18,
            "y": 9
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
              "mode": "single",
              "sort": "none"
            }
          },
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryPool_ReservedDistributedBytes{job=~\"$job\",namespace=~\"$namespace\"}",
              "instant": false,
              "legendFormat": "今日",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryPool_ReservedDistributedBytes{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
              "hide": false,
              "instant": false,
              "legendFormat": "昨日",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryPool_ReservedDistributedBytes{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
              "hide": false,
              "instant": false,
              "legendFormat": "7日前",
              "range": true,
              "refId": "C"
            }
          ],
          "title": "Reserved Distributed Bytes (cluster memory pool)",
          "type": "timeseries"
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
                "pointSize": 1,
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
              },
              "unit": "bytes",
              "unitScale": true
            },
            "overrides": [
              {
                "__systemRef": "hideSeriesFrom",
                "matcher": {
                  "id": "byNames",
                  "options": {
                    "mode": "exclude",
                    "names": [
                      "lilith-trino-tb-master-今日"
                    ],
                    "prefix": "All except:",
                    "readOnly": true
                  }
                },
                "properties": [
                  {
                    "id": "custom.hideFrom",
                    "value": {
                      "legend": false,
                      "tooltip": false,
                      "viz": true
                    }
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 17
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
              "mode": "single",
              "sort": "none"
            }
          },
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryManager_ClusterUserMemoryReservation{job=~\"$job\",namespace=~\"$namespace\"}",
              "instant": false,
              "legendFormat": "今日",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryManager_ClusterUserMemoryReservation{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
              "hide": false,
              "instant": false,
              "legendFormat": "昨日",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryManager_ClusterUserMemoryReservation{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
              "hide": false,
              "instant": false,
              "legendFormat": "7日前",
              "range": true,
              "refId": "C"
            }
          ],
          "title": "Cluster User Memory Reservation (Running查询使用总和)",
          "type": "timeseries"
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
                "pointSize": 1,
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
              },
              "unit": "bytes",
              "unitScale": true
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 17
          },
          "id": 23,
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
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryManager_ClusterTotalMemoryReservation{job=~\"$job\",namespace=~\"$namespace\"}",
              "instant": false,
              "legendFormat": "今日",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryManager_ClusterTotalMemoryReservation{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
              "hide": false,
              "instant": false,
              "legendFormat": "昨日",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_memory_ClusterMemoryManager_ClusterTotalMemoryReservation{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
              "hide": false,
              "instant": false,
              "legendFormat": "7日前",
              "range": true,
              "refId": "C"
            }
          ],
          "title": "Cluster Total Memory Reservation (Running查询使用总和)",
          "type": "timeseries"
        },
        {
          "collapsed": false,
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 25
          },
          "id": 2,
          "panels": [],
          "title": "查询执行概况",
          "type": "row"
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
                "pointSize": 1,
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
              },
              "unitScale": true
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 26
          },
          "id": 1,
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
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_execution_QueryManager_RunningQueries{job=~\"$job\",namespace=~\"$namespace\"}",
              "instant": false,
              "legendFormat": "今日",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_execution_QueryManager_RunningQueries{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
              "hide": false,
              "instant": false,
              "legendFormat": "昨日",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_execution_QueryManager_RunningQueries{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
              "hide": false,
              "instant": false,
              "legendFormat": "七日前",
              "range": true,
              "refId": "C"
            }
          ],
          "title": "Running查询数",
          "type": "timeseries"
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
                "pointSize": 1,
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
              },
              "unitScale": true
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 26
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
              "mode": "single",
              "sort": "none"
            }
          },
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_execution_QueryManager_QueuedQueries{job=~\"$job\",namespace=~\"$namespace\"}",
              "instant": false,
              "legendFormat": "今日",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_execution_QueryManager_QueuedQueries{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
              "hide": false,
              "instant": false,
              "legendFormat": "昨日",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "trino_execution_QueryManager_QueuedQueries{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
              "hide": false,
              "instant": false,
              "legendFormat": "七日前",
              "range": true,
              "refId": "C"
            }
          ],
          "title": "Queued查询数",
          "type": "timeseries"
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
                "pointSize": 1,
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
              },
              "unitScale": true
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 8,
            "x": 0,
            "y": 34
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
              "mode": "single",
              "sort": "none"
            }
          },
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "increase(trino_execution_QueryManager_SubmittedQueries_TotalCount{job=~\"$job\",namespace=~\"$namespace\"}[1m])",
              "instant": false,
              "legendFormat": "今日",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "increase(trino_execution_QueryManager_SubmittedQueries_TotalCount{job=~\"$job\",namespace=~\"$namespace\"}[1m] offset 1d)  ",
              "hide": false,
              "instant": false,
              "legendFormat": "昨日",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "increase(trino_execution_QueryManager_SubmittedQueries_TotalCount{job=~\"$job\",namespace=~\"$namespace\"}[1m] offset 7d) ",
              "hide": false,
              "instant": false,
              "legendFormat": "七日前",
              "range": true,
              "refId": "C"
            }
          ],
          "title": "每分钟查询提交数",
          "type": "timeseries"
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
                "pointSize": 1,
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
              },
              "unitScale": true
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 8,
            "x": 8,
            "y": 34
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
              "mode": "single",
              "sort": "none"
            }
          },
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "increase(trino_execution_QueryManager_CompletedQueries_TotalCount{job=~\"$job\",namespace=~\"$namespace\"}[1m])",
              "instant": false,
              "legendFormat": "今日",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "increase(trino_execution_QueryManager_CompletedQueries_TotalCount{job=~\"$job\",namespace=~\"$namespace\"}[1m] offset 1d)",
              "hide": false,
              "instant": false,
              "legendFormat": "昨日",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "increase(trino_execution_QueryManager_CompletedQueries_TotalCount{job=~\"$job\",namespace=~\"$namespace\"}[1m] offset 7d)",
              "hide": false,
              "instant": false,
              "legendFormat": "七日前",
              "range": true,
              "refId": "C"
            }
          ],
          "title": "每分钟查询完成数",
          "type": "timeseries"
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
                "pointSize": 1,
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
              },
              "unitScale": true
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 8,
            "x": 16,
            "y": 34
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
              "mode": "single",
              "sort": "none"
            }
          },
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "increase(trino_execution_QueryManager_FailedQueries_TotalCount{job=~\"$job\",namespace=~\"$namespace\"}[1m])",
              "instant": false,
              "legendFormat": "今日",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "increase(trino_execution_QueryManager_FailedQueries_TotalCount{job=~\"$job\",namespace=~\"$namespace\"}[1m] offset 1d)",
              "hide": false,
              "instant": false,
              "legendFormat": "昨日",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "increase(trino_execution_QueryManager_FailedQueries_TotalCount{job=~\"$job\",namespace=~\"$namespace\"}[1m] offset 7d)",
              "hide": false,
              "instant": false,
              "legendFormat": "七日前",
              "range": true,
              "refId": "C"
            }
          ],
          "title": "每分钟查询失败数",
          "type": "timeseries"
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
                "pointSize": 1,
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
              },
              "unitScale": true
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 42
          },
          "id": 18,
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
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "increase(trino_memory_ClusterMemoryManager_NumberOfLeakedQueries{job=~\"$job\",namespace=~\"$namespace\"}[1m])",
              "instant": false,
              "legendFormat": "今日",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "increase(trino_memory_ClusterMemoryManager_NumberOfLeakedQueries{job=~\"$job\",namespace=~\"$namespace\"}[1m] offset 1d)",
              "hide": false,
              "instant": false,
              "legendFormat": "昨日",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "increase(trino_memory_ClusterMemoryManager_NumberOfLeakedQueries{job=~\"$job\",namespace=~\"$namespace\"}[1m] offset 7d)",
              "hide": false,
              "instant": false,
              "legendFormat": "七天前",
              "range": true,
              "refId": "C"
            }
          ],
          "title": "每分钟内存泄漏的查询总数",
          "type": "timeseries"
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
                "pointSize": 1,
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
              },
              "unitScale": true
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 42
          },
          "id": 17,
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
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "increase(trino_memory_ClusterMemoryManager_QueriesKilledDueToOutOfMemory{job=~\"$job\",namespace=~\"$namespace\"}[1m])",
              "instant": false,
              "legendFormat": "今日",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "increase(trino_memory_ClusterMemoryManager_QueriesKilledDueToOutOfMemory{job=~\"$job\",namespace=~\"$namespace\"}[1m] offset 1d)",
              "hide": false,
              "instant": false,
              "legendFormat": "昨日",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "increase(trino_memory_ClusterMemoryManager_QueriesKilledDueToOutOfMemory{job=~\"$job\",namespace=~\"$namespace\"}[1m] offset 7d)",
              "hide": false,
              "instant": false,
              "legendFormat": "七日前",
              "range": true,
              "refId": "C"
            }
          ],
          "title": "每分钟oom killed的查询总数",
          "type": "timeseries"
        },
        {
          "collapsed": true,
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 50
          },
          "id": 30,
          "panels": [
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
                    "pointSize": 1,
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
                  },
                  "unit": "ms",
                  "unitScale": true
                },
                "overrides": []
              },
              "gridPos": {
                "h": 7,
                "w": 6,
                "x": 0,
                "y": 51
              },
              "id": 32,
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
              "targets": [
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_CpuTime_OneMinute_Avg{job=~\"$job\",namespace=~\"$namespace\"}",
                  "instant": false,
                  "legendFormat": "今日",
                  "range": true,
                  "refId": "A"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_CpuTime_OneMinute_Avg{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "昨日",
                  "range": true,
                  "refId": "B"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_CpuTime_OneMinute_Avg{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "7日前",
                  "range": true,
                  "refId": "C"
                }
              ],
              "title": "最近一分钟Task(Finished)Cpu耗时平均值",
              "type": "timeseries"
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
                    "pointSize": 1,
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
                  },
                  "unit": "ms",
                  "unitScale": true
                },
                "overrides": []
              },
              "gridPos": {
                "h": 7,
                "w": 6,
                "x": 6,
                "y": 51
              },
              "id": 38,
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
              "targets": [
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_CpuTime_OneMinute_Max{job=~\"$job\",namespace=~\"$namespace\"}",
                  "instant": false,
                  "legendFormat": "今日",
                  "range": true,
                  "refId": "A"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_CpuTime_OneMinute_Max{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "昨日",
                  "range": true,
                  "refId": "B"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_CpuTime_OneMinute_Max{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "7日前",
                  "range": true,
                  "refId": "C"
                }
              ],
              "title": "最近一分钟Task(Finished)Cpu耗时最大值",
              "type": "timeseries"
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
                    "pointSize": 1,
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
                  },
                  "unit": "ms",
                  "unitScale": true
                },
                "overrides": []
              },
              "gridPos": {
                "h": 7,
                "w": 6,
                "x": 12,
                "y": 51
              },
              "id": 33,
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
              "targets": [
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_ElapsedTime_OneMinute_Avg{job=~\"$job\",namespace=~\"$namespace\"}",
                  "instant": false,
                  "legendFormat": "今日",
                  "range": true,
                  "refId": "A"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_ElapsedTime_OneMinute_Avg{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "昨日",
                  "range": true,
                  "refId": "B"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_ElapsedTime_OneMinute_Avg{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "7日前",
                  "range": true,
                  "refId": "C"
                }
              ],
              "title": "最近一分钟Task(Finished)执行耗时平均值",
              "type": "timeseries"
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
                    "pointSize": 1,
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
                  },
                  "unit": "ms",
                  "unitScale": true
                },
                "overrides": []
              },
              "gridPos": {
                "h": 7,
                "w": 6,
                "x": 18,
                "y": 51
              },
              "id": 39,
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
              "targets": [
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_ElapsedTime_OneMinute_Max{job=~\"$job\",namespace=~\"$namespace\"}",
                  "instant": false,
                  "legendFormat": "今日",
                  "range": true,
                  "refId": "A"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_ElapsedTime_OneMinute_Max{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "昨日",
                  "range": true,
                  "refId": "B"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_ElapsedTime_OneMinute_Max{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "7日前",
                  "range": true,
                  "refId": "C"
                }
              ],
              "title": "最近一分钟Task(Finished)执行耗时最大值",
              "type": "timeseries"
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
                    "pointSize": 1,
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
                  },
                  "unit": "ms",
                  "unitScale": true
                },
                "overrides": []
              },
              "gridPos": {
                "h": 7,
                "w": 6,
                "x": 0,
                "y": 58
              },
              "id": 34,
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
              "targets": [
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_InputBlockedTime_OneMinute_Avg{job=~\"$job\",namespace=~\"$namespace\"}",
                  "instant": false,
                  "legendFormat": "今日",
                  "range": true,
                  "refId": "A"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_InputBlockedTime_OneMinute_Avg{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "昨日",
                  "range": true,
                  "refId": "B"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_InputBlockedTime_OneMinute_Avg{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "7日前",
                  "range": true,
                  "refId": "C"
                }
              ],
              "title": "最近一分钟Task(Finished)InputBlockedTime平均值",
              "type": "timeseries"
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
                    "pointSize": 1,
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
                  },
                  "unit": "ms",
                  "unitScale": true
                },
                "overrides": []
              },
              "gridPos": {
                "h": 7,
                "w": 6,
                "x": 6,
                "y": 58
              },
              "id": 40,
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
              "targets": [
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_InputBlockedTime_OneMinute_Max{job=~\"$job\",namespace=~\"$namespace\"}",
                  "instant": false,
                  "legendFormat": "今日",
                  "range": true,
                  "refId": "A"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_InputBlockedTime_OneMinute_Max{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "昨日",
                  "range": true,
                  "refId": "B"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_InputBlockedTime_OneMinute_Max{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "7日前",
                  "range": true,
                  "refId": "C"
                }
              ],
              "title": "最近一分钟Task(Finished)InputBlockedTime最大值",
              "type": "timeseries"
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
                    "pointSize": 1,
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
                  },
                  "unit": "ms",
                  "unitScale": true
                },
                "overrides": []
              },
              "gridPos": {
                "h": 7,
                "w": 6,
                "x": 12,
                "y": 58
              },
              "id": 36,
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
              "targets": [
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_OutputBlockedTime_OneMinute_Avg{job=~\"$job\",namespace=~\"$namespace\"}",
                  "instant": false,
                  "legendFormat": "今日",
                  "range": true,
                  "refId": "A"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_OutputBlockedTime_OneMinute_Avg{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "昨日",
                  "range": true,
                  "refId": "B"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_OutputBlockedTime_OneMinute_Avg{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "7日前",
                  "range": true,
                  "refId": "C"
                }
              ],
              "title": "最近一分钟Task(Finished)OutputBlockedTime平均值",
              "type": "timeseries"
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
                    "pointSize": 1,
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
                  },
                  "unit": "ms",
                  "unitScale": true
                },
                "overrides": []
              },
              "gridPos": {
                "h": 7,
                "w": 6,
                "x": 18,
                "y": 58
              },
              "id": 41,
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
              "targets": [
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_OutputBlockedTime_OneMinute_Max{job=~\"$job\",namespace=~\"$namespace\"}",
                  "instant": false,
                  "legendFormat": "今日",
                  "range": true,
                  "refId": "A"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_OutputBlockedTime_OneMinute_Max{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "昨日",
                  "range": true,
                  "refId": "B"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_OutputBlockedTime_OneMinute_Max{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "7日前",
                  "range": true,
                  "refId": "C"
                }
              ],
              "title": "最近一分钟Task(Finished)OutputBlockedTime最大值",
              "type": "timeseries"
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
                    "pointSize": 1,
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
                  },
                  "unit": "bytes",
                  "unitScale": true
                },
                "overrides": []
              },
              "gridPos": {
                "h": 7,
                "w": 6,
                "x": 0,
                "y": 65
              },
              "id": 37,
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
              "targets": [
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_PeakMemoryReservationInBytes_OneMinute_Avg{job=~\"$job\",namespace=~\"$namespace\"}",
                  "instant": false,
                  "legendFormat": "今日",
                  "range": true,
                  "refId": "A"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_PeakMemoryReservationInBytes_OneMinute_Avg{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "昨日",
                  "range": true,
                  "refId": "B"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_PeakMemoryReservationInBytes_OneMinute_Avg{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "7日前",
                  "range": true,
                  "refId": "C"
                }
              ],
              "title": "最近一分钟Task(Finished)PeakMemoryReservation平均值",
              "type": "timeseries"
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
                    "pointSize": 1,
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
                  },
                  "unit": "bytes",
                  "unitScale": true
                },
                "overrides": []
              },
              "gridPos": {
                "h": 7,
                "w": 6,
                "x": 6,
                "y": 65
              },
              "id": 42,
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
              "targets": [
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_PeakMemoryReservationInBytes_OneMinute_Max{job=~\"$job\",namespace=~\"$namespace\"}",
                  "instant": false,
                  "legendFormat": "今日",
                  "range": true,
                  "refId": "A"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_PeakMemoryReservationInBytes_OneMinute_Max{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "昨日",
                  "range": true,
                  "refId": "B"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskExecutionStats_FinishedTasks_PeakMemoryReservationInBytes_OneMinute_Max{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "7日前",
                  "range": true,
                  "refId": "C"
                }
              ],
              "title": "最近一分钟Task(Finished)PeakMemoryReservation最大值",
              "type": "timeseries"
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
                    "pointSize": 1,
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
                  },
                  "unit": "bytes",
                  "unitScale": true
                },
                "overrides": []
              },
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 12,
                "y": 65
              },
              "id": 29,
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
              "targets": [
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskDescriptorStorage_ReservedBytes{job=~\"$job\",namespace=~\"$namespace\"}",
                  "instant": false,
                  "legendFormat": "今日",
                  "range": true,
                  "refId": "A"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskDescriptorStorage_ReservedBytes{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "昨日",
                  "range": true,
                  "refId": "B"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_scheduler_TaskDescriptorStorage_ReservedBytes{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "7日前",
                  "range": true,
                  "refId": "C"
                }
              ],
              "title": "Task Descriptor Storage  Reserved Bytes",
              "type": "timeseries"
            }
          ],
          "title": "任务执行调度概况",
          "type": "row"
        },
        {
          "collapsed": true,
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 51
          },
          "id": 8,
          "panels": [
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
                    "lineInterpolation": "linear",
                    "lineWidth": 1,
                    "pointSize": 1,
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
                        "color": "green"
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
                "h": 8,
                "w": 12,
                "x": 0,
                "y": 4
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
                  "mode": "single",
                  "sort": "none"
                }
              },
              "targets": [
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "increase(trino_execution_QueryManager_ConsumedInputBytes_TotalCount{job=~\"$job\",namespace=~\"$namespace\"}[1m])",
                  "instant": false,
                  "legendFormat": "今日",
                  "range": true,
                  "refId": "A"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "increase(trino_execution_QueryManager_ConsumedInputBytes_TotalCount{job=~\"$job\",namespace=~\"$namespace\"}[1m] offset 1d)",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "昨日",
                  "range": true,
                  "refId": "B"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "increase(trino_execution_QueryManager_ConsumedInputBytes_TotalCount{job=~\"$job\",namespace=~\"$namespace\"}[1m] offset 7d)",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "七日前",
                  "range": true,
                  "refId": "C"
                }
              ],
              "title": "近一分钟完成Query处理字节数累计值",
              "type": "timeseries"
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
                    "lineInterpolation": "linear",
                    "lineWidth": 1,
                    "pointSize": 1,
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
                        "color": "green"
                      },
                      {
                        "color": "red",
                        "value": 80
                      }
                    ]
                  },
                  "unit": "s"
                },
                "overrides": []
              },
              "gridPos": {
                "h": 8,
                "w": 12,
                "x": 12,
                "y": 4
              },
              "id": 11,
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
              "targets": [
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "increase(trino_execution_QueryManager_ConsumedCpuTimeSecs_TotalCount{job=~\"$job\",namespace=~\"$namespace\"}[1m])",
                  "instant": false,
                  "legendFormat": "今日",
                  "range": true,
                  "refId": "A"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "increase(trino_execution_QueryManager_ConsumedCpuTimeSecs_TotalCount{job=~\"$job\",namespace=~\"$namespace\"}[1m] offset 1d)",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "昨日",
                  "range": true,
                  "refId": "B"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "increase(trino_execution_QueryManager_ConsumedCpuTimeSecs_TotalCount{job=~\"$job\",namespace=~\"$namespace\"}[1m] offset 7d)",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "七日前",
                  "range": true,
                  "refId": "C"
                }
              ],
              "title": "近一分钟完成QueryCPU耗时累计值",
              "type": "timeseries"
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
                    "lineInterpolation": "linear",
                    "lineWidth": 1,
                    "pointSize": 1,
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
                        "color": "green"
                      },
                      {
                        "color": "red",
                        "value": 80
                      }
                    ]
                  },
                  "unit": "binBps"
                },
                "overrides": []
              },
              "gridPos": {
                "h": 8,
                "w": 12,
                "x": 0,
                "y": 12
              },
              "id": 12,
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
              "targets": [
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_QueryManager_WallInputBytesRate_OneMinute_Avg{job=~\"$job\",namespace=~\"$namespace\"}",
                  "instant": false,
                  "legendFormat": "今日",
                  "range": true,
                  "refId": "A"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_QueryManager_WallInputBytesRate_OneMinute_Avg{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "昨日",
                  "range": true,
                  "refId": "B"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_QueryManager_WallInputBytesRate_OneMinute_Avg{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "七日前",
                  "range": true,
                  "refId": "C"
                }
              ],
              "title": "近一分钟完成Query数据处理平均速率",
              "type": "timeseries"
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
                    "lineInterpolation": "linear",
                    "lineWidth": 1,
                    "pointSize": 1,
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
                        "color": "green"
                      },
                      {
                        "color": "red",
                        "value": 80
                      }
                    ]
                  },
                  "unit": "binBps"
                },
                "overrides": []
              },
              "gridPos": {
                "h": 8,
                "w": 12,
                "x": 12,
                "y": 12
              },
              "id": 14,
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
              "targets": [
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_QueryManager_WallInputBytesRate_OneMinute_Max{job=~\"$job\",namespace=~\"$namespace\"}",
                  "instant": false,
                  "legendFormat": "今日",
                  "range": true,
                  "refId": "A"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_QueryManager_WallInputBytesRate_OneMinute_Max{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "昨日",
                  "range": true,
                  "refId": "B"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_QueryManager_WallInputBytesRate_OneMinute_Max{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "七日前",
                  "range": true,
                  "refId": "C"
                }
              ],
              "title": "近一分钟完成Query数据处理最大速率",
              "type": "timeseries"
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
                    "lineInterpolation": "linear",
                    "lineWidth": 1,
                    "pointSize": 1,
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
                "y": 20
              },
              "id": 13,
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
              "targets": [
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_QueryManager_ExecutionTime_OneMinute_Avg{job=~\"$job\",namespace=~\"$namespace\"}",
                  "instant": false,
                  "legendFormat": "今日",
                  "range": true,
                  "refId": "A"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_QueryManager_ExecutionTime_OneMinute_Avg{job=~\"$job\",namespace=~\"$namespace\"} offset 1d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "昨日",
                  "range": true,
                  "refId": "B"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_QueryManager_ExecutionTime_OneMinute_Avg{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "七日前",
                  "range": true,
                  "refId": "C"
                }
              ],
              "title": "近一分钟完成Query平均执行时间",
              "type": "timeseries"
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
                    "lineInterpolation": "linear",
                    "lineWidth": 1,
                    "pointSize": 1,
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
                "y": 20
              },
              "id": 15,
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
              "targets": [
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_QueryManager_ExecutionTime_OneMinute_Max{job=~\"$job\",namespace=~\"$namespace\"}",
                  "instant": false,
                  "legendFormat": "今日",
                  "range": true,
                  "refId": "A"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_QueryManager_ExecutionTime_OneMinute_Max{job=~\"$job\",namespace=~\"$namespace\"}  offset 1d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "昨日",
                  "range": true,
                  "refId": "B"
                },
                {
                  "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus"
                  },
                  "editorMode": "code",
                  "expr": "trino_execution_QueryManager_ExecutionTime_OneMinute_Max{job=~\"$job\",namespace=~\"$namespace\"} offset 7d",
                  "hide": false,
                  "instant": false,
                  "legendFormat": "七日前",
                  "range": true,
                  "refId": "C"
                }
              ],
              "title": "近一分钟完成Query最大执行时间",
              "type": "timeseries"
            }
          ],
          "title": "最近完成Query数据处理概况",
          "type": "row"
        }
      ],
      "refresh": "",
      "schemaVersion": 39,
      "tags": [],
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
            "query": "label_values(trino_execution_querymanager_queuedtime_alltime_avg{job=~\"$job\"}, job)",
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
            "query": "label_values({pod=~\".*presto.*\",job!=\"kubelet\",job!=\"kube-state-metrics\"},namespace)",
            "refresh": 2,
            "regex": "",
            "skipUrlSync": false,
            "sort": 1,
            "tagValuesQuery": "",
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          }
        ]
      },
      "time": {
        "from": "now-6h",
        "to": "now"
      },
      "timepicker": {},
      "timezone": "browser",
      "title": "Trino Cluster JMX",
      "uid": "trino001",
      "version": 1,
      "weekStart": ""
    }
    </#noparse>