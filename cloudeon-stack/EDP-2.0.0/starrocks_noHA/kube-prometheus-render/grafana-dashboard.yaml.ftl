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
    <#noparse>
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
      "editable": true,
      "fiscalYearStartMonth": 0,
      "gnetId": 9734,
      "graphTooltip": 0,
      "id": 1,
      "links": [],
      "liveNow": false,
      "panels": [
      {
      "collapsed": false,
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "gridPos": {
      "h": 1,
      "w": 24,
      "x": 0,
      "y": 0
      },
      "id": 45,
      "panels": [],
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "refId": "A"
      }
      ],
      "title": "Overview",
      "type": "row"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "监控的StarRocks集群数。",
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
      },
      {
      "color": "red",
      "value": 80
      }
      ]
      },
      "unit": "none"
      },
      "overrides": []
      },
      "gridPos": {
      "h": 7,
      "w": 4,
      "x": 0,
      "y": 1
      },
      "id": 1,
      "links": [],
      "maxDataPoints": 100,
      "options": {
      "colorMode": "none",
      "graphMode": "none",
      "justifyMode": "auto",
      "orientation": "horizontal",
      "reduceOptions": {
      "calcs": [
      "mean"
      ],
      "fields": "",
      "values": false
      },
      "text": {},
      "textMode": "auto"
      },
      "pluginVersion": "10.0.3",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "count(node_info{type=\"is_master\"})",
      "format": "time_series",
      "instant": true,
      "intervalFactor": 1,
      "refId": "A"
      }
      ],
      "title": "Cluster Number",
      "type": "stat"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "FE节点状态，挂掉的FE会显示为其他颜色的点。如果所有FE都是存活状态，则所有点都应为亮绿色。",
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
      "drawStyle": "points",
      "fillOpacity": 10,
      "gradientMode": "none",
      "hideFrom": {
      "legend": false,
      "tooltip": false,
      "viz": false
      },
      "lineInterpolation": "linear",
      "lineWidth": 1,
      "pointSize": 12,
      "scaleDistribution": {
      "type": "linear"
      },
      "showPoints": "always",
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
      "max": 1,
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
      "id": "byRegexp",
      "options": "/.*ALIVE/"
      },
      "properties": [
      {
      "id": "color",
      "value": {
      "fixedColor": "rgb(0, 255, 0)",
      "mode": "fixed"
      }
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 7,
      "w": 10,
      "x": 4,
      "y": 1
      },
      "id": 70,
      "links": [],
      "options": {
      "legend": {
      "calcs": [],
      "displayMode": "table",
      "placement": "right",
      "showLegend": true,
      "width": 300
      },
      "tooltip": {
      "mode": "multi",
      "sort": "asc"
      }
      },
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "(up{job=~\"metrics-starrocks-fe.*\"} == 0) +0",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{job}}-{{instance}}: DEAD",
      "refId": "B"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "(up{job=~\"metrics-starrocks-fe.*\"} == 1) +0",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{job}}-{{instance}}: ALIVE",
      "refId": "A"
      }
      ],
      "title": "Frontends Status",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "BE节点状态，挂掉的BE会展示为其他颜色的点。如果所有的BE状态正常，所有的点都会是亮绿色。",
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
      "drawStyle": "points",
      "fillOpacity": 10,
      "gradientMode": "none",
      "hideFrom": {
      "legend": false,
      "tooltip": false,
      "viz": false
      },
      "lineInterpolation": "linear",
      "lineWidth": 1,
      "pointSize": 12,
      "scaleDistribution": {
      "type": "linear"
      },
      "showPoints": "always",
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
      "max": 1,
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
      "id": "byRegexp",
      "options": "/.*ALIVE/"
      },
      "properties": [
      {
      "id": "color",
      "value": {
      "fixedColor": "rgb(0, 255, 0)",
      "mode": "fixed"
      }
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 7,
      "w": 10,
      "x": 14,
      "y": 1
      },
      "id": 69,
      "links": [],
      "options": {
      "legend": {
      "calcs": [],
      "displayMode": "list",
      "placement": "right",
      "showLegend": true
      },
      "tooltip": {
      "mode": "multi",
      "sort": "asc"
      }
      },
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "(up{job=~\"metrics-starrocks-be.*\"} == 0) +0",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{job}}-{{instance}}: DEAD",
      "refId": "B"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "(up{job=~\"metrics-starrocks-be.*\"} == 1) +0",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{job}}-{{instance}}: ALIVE",
      "refId": "A"
      }
      ],
      "title": "Backends Status",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "StarRocks集群各个FE的JVM堆内存使用百分比。",
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
      "unit": "percent"
      },
      "overrides": []
      },
      "gridPos": {
      "h": 7,
      "w": 8,
      "x": 0,
      "y": 8
      },
      "id": 5,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull"
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "sum(jvm_heap_size_bytes{job=~\"metrics-starrocks-fe.*\", type=\"used\"} * 100) by (instance, job) / sum(jvm_heap_size_bytes{job=~\"metrics-starrocks-fe.*\", type=\"max\"}) by (instance, job)",
      "format": "time_series",
      "hide": false,
      "intervalFactor": 2,
      "legendFormat": "{{job}}-{{instance}}",
      "refId": "C"
      }
      ],
      "title": "Cluster FE JVM Heap Stat",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "每个StarRocks集群的BE CPU“空闲”情况。注意：Idle是“空闲”的意思。",
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
      "fillOpacity": 0,
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
      "mappings": [],
      "max": 1,
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
      "unit": "percentunit"
      },
      "overrides": []
      },
      "gridPos": {
      "h": 7,
      "w": 8,
      "x": 8,
      "y": 8
      },
      "id": 8,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "mean",
      "lastNotNull"
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "(sum(rate(starrocks_be_cpu{mode=\"idle\"}[$interval])) by (job)) / (sum(rate(starrocks_be_cpu[$interval])) by (job))",
      "format": "time_series",
      "intervalFactor": 2,
      "legendFormat": "{{job}}",
      "refId": "B"
      }
      ],
      "title": "Cluster BE CPU Idle",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "每个StarRocks集群的BE内存使用情况概览。",
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
      "fillOpacity": 0,
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
      "unit": "bytes"
      },
      "overrides": []
      },
      "gridPos": {
      "h": 7,
      "w": 8,
      "x": 16,
      "y": 8
      },
      "id": 9,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull",
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "avg(starrocks_be_process_mem_bytes) by (job)",
      "format": "time_series",
      "intervalFactor": 2,
      "legendFormat": "{{job}}",
      "refId": "A"
      }
      ],
      "title": "Cluster BE Mem Stat",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "按集群分组的QPS统计信息。每个集群的QPS是在所有FE处理的所有查询请求数的总和。",
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
      "overrides": []
      },
      "gridPos": {
      "h": 7,
      "w": 8,
      "x": 0,
      "y": 15
      },
      "id": 31,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull",
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "sum by (job)(rate(starrocks_fe_query_total{job=~\"metrics-starrocks-fe.*\"}[$interval]))",
      "format": "time_series",
      "intervalFactor": 2,
      "legendFormat": "{{job}}",
      "refId": "A"
      }
      ],
      "title": "Cluster QPS Stat",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "磁盘状态。绿色点表示该磁盘处于联机状态。红点表示该磁盘处于离线状态，处理离线状态的磁盘表示可能磁盘损坏，需要运维修复或者更换磁盘进行处理。",
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
      "drawStyle": "points",
      "fillOpacity": 10,
      "gradientMode": "none",
      "hideFrom": {
      "legend": false,
      "tooltip": false,
      "viz": false
      },
      "lineInterpolation": "linear",
      "lineWidth": 1,
      "pointSize": 12,
      "scaleDistribution": {
      "type": "linear"
      },
      "showPoints": "always",
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
      "max": 1,
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
      "id": "byRegexp",
      "options": "/.*OFFLINE/"
      },
      "properties": [
      {
      "id": "color",
      "value": {
      "fixedColor": "#bf1b00",
      "mode": "fixed"
      }
      },
      {
      "id": "custom.showPoints",
      "value": "always"
      }
      ]
      },
      {
      "matcher": {
      "id": "byRegexp",
      "options": "/.*ONLINE/"
      },
      "properties": [
      {
      "id": "color",
      "value": {
      "fixedColor": "rgb(85, 255, 0)",
      "mode": "fixed"
      }
      },
      {
      "id": "custom.showPoints",
      "value": "always"
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 7,
      "w": 16,
      "x": 8,
      "y": 15
      },
      "id": 119,
      "links": [],
      "options": {
      "legend": {
      "calcs": [],
      "displayMode": "table",
      "placement": "right",
      "showLegend": true
      },
      "tooltip": {
      "mode": "multi",
      "sort": "none"
      }
      },
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "(starrocks_be_disks_state{namespace=~\"$namespace\"} == 0)+0",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}: {{path}} OFFLINE",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "(starrocks_be_disks_state{namespace=~\"$namespace\"} == 1)+0",
      "format": "time_series",
      "hide": false,
      "intervalFactor": 1,
      "legendFormat": "{{instance}}: {{path}} ONLINE",
      "refId": "B"
      }
      ],
      "title": "StarRocks Disk State",
      "type": "timeseries"
      },
      {
      "collapsed": false,
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "gridPos": {
      "h": 1,
      "w": 24,
      "x": 0,
      "y": 22
      },
      "id": 46,
      "panels": [],
      "repeat": "cluster_name",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "refId": "A"
      }
      ],
      "title": "Cluster Overview",
      "type": "row"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "总的FE节点数。",
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
      },
      {
      "color": "red",
      "value": 80
      }
      ]
      },
      "unit": "none"
      },
      "overrides": []
      },
      "gridPos": {
      "h": 6,
      "w": 4,
      "x": 0,
      "y": 23
      },
      "id": 10,
      "links": [],
      "maxDataPoints": 100,
      "options": {
      "colorMode": "none",
      "graphMode": "none",
      "justifyMode": "auto",
      "orientation": "horizontal",
      "reduceOptions": {
      "calcs": [
      "mean"
      ],
      "fields": "",
      "values": false
      },
      "text": {},
      "textMode": "auto"
      },
      "pluginVersion": "10.0.3",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "count(up{job=~\"metrics-starrocks-fe.*\", namespace=~\"$namespace\"})",
      "format": "time_series",
      "instant": true,
      "intervalFactor": 1,
      "refId": "A"
      }
      ],
      "title": "StarRocks FE Node",
      "type": "stat"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "当前正常的FE节点数。若集群状态正常，则该值应等于总的FE节点数。",
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
      },
      {
      "color": "red",
      "value": 80
      }
      ]
      },
      "unit": "none"
      },
      "overrides": []
      },
      "gridPos": {
      "h": 6,
      "w": 4,
      "x": 4,
      "y": 23
      },
      "id": 12,
      "links": [],
      "maxDataPoints": 100,
      "options": {
      "colorMode": "none",
      "graphMode": "none",
      "justifyMode": "auto",
      "orientation": "horizontal",
      "reduceOptions": {
      "calcs": [
      "mean"
      ],
      "fields": "",
      "values": false
      },
      "text": {},
      "textMode": "auto"
      },
      "pluginVersion": "10.0.3",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "count(up{job=~\"metrics-starrocks-fe.*\", namespace=~\"$namespace\"}==1)",
      "format": "time_series",
      "instant": true,
      "intervalFactor": 2,
      "refId": "A"
      }
      ],
      "title": "StarRocks  FE Alive",
      "type": "stat"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "集群中BE的节点总数。",
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
      },
      {
      "color": "red",
      "value": 80
      }
      ]
      },
      "unit": "none"
      },
      "overrides": []
      },
      "gridPos": {
      "h": 6,
      "w": 4,
      "x": 8,
      "y": 23
      },
      "id": 11,
      "links": [],
      "maxDataPoints": 100,
      "options": {
      "colorMode": "none",
      "graphMode": "none",
      "justifyMode": "auto",
      "orientation": "horizontal",
      "reduceOptions": {
      "calcs": [
      "mean"
      ],
      "fields": "",
      "values": false
      },
      "text": {},
      "textMode": "auto"
      },
      "pluginVersion": "10.0.3",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "count(up{job=~\"metrics-starrocks-be.*\", namespace=~\"$namespace\"})",
      "format": "time_series",
      "instant": true,
      "intervalFactor": 1,
      "refId": "A"
      }
      ],
      "title": "StarRocks BE Node",
      "type": "stat"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "当前集群中正常存活的BE节点数，如果这个数量和BE Node的数量不一致说明集群中有掉线的BE节点，需要去查看处理。",
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
      },
      {
      "color": "red",
      "value": 80
      }
      ]
      },
      "unit": "none"
      },
      "overrides": []
      },
      "gridPos": {
      "h": 6,
      "w": 4,
      "x": 12,
      "y": 23
      },
      "id": 14,
      "links": [],
      "maxDataPoints": 100,
      "options": {
      "colorMode": "none",
      "graphMode": "none",
      "justifyMode": "auto",
      "orientation": "horizontal",
      "reduceOptions": {
      "calcs": [
      "mean"
      ],
      "fields": "",
      "values": false
      },
      "text": {},
      "textMode": "auto"
      },
      "pluginVersion": "10.0.3",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "count(up{job=~\"metrics-starrocks-be.*\", namespace=~\"$namespace\"}==1)",
      "format": "time_series",
      "instant": true,
      "intervalFactor": 1,
      "refId": "A"
      }
      ],
      "title": "StarRocks BE Alive",
      "type": "stat"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "当前所有BE合计使用的磁盘空间。",
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
      "h": 6,
      "w": 4,
      "x": 16,
      "y": 23
      },
      "id": 59,
      "links": [],
      "maxDataPoints": 100,
      "options": {
      "colorMode": "none",
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
      "text": {},
      "textMode": "auto"
      },
      "pluginVersion": "10.0.3",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "SUM(starrocks_be_disks_data_used_capacity{namespace=~\"$namespace\"})",
      "format": "time_series",
      "intervalFactor": 1,
      "refId": "B"
      }
      ],
      "title": "StarRocks Used Capacity",
      "type": "stat"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "所有BE存储目录所在磁盘的合计容量。注意：该指标仅表示磁盘容量大小，不表示可用空间。",
      "fieldConfig": {
      "defaults": {
      "color": {
      "fixedColor": "rgb(31, 120, 193)",
      "mode": "fixed"
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
      "h": 6,
      "w": 4,
      "x": 20,
      "y": 23
      },
      "id": 58,
      "links": [],
      "maxDataPoints": 100,
      "options": {
      "colorMode": "none",
      "graphMode": "area",
      "justifyMode": "auto",
      "orientation": "horizontal",
      "reduceOptions": {
      "calcs": [
      "lastNotNull"
      ],
      "fields": "",
      "values": false
      },
      "text": {},
      "textMode": "auto"
      },
      "pluginVersion": "10.0.3",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "SUM(starrocks_be_disks_total_capacity{namespace=~\"$namespace\"})",
      "format": "time_series",
      "instant": true,
      "intervalFactor": 1,
      "refId": "A"
      }
      ],
      "title": "StarRocks Total Capacity",
      "type": "stat"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "StarRocks FE的最大重放元数据日志ID。正常Leader的journal id最大，其他非Leader FE节点的值基本保持一致，且会略小于Leader节点的值。如果有FE节点的journal id值和其他节点差别特别大，说明这个节点元数据版本太旧，访问该节点查询时数据会存在不一致的风险。这种情况下可以将该节点从集群中删除，然后再作为一个新的FE节点加入进来。",
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
      "unit": "none"
      },
      "overrides": []
      },
      "gridPos": {
      "h": 6,
      "w": 6,
      "x": 0,
      "y": 29
      },
      "id": 63,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull"
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_fe_max_journal_id{namespace=~\"$namespace\"}",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}",
      "refId": "A"
      }
      ],
      "title": "StarRocks Max Replayed Journal Id",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "该项为StarRocks Leader FE元数据image生成计数器，同时也是Leader节点将元数据镜像成功推送到其他非Leader节点的计数器。这两项指标会以合理的时间间隔增加，且通常它们应该相等。",
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
      "unit": "none"
      },
      "overrides": []
      },
      "gridPos": {
      "h": 6,
      "w": 6,
      "x": 6,
      "y": 29
      },
      "id": 65,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull"
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_fe_image_write{namespace=~\"$namespace\", instance=\"$fe_master\"}",
      "format": "time_series",
      "instant": false,
      "intervalFactor": 1,
      "legendFormat": "{{instance}}-generate",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_fe_image_push{namespace=~\"$namespace\", instance=\"$fe_master\"}",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}-push",
      "refId": "B"
      }
      ],
      "title": "StarRocks Image Counter",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "FE BDB元数据log条数，默认超过5万条会触发Checkpoint进行落盘。如果该值过大，就要观察是否JVM内存过小或其他原因导致Checkpoint失败。",
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
      "fillOpacity": 0,
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
      "unit": "none"
      },
      "overrides": []
      },
      "gridPos": {
      "h": 6,
      "w": 6,
      "x": 12,
      "y": 29
      },
      "id": 146,
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
      "editorMode": "builder",
      "expr": "starrocks_fe_meta_log_count{namespace=~\"$namespace\"}",
      "instant": false,
      "legendFormat": "{{instance}}",
      "range": true,
      "refId": "A"
      }
      ],
      "title": "StarRocks Meta Log Count",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "正在进行调度任务的Tablet数量。这些Tablet可能处于Recovery或Balance的过程中。",
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
      "overrides": []
      },
      "gridPos": {
      "h": 6,
      "w": 6,
      "x": 18,
      "y": 29
      },
      "id": 117,
      "links": [],
      "options": {
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_fe_scheduled_tablet_num{namespace=~\"$namespace\", instance=\"$fe_master\"}",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "Scheduling tablet number",
      "refId": "A"
      }
      ],
      "title": "StarRocks Scheduling Tablets",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "各个BE节点的磁盘IO使用率。",
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
      "fillOpacity": 0,
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
      "decimals": 0,
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
      "unit": "percent"
      },
      "overrides": []
      },
      "gridPos": {
      "h": 6,
      "w": 6,
      "x": 0,
      "y": 35
      },
      "id": 125,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_be_max_disk_io_util_percent{namespace=~\"$namespace\"}",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}",
      "refId": "A"
      }
      ],
      "title": "StarRocks BE IO Util",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "各个BE节点的Compaction Score值。通常该值需要维持在100以内，而在大部分批量导入或低频导入场景下，该值通常为10-20或者更低。如果该值过高，不仅会影响导入，还会影响集群的查询性能，此时我们就需要及时的降低导入频率。",
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
      "fillOpacity": 0,
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
      "unit": "none"
      },
      "overrides": []
      },
      "gridPos": {
      "h": 6,
      "w": 6,
      "x": 6,
      "y": 35
      },
      "id": 142,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_fe_tablet_max_compaction_score{namespace=~\"$namespace\", instance=\"$fe_master\"}",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}",
      "refId": "A"
      }
      ],
      "title": "StarRocks BE Compaction Score",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "BE最大的Base Compaction Score，表示当前BE节点的Base Compaction压力。",
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
      "fillOpacity": 0,
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
      "h": 6,
      "w": 6,
      "x": 12,
      "y": 35
      },
      "id": 144,
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
      "editorMode": "builder",
      "expr": "starrocks_be_tablet_base_max_compaction_score{namespace=~\"$namespace\"}",
      "instant": false,
      "legendFormat": "{{instance}}",
      "range": true,
      "refId": "A"
      }
      ],
      "title": "StarRocks Base Compaction Score",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "BE最大的增量Compaction Score，表示当前BE节点的增量Compaction压力。",
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
      "fillOpacity": 0,
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
      "h": 6,
      "w": 6,
      "x": 18,
      "y": 35
      },
      "id": 145,
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
      "editorMode": "builder",
      "expr": "starrocks_be_tablet_cumulative_max_compaction_score{namespace=~\"$namespace\"}",
      "instant": false,
      "legendFormat": "{{instance}}",
      "range": true,
      "refId": "A"
      }
      ],
      "title": "StarRocks Cumulative Compaction Score",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "BDBJE写入情况，正常都是毫秒级别，如果出现秒级的写入速度就需要警惕，严重的元数据写入延迟可能会引起写入错误。通常高延迟的情况可能是磁盘性能较弱，此时建议为FE元数据目录更换性能更优的磁盘。在StarRocks中，使用BDBJE完成元数据操作日志的持久化、FE高可用等功能。左侧Y轴显示99th写入延迟，右侧的Y轴显示日志每秒写入次数。",
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
      "unit": "ms"
      },
      "overrides": [
      {
      "matcher": {
      "id": "byRegexp",
      "options": "/.*-rate/"
      },
      "properties": [
      {
      "id": "custom.showPoints",
      "value": "auto"
      },
      {
      "id": "unit",
      "value": "wps"
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 6,
      "w": 12,
      "x": 0,
      "y": 41
      },
      "id": 112,
      "links": [],
      "options": {
      "legend": {
      "calcs": [],
      "displayMode": "table",
      "placement": "bottom",
      "showLegend": true
      },
      "tooltip": {
      "mode": "multi",
      "sort": "none"
      }
      },
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_fe_editlog_write_latency_ms{namespace=~\"$namespace\", instance=\"$fe_master\",quantile=\"0.99\"}",
      "format": "time_series",
      "hide": false,
      "intervalFactor": 1,
      "legendFormat": "{{instance}}-99th",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "rate(starrocks_fe_edit_log_write{namespace=~\"$namespace\", instance=\"$fe_master\"}[$interval])",
      "format": "time_series",
      "hide": false,
      "intervalFactor": 1,
      "legendFormat": "{{instance}}-rate",
      "refId": "B"
      }
      ],
      "title": "StarRocks BDBJE Write",
      "type": "timeseries"
      },
      {
      "collapsed": false,
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "gridPos": {
      "h": 1,
      "w": 24,
      "x": 0,
      "y": 47
      },
      "id": 47,
      "panels": [],
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "refId": "A"
      }
      ],
      "title": "Query Statistic",
      "type": "row"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "各个FE的每秒请求数。这里的请求包括发送到FE的所有请求。",
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
      "unit": "ops"
      },
      "overrides": []
      },
      "gridPos": {
      "h": 9,
      "w": 8,
      "x": 0,
      "y": 48
      },
      "id": 52,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "rate(starrocks_fe_request_total{namespace=~\"$namespace\"}[$interval])",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}",
      "refId": "B"
      }
      ],
      "title": "StarRocks RPS",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "各个FE的每秒查询数。查询仅包括Select请求。",
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
      "unit": "ops"
      },
      "overrides": []
      },
      "gridPos": {
      "h": 9,
      "w": 8,
      "x": 8,
      "y": 48
      },
      "id": 53,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "rate(starrocks_fe_query_total{namespace=~\"$namespace\"}[$interval])",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}",
      "refId": "B"
      }
      ],
      "title": "StarRocks QPS",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "各个FE的99th查询延迟情况。99th Percentile Latency：处理速度最快的99%的操作中，最长的延迟时间，单位为毫秒。例如该指标的值为10毫秒，表示99%的请求可以在10毫秒内得到处理。",
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
      "unit": "ms"
      },
      "overrides": []
      },
      "gridPos": {
      "h": 9,
      "w": 8,
      "x": 16,
      "y": 48
      },
      "id": 54,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "sum(starrocks_fe_query_latency_ms{namespace=~\"$namespace\", quantile=\"0.99\"}) by (instance)",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}",
      "refId": "B"
      }
      ],
      "title": "StarRocks 99th Latency",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "左Y轴表示每个FE的75th到99.9th查询延迟的情况。右侧Y轴表示每分钟的查询速率。",
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
      "unit": "ms"
      },
      "overrides": [
      {
      "matcher": {
      "id": "byName",
      "options": "query rate"
      },
      "properties": [
      {
      "id": "custom.lineWidth",
      "value": 0
      },
      {
      "id": "custom.showPoints",
      "value": "always"
      },
      {
      "id": "unit",
      "value": "short"
      },
      {
      "id": "decimals",
      "value": 0
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "0.999"
      },
      "properties": [
      {
      "id": "custom.lineWidth",
      "value": 0
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 6,
      "w": 8,
      "x": 0,
      "y": 57
      },
      "id": 30,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "mean",
      "lastNotNull"
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_fe_query_latency_ms{namespace=~\"$namespace\", instance=\"$fe_instance\"}",
      "format": "time_series",
      "intervalFactor": 2,
      "legendFormat": "{{quantile}}",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_fe_query_latency_ms_count{namespace=~\"$namespace\", instance=\"$fe_instance\"}",
      "format": "time_series",
      "hide": true,
      "intervalFactor": 2,
      "legendFormat": "count",
      "refId": "B"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "rate(starrocks_fe_query_latency_ms_count{namespace=~\"$namespace\", instance=\"$fe_instance\"}[1m])",
      "format": "time_series",
      "intervalFactor": 2,
      "legendFormat": "query rate",
      "refId": "C"
      }
      ],
      "title": "StarRocks [$fe_instance] Query Percentile",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "左Y轴表示累计错误查询次数。右侧Y轴表示每分钟的错误查询率。通常，错误查询率应为0。",
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
      "decimals": 2,
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
      "overrides": []
      },
      "gridPos": {
      "h": 6,
      "w": 8,
      "x": 8,
      "y": 57
      },
      "id": 33,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_fe_query_err{namespace=~\"$namespace\"}",
      "format": "time_series",
      "hide": false,
      "intervalFactor": 2,
      "legendFormat": "Err Counter-{{instance}}",
      "refId": "B"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "rate(starrocks_fe_query_err{namespace=~\"$namespace\"}[$interval])",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "Err Rate-{{instance}}",
      "refId": "C"
      }
      ],
      "title": "StarRocks Query Error",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "各个FE当前的连接数。",
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
      "h": 6,
      "w": 8,
      "x": 16,
      "y": 57
      },
      "id": 34,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_fe_connection_total{namespace=~\"$namespace\"}",
      "format": "time_series",
      "intervalFactor": 2,
      "legendFormat": "{{instance}}",
      "refId": "A"
      }
      ],
      "title": "StarRocks Connections",
      "type": "timeseries"
      },
      {
      "collapsed": false,
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "gridPos": {
      "h": 1,
      "w": 24,
      "x": 0,
      "y": 63
      },
      "id": 128,
      "panels": [],
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "refId": "A"
      }
      ],
      "title": "Jobs",
      "type": "row"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "已完成的Broker Load作业数。",
      "fieldConfig": {
      "defaults": {
      "color": {
      "fixedColor": "green",
      "mode": "fixed"
      },
      "custom": {
      "align": "auto",
      "cellOptions": {
      "type": "color-text"
      },
      "inspect": false
      },
      "decimals": 0,
      "displayName": "",
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
      "overrides": [
      {
      "matcher": {
      "id": "byName",
      "options": "state"
      },
      "properties": [
      {
      "id": "unit",
      "value": "short"
      },
      {
      "id": "decimals",
      "value": 2
      },
      {
      "id": "custom.align"
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "Value"
      },
      "properties": [
      {
      "id": "decimals",
      "value": 0
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "Time"
      },
      "properties": [
      {
      "id": "custom.hidden",
      "value": true
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "__name__"
      },
      "properties": [
      {
      "id": "custom.hidden",
      "value": true
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "exported_job"
      },
      "properties": [
      {
      "id": "custom.hidden",
      "value": true
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "group"
      },
      "properties": [
      {
      "id": "custom.hidden",
      "value": true
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "instance"
      },
      "properties": [
      {
      "id": "custom.hidden",
      "value": true
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "job"
      },
      "properties": [
      {
      "id": "custom.hidden",
      "value": true
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 5,
      "w": 8,
      "x": 0,
      "y": 64
      },
      "id": 141,
      "links": [],
      "options": {
      "cellHeight": "sm",
      "footer": {
      "countRows": false,
      "enablePagination": false,
      "fields": [],
      "reducer": [
      "sum"
      ],
      "show": false
      },
      "showHeader": true
      },
      "pluginVersion": "10.0.3",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_fe_job{namespace=~\"$namespace\", exported_job=\"load\", type=\"BROKER\", instance=\"$fe_master\",state=\"FINISHED\"}",
      "format": "table",
      "instant": true,
      "intervalFactor": 2,
      "refId": "A"
      }
      ],
      "title": "StarRocks Broker Load Job",
      "transformations": [
      {
      "id": "merge",
      "options": {
      "reducers": []
      }
      }
      ],
      "type": "table"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "已完成的Insert导入任务数。",
      "fieldConfig": {
      "defaults": {
      "color": {
      "mode": "thresholds"
      },
      "custom": {
      "align": "auto",
      "cellOptions": {
      "type": "color-text"
      },
      "inspect": false
      },
      "decimals": 2,
      "displayName": "",
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
      "overrides": [
      {
      "matcher": {
      "id": "byName",
      "options": "state"
      },
      "properties": [
      {
      "id": "unit",
      "value": "short"
      },
      {
      "id": "decimals",
      "value": 2
      },
      {
      "id": "custom.align"
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "Value"
      },
      "properties": [
      {
      "id": "unit",
      "value": "none"
      },
      {
      "id": "custom.align"
      },
      {
      "id": "decimals",
      "value": 0
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "Time"
      },
      "properties": [
      {
      "id": "custom.hidden",
      "value": true
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "__name__"
      },
      "properties": [
      {
      "id": "custom.hidden",
      "value": true
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "exported_job"
      },
      "properties": [
      {
      "id": "custom.hidden",
      "value": true
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "group"
      },
      "properties": [
      {
      "id": "custom.hidden",
      "value": true
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "instance"
      },
      "properties": [
      {
      "id": "custom.hidden",
      "value": true
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "job"
      },
      "properties": [
      {
      "id": "custom.hidden",
      "value": true
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 5,
      "w": 8,
      "x": 8,
      "y": 64
      },
      "id": 140,
      "links": [],
      "options": {
      "cellHeight": "sm",
      "footer": {
      "countRows": false,
      "fields": "",
      "reducer": [
      "sum"
      ],
      "show": false
      },
      "showHeader": true
      },
      "pluginVersion": "10.0.3",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_fe_job{namespace=~\"$namespace\", exported_job=\"load\", type=\"INSERT\", instance=\"$fe_master\",state=\"FINISHED\"}",
      "format": "table",
      "instant": true,
      "intervalFactor": 2,
      "refId": "A"
      }
      ],
      "title": "StarRocks Insert Load Job",
      "transformations": [
      {
      "id": "merge",
      "options": {
      "reducers": []
      }
      }
      ],
      "type": "table"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "正在进行的Schema Change任务数。",
      "fieldConfig": {
      "defaults": {
      "color": {
      "mode": "thresholds"
      },
      "custom": {
      "align": "auto",
      "cellOptions": {
      "type": "color-text"
      },
      "inspect": false
      },
      "decimals": 2,
      "displayName": "",
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
      "overrides": [
      {
      "matcher": {
      "id": "byName",
      "options": "state"
      },
      "properties": [
      {
      "id": "unit",
      "value": "short"
      },
      {
      "id": "decimals",
      "value": 2
      },
      {
      "id": "custom.align"
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "Value"
      },
      "properties": [
      {
      "id": "unit",
      "value": "short"
      },
      {
      "id": "decimals",
      "value": 0
      },
      {
      "id": "custom.align"
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "Time"
      },
      "properties": [
      {
      "id": "custom.hidden",
      "value": true
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "__name__"
      },
      "properties": [
      {
      "id": "custom.hidden",
      "value": true
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "exported_job"
      },
      "properties": [
      {
      "id": "custom.hidden",
      "value": true
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "group"
      },
      "properties": [
      {
      "id": "custom.hidden",
      "value": true
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "instance"
      },
      "properties": [
      {
      "id": "custom.hidden",
      "value": true
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "job"
      },
      "properties": [
      {
      "id": "custom.hidden",
      "value": true
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 5,
      "w": 8,
      "x": 16,
      "y": 64
      },
      "id": 135,
      "links": [],
      "options": {
      "cellHeight": "sm",
      "footer": {
      "countRows": false,
      "fields": "",
      "reducer": [
      "sum"
      ],
      "show": false
      },
      "showHeader": true
      },
      "pluginVersion": "10.0.3",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "editorMode": "code",
      "expr": "starrocks_fe_job{namespace=~\"$namespace\", instance=\"$fe_master\", type=\"SCHEMA_CHANGE\"}",
      "format": "table",
      "hide": false,
      "instant": true,
      "intervalFactor": 2,
      "legendFormat": "asds",
      "refId": "A"
      }
      ],
      "title": "StarRocks Schema Change Job",
      "transformations": [
      {
      "id": "merge",
      "options": {
      "reducers": []
      }
      }
      ],
      "type": "table"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "导入作业提交数和完成数的计数器。如果是Routine Load导入，则两条线显示为并行。此外，右Y轴显示每小时导入作业的提交速率。",
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
      "decimals": 0,
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
      "overrides": [
      {
      "matcher": {
      "id": "byRegexp",
      "options": "/.*Submit rate/"
      },
      "properties": [
      {
      "id": "custom.showPoints",
      "value": "always"
      },
      {
      "id": "min",
      "value": 0
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 6,
      "w": 16,
      "x": 0,
      "y": 69
      },
      "id": 90,
      "links": [],
      "options": {
      "legend": {
      "calcs": [],
      "displayMode": "list",
      "placement": "right",
      "showLegend": true
      },
      "tooltip": {
      "mode": "multi",
      "sort": "none"
      }
      },
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_fe_load_add{instance=\"$fe_master\"}",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}-Submit",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_fe_load_finished{instance=\"$fe_master\"}",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}-Finished",
      "refId": "B"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "rate(starrocks_fe_load_add{instance=\"$fe_master\"}[1h])",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}-Submit rate",
      "refId": "C"
      }
      ],
      "title": "StarRocks Load Submit",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "查询执行线程数，默认启动64个线程，后续查询请求将动态创建线程。一般大于3000就需要关注，此时可降低并发或调低查询并行度缓解。",
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
      "fillOpacity": 0,
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
      "h": 6,
      "w": 8,
      "x": 16,
      "y": 69
      },
      "id": 147,
      "options": {
      "legend": {
      "calcs": [],
      "displayMode": "list",
      "placement": "right",
      "showLegend": false
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
      "editorMode": "builder",
      "expr": "sum(starrocks_fe_thread_pool{namespace=~\"$namespace\"})",
      "instant": false,
      "legendFormat": "{{instance}}",
      "range": true,
      "refId": "A"
      }
      ],
      "title": "StarRocks FE Thread Pool",
      "type": "timeseries"
      },
      {
      "collapsed": false,
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "gridPos": {
      "h": 1,
      "w": 24,
      "x": 0,
      "y": 75
      },
      "id": 107,
      "panels": [],
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "refId": "A"
      }
      ],
      "title": "Transaction",
      "type": "row"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "显示FE中事务开始和成功的数量和速度。",
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
      "unit": "none"
      },
      "overrides": [
      {
      "matcher": {
      "id": "byName",
      "options": "txn begin"
      },
      "properties": [
      {
      "id": "min",
      "value": 0
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "txn begin rate"
      },
      "properties": [
      {
      "id": "custom.lineWidth",
      "value": 0
      },
      {
      "id": "custom.showPoints",
      "value": "always"
      },
      {
      "id": "unit",
      "value": "ops"
      },
      {
      "id": "min",
      "value": 0
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "txn success rate"
      },
      "properties": [
      {
      "id": "custom.lineWidth",
      "value": 0
      },
      {
      "id": "custom.showPoints",
      "value": "always"
      },
      {
      "id": "unit",
      "value": "ops"
      },
      {
      "id": "min",
      "value": 0
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "txn success"
      },
      "properties": [
      {
      "id": "min",
      "value": 0
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 6,
      "w": 6,
      "x": 0,
      "y": 76
      },
      "id": 124,
      "links": [],
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_fe_txn_begin{namespace=~\"$namespace\", instance=\"$fe_master\"}",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "txn begin",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_fe_txn_success{namespace=~\"$namespace\", instance=\"$fe_master\"}",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "txn success",
      "refId": "D"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "irate(starrocks_fe_txn_begin{namespace=~\"$namespace\", instance=\"$fe_master\"}[$interval])",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "txn begin rate",
      "refId": "B"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "irate(starrocks_fe_txn_success{namespace=~\"$namespace\", instance=\"$fe_master\"}[$interval])",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "txn success rate",
      "refId": "C"
      }
      ],
      "title": "StarRocks Txn Begin/Success on FE",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "显示FE中失败的事务请求，包括被拒绝的请求和失败的事务请求。",
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
      "unit": "ops"
      },
      "overrides": [
      {
      "matcher": {
      "id": "byName",
      "options": "txn failed rate"
      },
      "properties": [
      {
      "id": "custom.lineWidth",
      "value": 0
      },
      {
      "id": "custom.showPoints",
      "value": "always"
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "txn reject rate"
      },
      "properties": [
      {
      "id": "custom.lineWidth",
      "value": 0
      },
      {
      "id": "custom.showPoints",
      "value": "always"
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 6,
      "w": 6,
      "x": 6,
      "y": 76
      },
      "id": 123,
      "links": [],
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "rate(starrocks_fe_txn_reject{namespace=~\"$namespace\", instance=\"$fe_master\"}[$interval])",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "txn reject rate",
      "refId": "C"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "rate(starrocks_fe_txn_failed{namespace=~\"$namespace\", instance=\"$fe_master\"}[$interval])",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "txn failed rate",
      "refId": "D"
      }
      ],
      "title": "StarRocks Txn Failed/Reject on FE",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "BE中Publish Task请求总数和错误率。",
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
      "options": "Total"
      },
      "properties": [
      {
      "id": "decimals",
      "value": 0
      },
      {
      "id": "custom.axisPlacement",
      "value": "left"
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "192.168.146.10:8040"
      },
      "properties": [
      {
      "id": "custom.axisPlacement",
      "value": "right"
      },
      {
      "id": "unit",
      "value": "percent"
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 6,
      "w": 6,
      "x": 12,
      "y": 76
      },
      "id": 126,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull",
      "sum"
      ],
      "displayMode": "table",
      "placement": "bottom",
      "showLegend": true
      },
      "timezone": [
      ""
      ],
      "tooltip": {
      "mode": "multi",
      "sort": "none"
      }
      },
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "sum(starrocks_be_engine_requests_total{namespace=~\"$namespace\", type=\"publish\", status=\"total\"})",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "Total",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "irate(starrocks_be_engine_requests_total{namespace=~\"$namespace\", type=\"publish\", status=\"failed\"}[$interval])",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}",
      "refId": "B"
      }
      ],
      "title": "StarRocks Publish Task on BE",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "数据导入速率，仅统计以Stream Load方式写入的数据，包括Routine Load、Flink Connector等。",
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
      "fillOpacity": 0,
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
      "unit": "bytes"
      },
      "overrides": [
      {
      "matcher": {
      "id": "byName",
      "options": "receive_bytes"
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
      "options": "load_rows"
      },
      "properties": [
      {
      "id": "color",
      "value": {
      "fixedColor": "dark-green",
      "mode": "shades"
      }
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 6,
      "w": 6,
      "x": 18,
      "y": 76
      },
      "id": 148,
      "options": {
      "legend": {
      "calcs": [
      "last"
      ],
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
      "expr": "sum(rate(starrocks_be_stream_load{namespace=~\"$namespace\", type=\"receive_bytes\"}[$interval]))",
      "hide": false,
      "instant": false,
      "legendFormat": "receive_bytes",
      "range": true,
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "editorMode": "code",
      "expr": "sum(rate(starrocks_be_stream_load{namespace=~\"$namespace\", type=\"load_rows\"}[$interval]))",
      "hide": false,
      "instant": false,
      "legendFormat": "load_rows",
      "range": true,
      "refId": "B"
      }
      ],
      "title": "StarRocks Txn Load Bytes/Rows rate",
      "type": "timeseries"
      },
      {
      "collapsed": false,
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "gridPos": {
      "h": 1,
      "w": 24,
      "x": 0,
      "y": 82
      },
      "id": 49,
      "panels": [],
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "refId": "A"
      }
      ],
      "title": "FE JVM",
      "type": "row"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "指定FE的JVM堆内存使用情况。左Y轴显示已使用堆内存及使用最大堆内存，右Y轴显示使用的百分比。",
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
      "options": "percentage"
      },
      "properties": [
      {
      "id": "color",
      "value": {
      "fixedColor": "#890f02",
      "mode": "fixed"
      }
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "percentage"
      },
      "properties": [
      {
      "id": "unit",
      "value": "percent"
      },
      {
      "id": "min",
      "value": 0
      },
      {
      "id": "max",
      "value": 100
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 6,
      "w": 6,
      "x": 0,
      "y": 83
      },
      "id": 13,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull"
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "jvm_heap_size_bytes{instance=\"$fe_instance\", namespace=~\"$namespace\", type=\"used\"}",
      "format": "time_series",
      "hide": false,
      "instant": false,
      "intervalFactor": 2,
      "legendFormat": "used",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "jvm_heap_size_bytes{instance=\"$fe_instance\", namespace=~\"$namespace\", type=\"max\"}",
      "format": "time_series",
      "hide": false,
      "intervalFactor": 2,
      "legendFormat": "max",
      "refId": "B"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "sum(jvm_heap_size_bytes{instance=\"$fe_instance\", namespace=~\"$namespace\", type=\"used\"}) * 100 / sum(jvm_heap_size_bytes{instance=\"$fe_instance\", namespace=~\"$namespace\", type=\"max\"})",
      "format": "time_series",
      "hide": false,
      "intervalFactor": 2,
      "legendFormat": "percentage",
      "refId": "C"
      }
      ],
      "title": "StarRocks [$fe_instance] JVM Heap",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "指定FE的JVM非堆内存使用情况。左Y轴显示“已使用/提交”的非堆内存大小。",
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
      "unit": "bytes"
      },
      "overrides": [
      {
      "matcher": {
      "id": "byName",
      "options": "percentage"
      },
      "properties": [
      {
      "id": "color",
      "value": {
      "fixedColor": "#890f02",
      "mode": "fixed"
      }
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "percentage"
      },
      "properties": [
      {
      "id": "unit",
      "value": "percent"
      },
      {
      "id": "max",
      "value": 100
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 6,
      "w": 6,
      "x": 6,
      "y": 83
      },
      "id": 24,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull"
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "jvm_non_heap_size_bytes{instance=\"$fe_instance\", namespace=~\"$namespace\", type=\"used\"}",
      "format": "time_series",
      "hide": false,
      "instant": false,
      "intervalFactor": 2,
      "legendFormat": "used",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "jvm_non_heap_size_bytes{instance=\"$fe_instance\", namespace=~\"$namespace\", type=\"committed\"}",
      "format": "time_series",
      "hide": false,
      "intervalFactor": 2,
      "legendFormat": "committed",
      "refId": "B"
      }
      ],
      "title": "StarRocks [$fe_instance] JVM Non Heap",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "指定FE的JVM直接缓冲区使用情况。左Y轴显示已用/容量直接缓冲区大小。",
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
      "decimals": 1,
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
      "unit": "bytes"
      },
      "overrides": [
      {
      "matcher": {
      "id": "byName",
      "options": "percentage"
      },
      "properties": [
      {
      "id": "color",
      "value": {
      "fixedColor": "#890f02",
      "mode": "fixed"
      }
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "percentage"
      },
      "properties": [
      {
      "id": "unit",
      "value": "percent"
      },
      {
      "id": "max",
      "value": 100
      },
      {
      "id": "custom.axisPlacement",
      "value": "hidden"
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 6,
      "w": 6,
      "x": 12,
      "y": 83
      },
      "id": 25,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull"
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "jvm_direct_buffer_pool_size_bytes{instance=\"$fe_instance\", namespace=~\"$namespace\", type=\"used\"}",
      "format": "time_series",
      "hide": false,
      "instant": false,
      "intervalFactor": 2,
      "legendFormat": "used",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "jvm_direct_buffer_pool_size_bytes{instance=\"$fe_instance\", namespace=~\"$namespace\", type=\"capacity\"}",
      "format": "time_series",
      "hide": false,
      "intervalFactor": 2,
      "legendFormat": "capacity",
      "refId": "B"
      }
      ],
      "title": "StarRocks [$fe_instance] JVM Direct Buffer",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "FE JVM线程数。",
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
      "overrides": []
      },
      "gridPos": {
      "h": 6,
      "w": 6,
      "x": 18,
      "y": 83
      },
      "id": 88,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull",
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "jvm_thread{namespace=~\"$namespace\", type=\"count\"}",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}",
      "refId": "A"
      }
      ],
      "title": "StarRocks JVM Threads",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "指定FE的JVM Young Generation内存占用。左Y轴显示已使用/最大Young Generation内存大小。右Y轴显示使用的百分比。",
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
      "options": "percentage"
      },
      "properties": [
      {
      "id": "color",
      "value": {
      "fixedColor": "#890f02",
      "mode": "fixed"
      }
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "percentage"
      },
      "properties": [
      {
      "id": "unit",
      "value": "percent"
      },
      {
      "id": "min",
      "value": 0
      },
      {
      "id": "max",
      "value": 100
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 6,
      "w": 6,
      "x": 0,
      "y": 89
      },
      "id": 26,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull"
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "jvm_young_size_bytes{namespace=~\"$namespace\", instance=\"$fe_instance\", type=\"used\"}",
      "format": "time_series",
      "intervalFactor": 2,
      "legendFormat": "used",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "jvm_young_size_bytes{namespace=~\"$namespace\", instance=\"$fe_instance\", type=\"max\"}",
      "format": "time_series",
      "intervalFactor": 2,
      "legendFormat": "max",
      "refId": "B"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "sum(jvm_young_size_bytes{namespace=~\"$namespace\", instance=\"$fe_instance\", type=\"used\"}) * 100 / sum(jvm_young_size_bytes{namespace=~\"$namespace\", instance=\"$fe_instance\", type=\"max\"})",
      "format": "time_series",
      "intervalFactor": 2,
      "legendFormat": "percentage",
      "refId": "C"
      }
      ],
      "title": "StarRocks [$fe_instance] JVM Young",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "指定FE的JVM Old Generation内存占用。左Y轴显示已使用/最大Old Generation内存大小。右Y轴显示使用的百分比。通常，使用百分比应小于80%。",
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
      "options": "percentage"
      },
      "properties": [
      {
      "id": "color",
      "value": {
      "fixedColor": "#890f02",
      "mode": "fixed"
      }
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "percentage"
      },
      "properties": [
      {
      "id": "unit",
      "value": "percent"
      },
      {
      "id": "min",
      "value": 0
      },
      {
      "id": "max",
      "value": 100
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 6,
      "w": 6,
      "x": 6,
      "y": 89
      },
      "id": 27,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull"
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "jvm_old_size_bytes{namespace=~\"$namespace\", instance=\"$fe_instance\", type=\"used\"}",
      "format": "time_series",
      "intervalFactor": 2,
      "legendFormat": "used",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "jvm_old_size_bytes{namespace=~\"$namespace\", instance=\"$fe_instance\", type=\"max\"}",
      "format": "time_series",
      "intervalFactor": 2,
      "legendFormat": "max",
      "refId": "B"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "sum(jvm_old_size_bytes{namespace=~\"$namespace\", instance=\"$fe_instance\", type=\"used\"}) * 100 / sum(jvm_old_size_bytes{namespace=~\"$namespace\", instance=\"$fe_instance\", type=\"max\"})",
      "format": "time_series",
      "intervalFactor": 2,
      "legendFormat": "percentage",
      "refId": "C"
      }
      ],
      "title": "StarRocks [$fe_instance] JVM Old",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "指定FE的JVM Young GC统计信息。左Y轴显示Young GC的次数。右Y轴显示每个Young GC的耗时。",
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
      "decimals": 0,
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
      "overrides": [
      {
      "matcher": {
      "id": "byName",
      "options": "percentage"
      },
      "properties": [
      {
      "id": "color",
      "value": {
      "fixedColor": "#890f02",
      "mode": "fixed"
      }
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "percentage"
      },
      "properties": [
      {
      "id": "unit",
      "value": "ms"
      },
      {
      "id": "min",
      "value": 0
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "avg time"
      },
      "properties": [
      {
      "id": "unit",
      "value": "ms"
      },
      {
      "id": "min",
      "value": 0
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 6,
      "w": 6,
      "x": 12,
      "y": 89
      },
      "id": 28,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull"
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "jvm_young_gc{namespace=~\"$namespace\", instance=\"$fe_instance\", type=\"count\"}",
      "format": "time_series",
      "intervalFactor": 2,
      "legendFormat": "count",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "sum(jvm_young_gc{namespace=~\"$namespace\", instance=\"$fe_instance\", type=\"time\"}) / sum(jvm_young_gc{namespace=~\"$namespace\", instance=\"$fe_instance\", type=\"count\"})",
      "format": "time_series",
      "hide": false,
      "intervalFactor": 2,
      "legendFormat": "avg time",
      "refId": "B"
      }
      ],
      "title": "StarRocks [$fe_instance] JVM Young GC",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "指定FE的Full GC状态展示。左Y轴显示Full GC的次数。右Y轴显示每个Full GC的耗时。",
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
      "decimals": 0,
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
      "overrides": [
      {
      "matcher": {
      "id": "byName",
      "options": "percentage"
      },
      "properties": [
      {
      "id": "color",
      "value": {
      "fixedColor": "#890f02",
      "mode": "fixed"
      }
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "percentage"
      },
      "properties": [
      {
      "id": "unit",
      "value": "ms"
      },
      {
      "id": "min",
      "value": 0
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "avg time"
      },
      "properties": [
      {
      "id": "unit",
      "value": "ms"
      },
      {
      "id": "min",
      "value": 0
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 6,
      "w": 6,
      "x": 18,
      "y": 89
      },
      "id": 29,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull"
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "jvm_old_gc{namespace=~\"$namespace\", instance=\"$fe_instance\", type=\"count\"}",
      "format": "time_series",
      "intervalFactor": 2,
      "legendFormat": "count",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "sum(jvm_old_gc{namespace=~\"$namespace\", instance=\"$fe_instance\", type=\"time\"}) / sum(jvm_old_gc{namespace=~\"$namespace\", instance=\"$fe_instance\", type=\"count\"})",
      "format": "time_series",
      "hide": false,
      "intervalFactor": 2,
      "legendFormat": "avg time",
      "refId": "B"
      }
      ],
      "title": "StarRocks [$fe_instance] JVM Old GC",
      "type": "timeseries"
      },
      {
      "collapsed": false,
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "gridPos": {
      "h": 1,
      "w": 24,
      "x": 0,
      "y": 95
      },
      "id": 50,
      "panels": [],
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "refId": "A"
      }
      ],
      "title": "BE",
      "type": "row"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "BE CPU的空闲状态，值越小表示CPU越繁忙。注意：Idle是“空闲”的意思。",
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
      "fillOpacity": 0,
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
      "unit": "percent"
      },
      "overrides": []
      },
      "gridPos": {
      "h": 9,
      "w": 12,
      "x": 0,
      "y": 96
      },
      "id": 32,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull",
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "(sum(rate(starrocks_be_cpu{mode=\"idle\", namespace=~\"$namespace\"}[$interval])) by (job, instance)) / (sum(rate(starrocks_be_cpu{namespace=~\"$namespace\"}[$interval])) by (job, instance)) * 100",
      "format": "time_series",
      "intervalFactor": 2,
      "legendFormat": "{{instance}}",
      "refId": "A"
      }
      ],
      "title": "StarRocks BE CPU Idle",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "各个BE节点的内存使用情况。",
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
      "fillOpacity": 0,
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
      "unit": "bytes"
      },
      "overrides": []
      },
      "gridPos": {
      "h": 9,
      "w": 12,
      "x": 12,
      "y": 96
      },
      "id": 38,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull",
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_be_process_mem_bytes{namespace=~\"$namespace\"}",
      "format": "time_series",
      "intervalFactor": 2,
      "legendFormat": "{{instance}}",
      "refId": "A"
      }
      ],
      "title": "StarRocks BE Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "除IO外的所有设备的网络发送（左Y轴）/接收（右Y轴）的字节速率。",
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
      "fillOpacity": 0,
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
      "unit": "Bps"
      },
      "overrides": []
      },
      "gridPos": {
      "h": 7,
      "w": 8,
      "x": 0,
      "y": 105
      },
      "id": 86,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "mean",
      "lastNotNull"
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "irate(starrocks_be_network_send_bytes{namespace=~\"$namespace\", job=~\"metrics-starrocks-be.*\", device!=\"lo\"}[$interval])",
      "format": "time_series",
      "hide": false,
      "intervalFactor": 1,
      "legendFormat": "{{instance}}-{{device}}-send",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "irate(starrocks_be_network_receive_bytes{namespace=~\"$namespace\", job=~\"metrics-starrocks-be.*\", device!=\"lo\"}[$interval])",
      "format": "time_series",
      "hide": false,
      "intervalFactor": 1,
      "legendFormat": "{{instance}}-{{device}}-receive",
      "refId": "B"
      }
      ],
      "title": "StarRocks Net Send/Receive Bytes",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "各BE节点存储目录的磁盘空间使用率。",
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
      "fillOpacity": 0,
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
      "mappings": [],
      "max": 1,
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
      "unit": "percentunit"
      },
      "overrides": []
      },
      "gridPos": {
      "h": 7,
      "w": 8,
      "x": 8,
      "y": 105
      },
      "id": 56,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull"
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "(SUM(starrocks_be_disks_total_capacity{namespace=~\"$namespace\"}) by (instance, path) - SUM(starrocks_be_disks_avail_capacity{namespace=~\"$namespace\"}) by (instance, path)) / SUM(starrocks_be_disks_total_capacity{namespace=~\"$namespace\"}) by (instance, path)",
      "format": "time_series",
      "hide": false,
      "instant": false,
      "intervalFactor": 1,
      "legendFormat": "{{instance}}:{{path}}",
      "refId": "C"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "(SUM(starrocks_be_disks_data_used_capacity{namespace=~\"$namespace\"}) by (instance, path)) / SUM(starrocks_be_disks_total_capacity{namespace=~\"$namespace\"}) by (instance, path)",
      "format": "time_series",
      "hide": true,
      "intervalFactor": 1,
      "refId": "A"
      }
      ],
      "title": "StarRocks Disk Usage",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "每个BE节点上的Tablet分布情况。原则上分布是均衡的，如果差别特别大，就需要去分析原因。",
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
      "fillOpacity": 0,
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
      "unit": "none"
      },
      "overrides": []
      },
      "gridPos": {
      "h": 7,
      "w": 8,
      "x": 16,
      "y": 105
      },
      "id": 115,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull"
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_fe_tablet_num{namespace=~\"$namespace\", instance=\"$fe_master\"}",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{backend}}",
      "refId": "A"
      }
      ],
      "title": "StarRocks Tablet Distribution",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "BE的文件描述符（File Descriptor）使用情况。左侧Y轴显示BE使用的FD数量。右侧Y轴显示系统对每个进程的FD软限制数。备注：文件描述符通过ulimit -n进行配置。",
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
      "fillOpacity": 0,
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
      "id": "byRegexp",
      "options": "/.*limit/"
      },
      "properties": [
      {
      "id": "custom.showPoints",
      "value": "auto"
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 7,
      "w": 8,
      "x": 0,
      "y": 112
      },
      "id": 94,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_be_process_fd_num_used{namespace=~\"$namespace\", job=~\"metrics-starrocks-be.*\"}",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}-used",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_be_process_fd_num_limit_soft{namespace=~\"$namespace\", job=~\"metrics-starrocks-be.*\"}",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}-soft limit",
      "refId": "B"
      }
      ],
      "title": "StarRocks BE FD Count",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "各BE进程的线程数。",
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
      "fillOpacity": 0,
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
      "overrides": []
      },
      "gridPos": {
      "h": 7,
      "w": 8,
      "x": 8,
      "y": 112
      },
      "id": 95,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_be_process_thread_num{namespace=~\"$namespace\", job=~\"metrics-starrocks-be.*\"}",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}",
      "refId": "A"
      }
      ],
      "title": "StarRocks BE Thread Num",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "各BE节点本地磁盘可用容量（百分比）。",
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
      "fillOpacity": 0,
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
      "unit": "percentunit"
      },
      "overrides": []
      },
      "gridPos": {
      "h": 7,
      "w": 8,
      "x": 16,
      "y": 112
      },
      "id": 149,
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
      "editorMode": "builder",
      "expr": "avg(starrocks_be_disks_avail_capacity/starrocks_be_disks_total_capacity{namespace=~\"$namespace\"}) by (instance)",
      "hide": false,
      "instant": false,
      "legendFormat": "{{instance}}",
      "range": true,
      "refId": "A"
      }
      ],
      "title": "StarRocks Disks Avail Capacity",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "BE的Base Compaction速率。右侧Y轴表示Base Compaction涉及数据的累计字节数。",
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
      "lineInterpolation": "stepAfter",
      "lineWidth": 0,
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
      "unit": "Bps"
      },
      "overrides": [
      {
      "matcher": {
      "id": "byRegexp",
      "options": "/Counter/"
      },
      "properties": [
      {
      "id": "custom.stacking",
      "value": {
      "group": "A",
      "mode": "normal"
      }
      },
      {
      "id": "unit",
      "value": "bytes"
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "Total"
      },
      "properties": [
      {
      "id": "color",
      "value": {
      "fixedColor": "rgb(27, 255, 0)",
      "mode": "fixed"
      }
      },
      {
      "id": "custom.fillOpacity",
      "value": 0
      },
      {
      "id": "custom.showPoints",
      "value": "always"
      },
      {
      "id": "unit",
      "value": "bytes"
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 5,
      "w": 12,
      "x": 0,
      "y": 119
      },
      "id": 39,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "max"
      ],
      "displayMode": "table",
      "placement": "right",
      "showLegend": true
      },
      "tooltip": {
      "mode": "multi",
      "sort": "none"
      }
      },
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "rate(starrocks_be_compaction_bytes_total{type=\"base\", namespace=~\"$namespace\"}[$interval])",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "sum(starrocks_be_compaction_bytes_total{type=\"base\", namespace=~\"$namespace\"})",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "Total",
      "refId": "B"
      }
      ],
      "title": "StarRocks BE Compaction Base",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "BE的数据行扫描速率。该参数表示处理查询请求时的数据行读取速率。",
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
      "fillOpacity": 0,
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
      "unit": "ops"
      },
      "overrides": [
      {
      "matcher": {
      "id": "byRegexp",
      "options": "/Counter/"
      },
      "properties": [
      {
      "id": "custom.stacking",
      "value": {
      "group": "A",
      "mode": "normal"
      }
      },
      {
      "id": "custom.axisPlacement",
      "value": "hidden"
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 5,
      "w": 12,
      "x": 12,
      "y": 119
      },
      "id": 44,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "mean"
      ],
      "displayMode": "table",
      "placement": "right",
      "showLegend": true
      },
      "tooltip": {
      "mode": "multi",
      "sort": "none"
      }
      },
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "rate(starrocks_be_query_scan_rows{namespace=~\"$namespace\"}[$interval])",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}",
      "refId": "A"
      }
      ],
      "title": "StarRocks BE Scan Rows",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "左侧Y轴表示保存在RocksDB中的tablet元数据的写入速率。右侧Y轴表示每次写入操作的持续时间。",
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
      "lineInterpolation": "stepAfter",
      "lineWidth": 0,
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
      "unit": "wps"
      },
      "overrides": [
      {
      "matcher": {
      "id": "byRegexp",
      "options": "/.*-latency/"
      },
      "properties": [
      {
      "id": "custom.fillOpacity",
      "value": 0
      },
      {
      "id": "custom.lineWidth",
      "value": 1
      },
      {
      "id": "unit",
      "value": "μs"
      },
      {
      "id": "custom.lineStyle",
      "value": {
      "dash": [
      10,
      10
      ],
      "fill": "dash"
      }
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 9,
      "w": 12,
      "x": 0,
      "y": 124
      },
      "id": 109,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "irate(starrocks_be_meta_request_total{namespace=~\"$namespace\", type=\"write\"}[$interval])",
      "format": "time_series",
      "hide": false,
      "intervalFactor": 1,
      "legendFormat": "{{instance}}-rate",
      "refId": "B"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_be_meta_request_duration{namespace=~\"$namespace\", type=\"write\"} / starrocks_be_meta_request_total{namespace=~\"$namespace\", type=\"write\"}",
      "format": "time_series",
      "hide": false,
      "intervalFactor": 1,
      "legendFormat": "{{instance}}-latency",
      "refId": "A"
      }
      ],
      "title": "StarRocks Tablet Meta Write",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "左侧Y轴表示读取RocksDB中的tablet元数据的速率。右侧Y轴表示每次读取操作的持续时间。",
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
      "lineInterpolation": "stepAfter",
      "lineWidth": 0,
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
      "unit": "wps"
      },
      "overrides": [
      {
      "matcher": {
      "id": "byRegexp",
      "options": "/.*-latency/"
      },
      "properties": [
      {
      "id": "custom.fillOpacity",
      "value": 0
      },
      {
      "id": "custom.lineWidth",
      "value": 1
      },
      {
      "id": "unit",
      "value": "μs"
      },
      {
      "id": "custom.lineStyle",
      "value": {
      "dash": [
      10,
      10
      ],
      "fill": "dash"
      }
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 9,
      "w": 12,
      "x": 12,
      "y": 124
      },
      "id": 110,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "irate(starrocks_be_meta_request_total{namespace=~\"$namespace\", type=\"read\"}[$interval])",
      "format": "time_series",
      "hide": false,
      "intervalFactor": 1,
      "legendFormat": "{{instance}}-rate",
      "refId": "B"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "starrocks_be_meta_request_duration{namespace=~\"$namespace\", type=\"read\"} / starrocks_be_meta_request_total{namespace=~\"$namespace\", type=\"read\"}",
      "format": "time_series",
      "hide": false,
      "intervalFactor": 1,
      "legendFormat": "{{instance}}-latency",
      "refId": "A"
      }
      ],
      "title": "StarRocks Tablet Meta Read",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "BE的数据量扫描速率。该参数表示处理查询请求时的数据读取速率。",
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
      "fillOpacity": 0,
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
      "overrides": [
      {
      "matcher": {
      "id": "byRegexp",
      "options": "/Counter/"
      },
      "properties": [
      {
      "id": "custom.stacking",
      "value": {
      "group": "A",
      "mode": "normal"
      }
      },
      {
      "id": "unit",
      "value": "ops"
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 5,
      "w": 12,
      "x": 0,
      "y": 133
      },
      "id": 43,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "mean"
      ],
      "displayMode": "table",
      "placement": "right",
      "showLegend": true
      },
      "tooltip": {
      "mode": "multi",
      "sort": "none"
      }
      },
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "rate(starrocks_be_query_scan_bytes{namespace=~\"$namespace\"}[$interval])",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "",
      "format": "time_series",
      "intervalFactor": 2,
      "refId": "B"
      }
      ],
      "title": "StarRocks BE Scan Bytes",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "BE的Cumulative Compaction速率。右Y轴表示累计的Cumulative Compaction数据字节数。",
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
      "lineInterpolation": "stepAfter",
      "lineWidth": 0,
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
      "unit": "Bps"
      },
      "overrides": [
      {
      "matcher": {
      "id": "byRegexp",
      "options": "/Counter/"
      },
      "properties": [
      {
      "id": "custom.stacking",
      "value": {
      "group": "A",
      "mode": "normal"
      }
      },
      {
      "id": "unit",
      "value": "bytes"
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "Total"
      },
      "properties": [
      {
      "id": "color",
      "value": {
      "fixedColor": "rgb(15, 255, 0)",
      "mode": "fixed"
      }
      },
      {
      "id": "custom.fillOpacity",
      "value": 0
      },
      {
      "id": "custom.showPoints",
      "value": "always"
      },
      {
      "id": "unit",
      "value": "bytes"
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 5,
      "w": 12,
      "x": 12,
      "y": 133
      },
      "id": 40,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "max"
      ],
      "displayMode": "table",
      "placement": "right",
      "showLegend": true
      },
      "tooltip": {
      "mode": "multi",
      "sort": "none"
      }
      },
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "rate(starrocks_be_compaction_bytes_total{type=\"cumulative\", namespace=~\"$namespace\"}[$interval])",
      "format": "time_series",
      "intervalFactor": 2,
      "legendFormat": "{{instance}}",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "SUM(starrocks_be_compaction_bytes_total{type=\"cumulative\", namespace=~\"$namespace\"})",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "Total",
      "refId": "B"
      }
      ],
      "title": "StarRocks BE Compaction Cumulate",
      "type": "timeseries"
      },
      {
      "collapsed": false,
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "gridPos": {
      "h": 1,
      "w": 24,
      "x": 0,
      "y": 138
      },
      "id": 75,
      "panels": [],
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "refId": "A"
      }
      ],
      "title": "BE tasks",
      "type": "row"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "左Y轴表示Tablets Report任务的失败率，通常应为0。右Y轴表示所有BE中Tablets Report任务的总数。备注：BE每60秒向FE汇报所有Tablet的信息，来让FE获取BE中Tablet的健康状态等信息。",
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
      "options": "Failed"
      },
      "properties": [
      {
      "id": "decimals",
      "value": 0
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "Total"
      },
      "properties": [
      {
      "id": "decimals",
      "value": 0
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 6,
      "w": 8,
      "x": 0,
      "y": 139
      },
      "id": 78,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull",
      "sum"
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "SUM(starrocks_be_engine_requests_total{namespace=~\"$namespace\", type=\"report_all_tablets\", status=\"total\"})",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "Total",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "irate(starrocks_be_engine_requests_total{namespace=~\"$namespace\", type=\"report_all_tablets\", status=\"failed\"}[$interval])",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}",
      "refId": "B"
      }
      ],
      "title": "StarRocks Tablets Report",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "左Y轴表示单独的Tablet Report任务的失败率，通常应为0。右Y轴表示所有BE中单独的Tablet Report任务的总数。备注：单独的Tablet上报任务包括Schema Change任务等。",
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
      "options": "Failed"
      },
      "properties": [
      {
      "id": "decimals",
      "value": 0
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "Total"
      },
      "properties": [
      {
      "id": "decimals",
      "value": 0
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 6,
      "w": 8,
      "x": 8,
      "y": 139
      },
      "id": 79,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull",
      "sum"
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "SUM(starrocks_be_engine_requests_total{namespace=~\"$namespace\", type=\"report_tablet\", status=\"total\"})",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "Total",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "irate(starrocks_be_engine_requests_total{namespace=~\"$namespace\", type=\"report_tablet\", status=\"failed\"}[$interval])",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}",
      "refId": "B"
      }
      ],
      "title": "StarRocks Single Tablet Report",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "左Y轴表示Task Report任务的失败率，通常应为0。右Y轴表示所有BE中完成上报任务的Tablet总数。",
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
      "options": "Failed"
      },
      "properties": [
      {
      "id": "decimals",
      "value": 0
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "Total"
      },
      "properties": [
      {
      "id": "decimals",
      "value": 0
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 6,
      "w": 8,
      "x": 16,
      "y": 139
      },
      "id": 82,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull",
      "sum"
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "SUM(starrocks_be_engine_requests_total{namespace=~\"$namespace\", type=\"finish_task\", status=\"total\"})",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "Total",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "irate(starrocks_be_engine_requests_total{namespace=~\"$namespace\", type=\"finish_task\", status=\"failed\"}[$interval])",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}",
      "refId": "B"
      }
      ],
      "title": "StarRocks Finish Task Report",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "左Y轴表示创建Schema Change任务的失败率，通常应为0。右Y轴表示所有BE中创建Schema Change时涉及Tablet的总数。",
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
      "options": "Failed"
      },
      "properties": [
      {
      "id": "decimals",
      "value": 0
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "Total"
      },
      "properties": [
      {
      "id": "decimals",
      "value": 0
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 6,
      "w": 8,
      "x": 0,
      "y": 145
      },
      "id": 76,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull",
      "sum"
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "editorMode": "code",
      "expr": "SUM(starrocks_be_engine_requests_total{namespace=~\"$namespace\", type=\"create_rollup\", status=\"total\"})",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "Total",
      "range": true,
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "irate(starrocks_be_engine_requests_total{namespace=~\"$namespace\", type=\"create_rollup\", status=\"failed\"}[$interval])",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}",
      "refId": "B"
      }
      ],
      "title": "StarRocks Schema Change",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "左Y轴表示创建Tablet任务的失败率，通常应为0。右Y轴表示所有BE中创建Tablet任务涉及的Tablet总数。",
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
      "options": "Failed"
      },
      "properties": [
      {
      "id": "decimals",
      "value": 0
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "Total"
      },
      "properties": [
      {
      "id": "decimals",
      "value": 0
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 6,
      "w": 8,
      "x": 8,
      "y": 145
      },
      "id": 73,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull",
      "sum"
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "SUM(starrocks_be_engine_requests_total{namespace=~\"$namespace\", type=\"create_tablet\", status=\"total\"})",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "Total",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "irate(starrocks_be_engine_requests_total{namespace=~\"$namespace\", type=\"create_tablet\", status=\"failed\"}[$interval])",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}",
      "refId": "B"
      }
      ],
      "title": "StarRocks Create Tablet",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "左Y轴表示Delete任务的失败率，通常应为0。右Y轴表示所有BE中Delete任务涉及的tablet总数。",
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
      "options": "Failed"
      },
      "properties": [
      {
      "id": "decimals",
      "value": 0
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "Total"
      },
      "properties": [
      {
      "id": "decimals",
      "value": 0
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 6,
      "w": 8,
      "x": 16,
      "y": 145
      },
      "id": 80,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull",
      "sum"
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "SUM(starrocks_be_engine_requests_total{namespace=~\"$namespace\", type=\"delete\", status=\"total\"})",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "Total",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "irate(starrocks_be_engine_requests_total{namespace=~\"$namespace\", type=\"delete\", status=\"failed\"}[$interval])",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}",
      "refId": "B"
      }
      ],
      "title": "StarRocks Delete",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "左Y轴表示Clone任务的失败率，通常应为0。右Y轴表示所有BE中Clone任务涉及的Tablet总数。",
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
      "options": "Failed"
      },
      "properties": [
      {
      "id": "decimals",
      "value": 0
      }
      ]
      },
      {
      "matcher": {
      "id": "byName",
      "options": "Total"
      },
      "properties": [
      {
      "id": "decimals",
      "value": 0
      }
      ]
      }
      ]
      },
      "gridPos": {
      "h": 6,
      "w": 8,
      "x": 0,
      "y": 151
      },
      "id": 81,
      "links": [],
      "options": {
      "legend": {
      "calcs": [
      "lastNotNull",
      "sum"
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "SUM(starrocks_be_engine_requests_total{namespace=~\"$namespace\", type=\"clone\", status=\"total\"})",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "Total",
      "refId": "A"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "expr": "irate(starrocks_be_engine_requests_total{namespace=~\"$namespace\", type=\"clone\", status=\"failed\"}[$interval])",
      "format": "time_series",
      "intervalFactor": 1,
      "legendFormat": "{{instance}}",
      "refId": "B"
      }
      ],
      "title": "StarRocks Clone",
      "type": "timeseries"
      },
      {
      "collapsed": false,
      "gridPos": {
      "h": 1,
      "w": 24,
      "x": 0,
      "y": 157
      },
      "id": 174,
      "panels": [],
      "title": "BE Memory",
      "type": "row"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "Jemalloc统计的内存使用， 是BE的实际使用内存（虚拟内存）。",
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
      "h": 8,
      "w": 12,
      "x": 0,
      "y": 158
      },
      "id": 170,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_jemalloc_allocated_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "Jemalloc Allocated Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "BE内部统计的内存使用，是BE的实际内存使用（虚拟内存），一般近似于starrocks_be_jemalloc_allocated_bytes。",
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
      "h": 8,
      "w": 12,
      "x": 12,
      "y": 158
      },
      "id": 171,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_process_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "Process Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "查询内存使用，查询内存上限不能配置，限制为: mem_limit * 90% * 90%。",
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
      "h": 7,
      "w": 12,
      "x": 0,
      "y": 166
      },
      "id": 175,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_query_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "Querying Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "导入内存使用，默认限制为mem_limit * 90% * 30%。",
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
      "h": 7,
      "w": 12,
      "x": 12,
      "y": 166
      },
      "id": 176,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_load_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "Loading Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "主键模型表使用的内存。",
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
      "h": 8,
      "w": 6,
      "x": 0,
      "y": 173
      },
      "id": 177,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_update_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "Primary Key Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "BE自有PageCache占用的内存。",
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
      "h": 8,
      "w": 6,
      "x": 6,
      "y": 173
      },
      "id": 151,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_storage_page_cache_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "Pagecache Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "BE用于内部Compaction机制的内存，一般在磁盘个数较多或是一次性导入大量数据，或是高频导入、列多、Unique表等场景下占用比较高。",
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
      "h": 8,
      "w": 6,
      "x": 12,
      "y": 173
      },
      "id": 152,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_compaction_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "Compaction Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "定期（一般为晚上11点）进行Consistency Check计算CheckSum使用的内存。",
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
      "h": 8,
      "w": 6,
      "x": 18,
      "y": 173
      },
      "id": 154,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_consistency_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "Consistency Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "用于Clone Tablet的内存，一般使用很少，可能会短暂出现小于0的时候。",
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
      "h": 8,
      "w": 6,
      "x": 0,
      "y": 181
      },
      "id": 178,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_clone_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "Replica Cloning Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "Schema Change内存使用，一般是在添加删除Key列或是修改数据类型时使用内存比较多。单个Schema Change任务的内存限制默认是2G。",
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
      "h": 8,
      "w": 6,
      "x": 6,
      "y": 181
      },
      "id": 167,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_schema_change_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "Schema Change Mem ",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "用于加速内存分配的Cache，默认上限是2G，小内存机器可以考虑关闭，关闭可能会影响部分查询的性能。",
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
      "h": 8,
      "w": 6,
      "x": 12,
      "y": 181
      },
      "id": 173,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_chunk_allocator_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "Chunk Allocator Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "BE元数据占用的内存，主要子级为column_metadata、tablet_metadata、rowset_metadata和segment_metadata。",
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
      "h": 8,
      "w": 6,
      "x": 18,
      "y": 181
      },
      "id": 155,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_metadata_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "BE Metadata Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "Bitmap索引占用的内存。",
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
      "h": 8,
      "w": 6,
      "x": 0,
      "y": 189
      },
      "id": 153,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_bitmap_index_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "Bitmap Index Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "Bloomfilter索引占用的内存。",
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
      "h": 8,
      "w": 6,
      "x": 6,
      "y": 189
      },
      "id": 160,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_bloom_filter_index_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "BloomFilter Index Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "Ordinal索引占用的内存。",
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
      "h": 8,
      "w": 6,
      "x": 12,
      "y": 189
      },
      "id": 159,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_ordinal_index_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "Ordinal Index Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "Shortkey前缀索引占用的内存。",
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
      "h": 8,
      "w": 6,
      "x": 18,
      "y": 189
      },
      "id": 158,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_short_key_index_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "Shortkey Index Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "BE元数据中列元数据占用的内存。",
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
      "h": 8,
      "w": 6,
      "x": 0,
      "y": 197
      },
      "id": 161,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_column_metadata_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "Column Metadata Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "列Zonemap索引占用的内存。",
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
      "h": 8,
      "w": 6,
      "x": 6,
      "y": 197
      },
      "id": 168,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_column_zonemap_index_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "Column Zonemap Index Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "用于加速内存分配的ColumnPool，当前没有上限，每10秒释放一半，可以优化查询性能, 小内存机器上可以关闭。",
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
      "h": 8,
      "w": 6,
      "x": 12,
      "y": 197
      },
      "id": 169,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_column_pool_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "Column Pool Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "BE元数据中Segment meta占用的内存。",
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
      "h": 8,
      "w": 6,
      "x": 18,
      "y": 197
      },
      "id": 162,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_segment_metadata_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "Segment Metadata Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "BE元数据中Rowset meta占用的内存。",
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
      "h": 8,
      "w": 6,
      "x": 0,
      "y": 205
      },
      "id": 156,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_rowset_metadata_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "Rowset Metadata Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "BE元数据中Tablet meta占用的内存。Compaction时，这些元数据会一直加载在内存中，若Compaction较慢可能会导致该项元数据占用较高。",
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
      "h": 8,
      "w": 6,
      "x": 6,
      "y": 205
      },
      "id": 172,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_tablet_metadata_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "Tablet Metadata Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "Tablet schema的内存占用。",
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
      "h": 8,
      "w": 6,
      "x": 12,
      "y": 205
      },
      "id": 150,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_tablet_schema_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "Tablet Schema Mem",
      "type": "timeseries"
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "description": "Segment Zonemap的内存占用。",
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
      "h": 8,
      "w": 6,
      "x": 18,
      "y": 205
      },
      "id": 166,
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
      "pluginVersion": "10.0.1",
      "targets": [
      {
      "exemplar": true,
      "expr": "starrocks_be_segment_zonemap_mem_bytes{namespace=~\"$namespace\"}",
      "interval": "",
      "intervalFactor": 2,
      "legendFormat": "{{ instance}}",
      "refId": "A"
      }
      ],
      "title": "Segment Zonemap Mem",
      "type": "timeseries"
      }
      ],
      "refresh": "",
      "schemaVersion": 38,
      "style": "dark",
      "tags": [],
      "templating": {
      "list": [
      {
      "current": {
      "selected": false,
      "text": "StarRocks_Cluster01",
      "value": "StarRocks_Cluster01"
      },
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
      "query": "label_values({pod=~\".*starrocks.*\",job!=\"kubelet\",job!=\"kube-state-metrics\"},namespace)",
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
      "current": {
      "selected": false,
      "text": "192.168.110.171:8035",
      "value": "192.168.110.171:8035"
      },
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "definition": "",
      "hide": 0,
      "includeAll": false,
      "multi": false,
      "name": "fe_master",
      "options": [],
      "query": {
      "query": "query_result(node_info{job=~\"metrics-starrocks-fe.*\", type=\"is_master\"})",
      "refId": "Prometheus-fe_master-Variable-Query"
      },
      "refresh": 1,
      "regex": "/instance=\"(.+:\\d+)\"/",
      "skipUrlSync": false,
      "sort": 0,
      "tagValuesQuery": "",
      "tagsQuery": "",
      "type": "query",
      "useTags": false
      },
      {
      "current": {
      "selected": false,
      "text": "192.168.110.170:8035",
      "value": "192.168.110.170:8035"
      },
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "definition": "",
      "hide": 0,
      "includeAll": false,
      "multi": false,
      "name": "fe_instance",
      "options": [],
      "query": {
      "query": "up{job=~\"metrics-starrocks-fe.*\",}",
      "refId": "Prometheus-fe_instance-Variable-Query"
      },
      "refresh": 1,
      "regex": "/instance=\"(.+:\\d+)/",
      "skipUrlSync": false,
      "sort": 1,
      "tagValuesQuery": "",
      "tagsQuery": "",
      "type": "query",
      "useTags": false
      },
      {
      "current": {
      "selected": false,
      "text": "192.168.110.170:8045",
      "value": "192.168.110.170:8045"
      },
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "definition": "",
      "hide": 0,
      "includeAll": false,
      "multi": false,
      "name": "be_instance",
      "options": [],
      "query": {
      "query": "up{job=~\"metrics-starrocks-be.*\"}",
      "refId": "Prometheus-be_instance-Variable-Query"
      },
      "refresh": 1,
      "regex": "/instance=\"(.+:\\d+)/",
      "skipUrlSync": false,
      "sort": 0,
      "tagValuesQuery": "",
      "tagsQuery": "",
      "type": "query",
      "useTags": false
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
      },
      {
      "datasource": {
        "type": "prometheus",
        "uid": "prometheus"
         },
      "filters": [],
      "hide": 0,
      "name": "Filters",
      "skipUrlSync": false,
      "type": "adhoc"
      }
      ]
      },
      "time": {
      "from": "now-1h",
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
      "timezone": "",
      "title": "StarRocks Overview",
      "uid": "starrocks001",
      "version": 1,
      "weekStart": ""
    }
    </#noparse>
