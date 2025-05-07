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
                "type": "prometheus",
                "uid": "prometheus"
            },
            "enable": true,
            "hide": true,
            "iconColor": "rgba(0, 211, 255, 1)",
            "name": "Annotations & Alerts",
            "target": {
              "limit": 100,
              "matchAny": false,
              "tags": [],
              "type": "dashboard"
            },
            "type": "dashboard"
          }
        ]
      },
      "editable": true,
      "fiscalYearStartMonth": 0,
      "graphTooltip": 0,
      "id": 33,
      "links": [],
      "liveNow": false,
      "panels": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "mappings": [
                {
                  "options": {
                    "0": {
                      "text": "下线"
                    },
                    "1": {
                      "text": "正常"
                    }
                  },
                  "type": "value"
                },
                {
                  "options": {
                    "match": "null",
                    "result": {
                      "text": "下线"
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
                    "color": "#e24d42",
                    "value": 0
                  },
                  {
                    "color": "#299c46",
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
            "y": 0
          },
          "hideTimeOverride": false,
          "id": 8,
          "links": [
            {
              "targetBlank": true,
              "title": "Tomcat dashboard",
              "url": "/d/chanjarster-tomcat-dashboard/tomcat-dashboard?$__url_time_range&$__all_variables"
            }
          ],
          "maxDataPoints": 100,
          "options": {
            "colorMode": "value",
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "lastNotNull"
              ],
              "fields": "",
              "values": false
            },
            "text": {
              "valueSize": 38
            },
            "textMode": "auto"
          },
          "pluginVersion": "9.1.6",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "up{namespace=\"$namespace\", instance=~\"$instance\", service=~\"metrics-dinky.*\"}",
              "format": "time_series",
              "instant": true,
              "interval": "",
              "intervalFactor": 1,
              "legendFormat": "",
              "refId": "A"
            }
          ],
          "title": "Dinky状态",
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
                "mode": "thresholds"
              },
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
                    "color": "green",
                    "value": null
                  }
                ]
              },
              "unit": "dateTimeAsIso"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 8,
            "x": 4,
            "y": 0
          },
          "id": 2,
          "links": [],
          "maxDataPoints": 100,
          "options": {
            "colorMode": "value",
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "lastNotNull"
              ],
              "fields": "",
              "values": false
            },
            "text": {
              "valueSize": 38
            },
            "textMode": "auto"
          },
          "pluginVersion": "9.1.6",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "process_start_time_seconds{namespace=\"$namespace\", instance=~\"$instance\", service=~\"metrics-dinky.*\"}*1000",
              "legendFormat": "__auto",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "Dinky启动时间",
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
                "mode": "thresholds"
              },
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
                    "color": "green",
                    "value": null
                  }
                ]
              },
              "unit": "s"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 4,
            "x": 12,
            "y": 0
          },
          "id": 4,
          "links": [],
          "maxDataPoints": 100,
          "options": {
            "colorMode": "value",
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "lastNotNull"
              ],
              "fields": "",
              "values": false
            },
            "text": {
              "valueSize": 38
            },
            "textMode": "auto"
          },
          "pluginVersion": "9.1.6",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "time() - process_start_time_seconds{namespace=\"$namespace\", instance=~\"$instance\", service=~\"metrics-dinky.*\"}",
              "interval": "",
              "legendFormat": "",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "Dinky运行时长",
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
                "mode": "thresholds"
              },
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
                    "color": "green",
                    "value": null
                  }
                ]
              },
              "unit": "bytes"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 4,
            "x": 16,
            "y": 0
          },
          "id": 6,
          "links": [],
          "maxDataPoints": 100,
          "options": {
            "colorMode": "value",
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "horizontal",
            "reduceOptions": {
              "calcs": [
                "lastNotNull"
              ],
              "fields": "",
              "values": false
            },
            "text": {
              "valueSize": 38
            },
            "textMode": "auto"
          },
          "pluginVersion": "9.1.6",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "jvm_memory_bytes_max{namespace=\"$namespace\", instance=~\"$instance\", service=~\"metrics-dinky.*\",area=\"heap\"}",
              "legendFormat": "__auto",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "Dinky堆内存",
          "type": "stat"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "prometheus"
          },
          "fieldConfig": {
            "defaults": {
              "mappings": [],
              "max": 100,
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
              "unit": "%"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 4,
            "w": 4,
            "x": 20,
            "y": 0
          },
          "id": 10,
          "options": {
            "orientation": "auto",
            "reduceOptions": {
              "calcs": [
                "lastNotNull"
              ],
              "fields": "",
              "values": false
            },
            "showThresholdLabels": false,
            "showThresholdMarkers": true
          },
          "pluginVersion": "9.1.6",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "jvm_memory_bytes_used{namespace=\"$namespace\", instance=~\"$instance\", service=~\"metrics-dinky.*\",area=\"heap\"}*100/jvm_memory_bytes_max{namespace=\"$namespace\", instance=~\"$instance\", service=~\"metrics-dinky.*\",area=\"heap\"}",
              "legendFormat": "__auto",
              "range": true,
              "refId": "A"
            }
          ],
          "title": "Dinky堆内存使用率",
          "type": "gauge"
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
                  "options": "Usage %"
                },
                "properties": [
                  {
                    "id": "custom.drawStyle",
                    "value": "bars"
                  },
                  {
                    "id": "custom.fillOpacity",
                    "value": 100
                  },
                  {
                    "id": "color",
                    "value": {
                      "fixedColor": "#6d1f62",
                      "mode": "fixed"
                    }
                  },
                  {
                    "id": "custom.lineWidth",
                    "value": 0
                  },
                  {
                    "id": "unit",
                    "value": "percentunit"
                  },
                  {
                    "id": "min",
                    "value": 0
                  },
                  {
                    "id": "max",
                    "value": 1
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 10,
            "w": 12,
            "x": 0,
            "y": 4
          },
          "id": 12,
          "links": [],
          "options": {
            "legend": {
              "calcs": [
                "mean",
                "max"
              ],
              "displayMode": "table",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "none"
            }
          },
          "pluginVersion": "9.1.6",
          "repeat": "memarea",
          "repeatDirection": "h",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "jvm_memory_bytes_used{namespace=\"$namespace\", instance=~\"$instance\", service=~\"metrics-dinky.*\",area=\"heap\"}",
              "legendFormat": "已用内存",
              "range": true,
              "refId": "A"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "jvm_memory_bytes_max{namespace=\"$namespace\", instance=~\"$instance\", service=~\"metrics-dinky.*\",area=\"heap\"}",
              "hide": false,
              "legendFormat": "总内存",
              "range": true,
              "refId": "B"
            },
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "jvm_memory_bytes_used{namespace=\"$namespace\", instance=~\"$instance\", service=~\"metrics-dinky.*\",area=\"heap\"} / jvm_memory_bytes_max{namespace=\"$namespace\", instance=~\"$instance\", service=~\"metrics-dinky.*\",area=\"heap\"} >= 0",
              "hide": false,
              "legendFormat": "使用率",
              "range": true,
              "refId": "C"
            }
          ],
          "title": "Dinky堆内存使用趋势",
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
                    "color": "green",
                    "value": null
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
            "h": 10,
            "w": 12,
            "x": 12,
            "y": 4
          },
          "id": 14,
          "links": [],
          "options": {
            "legend": {
              "calcs": [
                "lastNotNull",
                "max",
                "min"
              ],
              "displayMode": "table",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "none"
            }
          },
          "pluginVersion": "9.1.6",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "prometheus"
              },
              "editorMode": "code",
              "expr": "increase(jvm_gc_collection_seconds_sum{namespace=\"$namespace\", instance=~\"$instance\", service=~\"metrics-dinky.*\"}[$__interval])",
              "format": "time_series",
              "interval": "60s",
              "intervalFactor": 1,
              "legendFormat": "{{gc}}",
              "metric": "jvm_gc_collection_seconds_sum",
              "range": true,
              "refId": "A",
              "step": 10
            }
          ],
          "title": "Dinky GC时间趋势图",
          "type": "timeseries"
        }
      ],
      "schemaVersion": 37,
      "style": "dark",
      "tags": [],
      "templating": {
        "list": [
          {
            "current": {},
            "datasource": {
              "type": "prometheus",
              "uid": "prometheus"
            },
            "definition": "",
            "hide": 0,
            "includeAll": false,
            "multi": false,
            "name": "namespace",
            "options": [],
            "query": "label_values(jvm_memory_bytes_used{service=~\"metrics-dinky.*\"}, namespace)",
            "refresh": 2,
            "regex": "",
            "skipUrlSync": false,
            "sort": 0,
            "type": "query"
          },
          {
            "current": {},
            "datasource": {
              "type": "prometheus",
              "uid": "prometheus"
            },
            "definition": "",
            "hide": 0,
            "includeAll": true,
            "multi": false,
            "name": "instance",
            "options": [],
            "query": "label_values(jvm_memory_bytes_used{namespace=\"$namespace\",service=~\"metrics-dinky.*\"}, instance)",
            "refresh": 2,
            "regex": "",
            "skipUrlSync": false,
            "sort": 1,
            "type": "query"
          },
          {
            "auto": false,
            "auto_count": 30,
            "auto_min": "10s",
            "current": {
              "selected": false,
              "text": "1m",
              "value": "1m"
            },
            "hide": 0,
            "name": "interval",
            "options": [
              {
                "selected": true,
                "text": "1m",
                "value": "1m"
              },
              {
                "selected": false,
                "text": "2m",
                "value": "2m"
              },
              {
                "selected": false,
                "text": "5m",
                "value": "5m"
              },
              {
                "selected": false,
                "text": "10m",
                "value": "10m"
              }
            ],
            "query": "1m,2m,5m,10m",
            "refresh": 2,
            "skipUrlSync": false,
            "type": "interval"
          }
        ]
      },
      "time": {
        "from": "now-6h",
        "to": "now"
      },
      "timepicker": {
        "refresh_intervals": [
          "5s",
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
        "nowDelay": "",
        "refresh_intervals_all": true,
        "time_options": ["5m","15m","1h","6h","12h","24h","2d","7d","30d"],
        "status": "Streaming (5 seconds)"
      },
      "refresh": "5s",
      "timezone": "",
      "title": "Dinky",
      "uid": "dinky001",
      "version": 4,
      "weekStart": ""
    }
    </#noparse >