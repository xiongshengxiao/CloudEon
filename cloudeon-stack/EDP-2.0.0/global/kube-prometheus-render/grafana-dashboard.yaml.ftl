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
    {
      "annotations": {
        "list": [
          {
            "builtIn": 1,
            "datasource": "-- Grafana --",
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
      "iteration": 1693214822801,
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
          "id": 5,
          "panels": [],
          "title": "CPU Usage",
          "type": "row"
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "uid": "$datasource"
          },
          "fill": 10,
          "fillGradient": 0,
          "gridPos": {
            "h": 7,
            "w": 24,
            "x": 0,
            "y": 1
          },
          "hiddenSeries": false,
          "id": 1,
          "interval": "1m",
          "legend": {
            "alignAsTable": true,
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 0,
          "links": [],
          "nullPointMode": "null as zero",
          "options": {
            "alertThreshold": true
          },
          "percentage": false,
          "pluginVersion": "8.3.3",
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [
            {
              "alias": "max capacity",
              "color": "#F2495C",
              "dashes": true,
              "fill": 0,
              "hiddenSeries": true,
              "hideTooltip": true,
              "legend": true,
              "linewidth": 2,
              "stack": false
            }
          ],
          "spaceLength": 10,
          "stack": true,
          "steppedLine": false,
          "targets": [
            {
              "expr": "sum(kube_node_status_capacity{cluster=\"$cluster\", node=~\"$node\", resource=\"cpu\"})",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "max capacity",
              "refId": "A",
              "step": 10
            },
            {
              "expr": "sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster=\"$cluster\", node=~\"$node\"}) by (pod)",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "{{pod}}",
              "refId": "B",
              "step": 10
            }
          ],
          "thresholds": [],
          "timeRegions": [],
          "title": "CPU Usage",
          "tooltip": {
            "shared": false,
            "sort": 2,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "logBase": 1,
              "min": 0,
              "show": true
            },
            {
              "format": "short",
              "logBase": 1,
              "show": false
            }
          ],
          "yaxis": {
            "align": false
          }
        },
        {
          "collapsed": false,
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 8
          },
          "id": 6,
          "panels": [],
          "title": "CPU Quota",
          "type": "row"
        },
        {
          "aliasColors": {},
          "bars": false,
          "columns": [],
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "uid": "$datasource"
          },
          "fill": 1,
          "fontSize": "100%",
          "gridPos": {
            "h": 7,
            "w": 24,
            "x": 0,
            "y": 9
          },
          "id": 2,
          "interval": "1m",
          "legend": {
            "alignAsTable": true,
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null as zero",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "showHeader": true,
          "sort": {
            "col": 0,
            "desc": true
          },
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "styles": [
            {
              "alias": "Time",
              "align": "auto",
              "dateFormat": "YYYY-MM-DD HH:mm:ss",
              "pattern": "Time",
              "type": "hidden"
            },
            {
              "alias": "CPU Usage",
              "align": "auto",
              "colors": [],
              "dateFormat": "YYYY-MM-DD HH:mm:ss",
              "decimals": 2,
              "link": false,
              "linkTargetBlank": false,
              "linkTooltip": "Drill down",
              "linkUrl": "",
              "pattern": "Value #A",
              "thresholds": [],
              "type": "number",
              "unit": "short"
            },
            {
              "alias": "CPU Requests",
              "align": "auto",
              "colors": [],
              "dateFormat": "YYYY-MM-DD HH:mm:ss",
              "decimals": 2,
              "link": false,
              "linkTargetBlank": false,
              "linkTooltip": "Drill down",
              "linkUrl": "",
              "pattern": "Value #B",
              "thresholds": [],
              "type": "number",
              "unit": "short"
            },
            {
              "alias": "CPU Requests %",
              "align": "auto",
              "colors": [],
              "dateFormat": "YYYY-MM-DD HH:mm:ss",
              "decimals": 2,
              "link": false,
              "linkTargetBlank": false,
              "linkTooltip": "Drill down",
              "linkUrl": "",
              "pattern": "Value #C",
              "thresholds": [],
              "type": "number",
              "unit": "percentunit"
            },
            {
              "alias": "CPU Limits",
              "align": "auto",
              "colors": [],
              "dateFormat": "YYYY-MM-DD HH:mm:ss",
              "decimals": 2,
              "link": false,
              "linkTargetBlank": false,
              "linkTooltip": "Drill down",
              "linkUrl": "",
              "pattern": "Value #D",
              "thresholds": [],
              "type": "number",
              "unit": "short"
            },
            {
              "alias": "CPU Limits %",
              "align": "auto",
              "colors": [],
              "dateFormat": "YYYY-MM-DD HH:mm:ss",
              "decimals": 2,
              "link": false,
              "linkTargetBlank": false,
              "linkTooltip": "Drill down",
              "linkUrl": "",
              "pattern": "Value #E",
              "thresholds": [],
              "type": "number",
              "unit": "percentunit"
            },
            {
              "alias": "Pod",
              "align": "auto",
              "colors": [],
              "dateFormat": "YYYY-MM-DD HH:mm:ss",
              "decimals": 2,
              "link": false,
              "linkTargetBlank": false,
              "linkTooltip": "Drill down",
              "linkUrl": "",
              "pattern": "pod",
              "thresholds": [],
              "type": "number",
              "unit": "short"
            },
            {
              "alias": "",
              "align": "auto",
              "colors": [],
              "dateFormat": "YYYY-MM-DD HH:mm:ss",
              "decimals": 2,
              "pattern": "/.*/",
              "thresholds": [],
              "type": "string",
              "unit": "short"
            }
          ],
          "targets": [
            {
              "expr": "sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster=\"$cluster\", node=~\"$node\"}) by (pod)",
              "format": "table",
              "instant": true,
              "intervalFactor": 2,
              "legendFormat": "",
              "refId": "A",
              "step": 10
            },
            {
              "expr": "sum(cluster:namespace:pod_cpu:active:kube_pod_container_resource_requests{cluster=\"$cluster\", node=~\"$node\"}) by (pod)",
              "format": "table",
              "instant": true,
              "intervalFactor": 2,
              "legendFormat": "",
              "refId": "B",
              "step": 10
            },
            {
              "expr": "sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster=\"$cluster\", node=~\"$node\"}) by (pod) / sum(cluster:namespace:pod_cpu:active:kube_pod_container_resource_requests{cluster=\"$cluster\", node=~\"$node\"}) by (pod)",
              "format": "table",
              "instant": true,
              "intervalFactor": 2,
              "legendFormat": "",
              "refId": "C",
              "step": 10
            },
            {
              "expr": "sum(cluster:namespace:pod_cpu:active:kube_pod_container_resource_limits{cluster=\"$cluster\", node=~\"$node\"}) by (pod)",
              "format": "table",
              "instant": true,
              "intervalFactor": 2,
              "legendFormat": "",
              "refId": "D",
              "step": 10
            },
            {
              "expr": "sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster=\"$cluster\", node=~\"$node\"}) by (pod) / sum(cluster:namespace:pod_cpu:active:kube_pod_container_resource_limits{cluster=\"$cluster\", node=~\"$node\"}) by (pod)",
              "format": "table",
              "instant": true,
              "intervalFactor": 2,
              "legendFormat": "",
              "refId": "E",
              "step": 10
            }
          ],
          "thresholds": [],
          "title": "CPU Quota",
          "tooltip": {
            "shared": false,
            "sort": 2,
            "value_type": "individual"
          },
          "transform": "table",
          "type": "table-old",
          "xaxis": {
            "mode": "time",
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "logBase": 1,
              "min": 0,
              "show": true
            },
            {
              "format": "short",
              "logBase": 1,
              "show": false
            }
          ]
        },
        {
          "collapsed": false,
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 16
          },
          "id": 7,
          "panels": [],
          "title": "Memory Usage",
          "type": "row"
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "uid": "$datasource"
          },
          "fill": 10,
          "fillGradient": 0,
          "gridPos": {
            "h": 7,
            "w": 24,
            "x": 0,
            "y": 17
          },
          "hiddenSeries": false,
          "id": 3,
          "interval": "1m",
          "legend": {
            "alignAsTable": true,
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 0,
          "links": [],
          "nullPointMode": "null as zero",
          "options": {
            "alertThreshold": true
          },
          "percentage": false,
          "pluginVersion": "8.3.3",
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [
            {
              "alias": "max capacity",
              "color": "#F2495C",
              "dashes": true,
              "fill": 0,
              "hiddenSeries": true,
              "hideTooltip": true,
              "legend": true,
              "linewidth": 2,
              "stack": false
            }
          ],
          "spaceLength": 10,
          "stack": true,
          "steppedLine": false,
          "targets": [
            {
              "expr": "sum(kube_node_status_capacity{cluster=\"$cluster\", node=~\"$node\", resource=\"memory\"})",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "max capacity",
              "refId": "A",
              "step": 10
            },
            {
              "expr": "sum(node_namespace_pod_container:container_memory_working_set_bytes{cluster=\"$cluster\", node=~\"$node\", container!=\"\"}) by (pod)",
              "format": "time_series",
              "intervalFactor": 2,
              "legendFormat": "{{pod}}",
              "refId": "B",
              "step": 10
            }
          ],
          "thresholds": [],
          "timeRegions": [],
          "title": "Memory Usage (w/o cache)",
          "tooltip": {
            "shared": false,
            "sort": 2,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "bytes",
              "logBase": 1,
              "min": 0,
              "show": true
            },
            {
              "format": "short",
              "logBase": 1,
              "show": false
            }
          ],
          "yaxis": {
            "align": false
          }
        },
        {
          "collapsed": false,
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 24
          },
          "id": 8,
          "panels": [],
          "title": "Memory Quota",
          "type": "row"
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": {
            "uid": "$datasource"
          },
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 24,
            "x": 0,
            "y": 25
          },
          "id": 4,
          "interval": "1m",
          "legend": {
            "alignAsTable": true,
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "rightSide": true,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "null as zero",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "styles": [
            {
              "alias": "Time",
              "align": "auto",
              "dateFormat": "YYYY-MM-DD HH:mm:ss",
              "pattern": "Time",
              "type": "hidden"
            },
            {
              "alias": "Memory Usage",
              "align": "auto",
              "colors": [],
              "dateFormat": "YYYY-MM-DD HH:mm:ss",
              "decimals": 2,
              "link": false,
              "linkTargetBlank": false,
              "linkTooltip": "Drill down",
              "linkUrl": "",
              "pattern": "Value #A",
              "thresholds": [],
              "type": "number",
              "unit": "bytes"
            },
            {
              "alias": "Memory Requests",
              "align": "auto",
              "colors": [],
              "dateFormat": "YYYY-MM-DD HH:mm:ss",
              "decimals": 2,
              "link": false,
              "linkTargetBlank": false,
              "linkTooltip": "Drill down",
              "linkUrl": "",
              "pattern": "Value #B",
              "thresholds": [],
              "type": "number",
              "unit": "bytes"
            },
            {
              "alias": "Memory Requests %",
              "align": "auto",
              "colors": [],
              "dateFormat": "YYYY-MM-DD HH:mm:ss",
              "decimals": 2,
              "link": false,
              "linkTargetBlank": false,
              "linkTooltip": "Drill down",
              "linkUrl": "",
              "pattern": "Value #C",
              "thresholds": [],
              "type": "number",
              "unit": "percentunit"
            },
            {
              "alias": "Memory Limits",
              "align": "auto",
              "colors": [],
              "dateFormat": "YYYY-MM-DD HH:mm:ss",
              "decimals": 2,
              "link": false,
              "linkTargetBlank": false,
              "linkTooltip": "Drill down",
              "linkUrl": "",
              "pattern": "Value #D",
              "thresholds": [],
              "type": "number",
              "unit": "bytes"
            },
            {
              "alias": "Memory Limits %",
              "align": "auto",
              "colors": [],
              "dateFormat": "YYYY-MM-DD HH:mm:ss",
              "decimals": 2,
              "link": false,
              "linkTargetBlank": false,
              "linkTooltip": "Drill down",
              "linkUrl": "",
              "pattern": "Value #E",
              "thresholds": [],
              "type": "number",
              "unit": "percentunit"
            },
            {
              "alias": "Memory Usage (RSS)",
              "align": "auto",
              "colors": [],
              "dateFormat": "YYYY-MM-DD HH:mm:ss",
              "decimals": 2,
              "link": false,
              "linkTargetBlank": false,
              "linkTooltip": "Drill down",
              "linkUrl": "",
              "pattern": "Value #F",
              "thresholds": [],
              "type": "number",
              "unit": "bytes"
            },
            {
              "alias": "Memory Usage (Cache)",
              "align": "auto",
              "colors": [],
              "dateFormat": "YYYY-MM-DD HH:mm:ss",
              "decimals": 2,
              "link": false,
              "linkTargetBlank": false,
              "linkTooltip": "Drill down",
              "linkUrl": "",
              "pattern": "Value #G",
              "thresholds": [],
              "type": "number",
              "unit": "bytes"
            },
            {
              "alias": "Memory Usage (Swap)",
              "align": "auto",
              "colors": [],
              "dateFormat": "YYYY-MM-DD HH:mm:ss",
              "decimals": 2,
              "link": false,
              "linkTargetBlank": false,
              "linkTooltip": "Drill down",
              "linkUrl": "",
              "pattern": "Value #H",
              "thresholds": [],
              "type": "number",
              "unit": "bytes"
            },
            {
              "alias": "Pod",
              "align": "auto",
              "colors": [],
              "dateFormat": "YYYY-MM-DD HH:mm:ss",
              "decimals": 2,
              "link": false,
              "linkTargetBlank": false,
              "linkTooltip": "Drill down",
              "linkUrl": "",
              "pattern": "pod",
              "thresholds": [],
              "type": "number",
              "unit": "short"
            },
            {
              "alias": "",
              "align": "auto",
              "colors": [],
              "dateFormat": "YYYY-MM-DD HH:mm:ss",
              "decimals": 2,
              "pattern": "/.*/",
              "thresholds": [],
              "type": "string",
              "unit": "short"
            }
          ],
          "targets": [
            {
              "expr": "sum(node_namespace_pod_container:container_memory_working_set_bytes{cluster=\"$cluster\", node=~\"$node\",container!=\"\"}) by (pod)",
              "format": "table",
              "instant": true,
              "intervalFactor": 2,
              "legendFormat": "",
              "refId": "A",
              "step": 10
            },
            {
              "expr": "sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_requests{cluster=\"$cluster\", node=~\"$node\"}) by (pod)",
              "format": "table",
              "instant": true,
              "intervalFactor": 2,
              "legendFormat": "",
              "refId": "B",
              "step": 10
            },
            {
              "expr": "sum(node_namespace_pod_container:container_memory_working_set_bytes{cluster=\"$cluster\", node=~\"$node\",container!=\"\"}) by (pod) / sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_requests{cluster=\"$cluster\", node=~\"$node\"}) by (pod)",
              "format": "table",
              "instant": true,
              "intervalFactor": 2,
              "legendFormat": "",
              "refId": "C",
              "step": 10
            },
            {
              "expr": "sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_limits{cluster=\"$cluster\", node=~\"$node\"}) by (pod)",
              "format": "table",
              "instant": true,
              "intervalFactor": 2,
              "legendFormat": "",
              "refId": "D",
              "step": 10
            },
            {
              "expr": "sum(node_namespace_pod_container:container_memory_working_set_bytes{cluster=\"$cluster\", node=~\"$node\",container!=\"\"}) by (pod) / sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_limits{cluster=\"$cluster\", node=~\"$node\"}) by (pod)",
              "format": "table",
              "instant": true,
              "intervalFactor": 2,
              "legendFormat": "",
              "refId": "E",
              "step": 10
            },
            {
              "expr": "sum(node_namespace_pod_container:container_memory_rss{cluster=\"$cluster\", node=~\"$node\",container!=\"\"}) by (pod)",
              "format": "table",
              "instant": true,
              "intervalFactor": 2,
              "legendFormat": "",
              "refId": "F",
              "step": 10
            },
            {
              "expr": "sum(node_namespace_pod_container:container_memory_cache{cluster=\"$cluster\", node=~\"$node\",container!=\"\"}) by (pod)",
              "format": "table",
              "instant": true,
              "intervalFactor": 2,
              "legendFormat": "",
              "refId": "G",
              "step": 10
            },
            {
              "expr": "sum(node_namespace_pod_container:container_memory_swap{cluster=\"$cluster\", node=~\"$node\",container!=\"\"}) by (pod)",
              "format": "table",
              "instant": true,
              "intervalFactor": 2,
              "legendFormat": "",
              "refId": "H",
              "step": 10
            }
          ],
          "thresholds": [],
          "title": "Memory Quota",
          "tooltip": {
            "shared": false,
            "sort": 2,
            "value_type": "individual"
          },
          "transform": "table",
          "type": "table-old",
          "xaxis": {
            "mode": "time",
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "logBase": 1,
              "min": 0,
              "show": true
            },
            {
              "format": "short",
              "logBase": 1,
              "show": false
            }
          ]
        }
      ],
      "refresh": "10s",
      "schemaVersion": 34,
      "style": "dark",
      "tags": [
        "kubernetes-mixin"
      ],
      "templating": {
        "list": [
          {
            "current": {
              "selected": false,
              "text": "prometheus",
              "value": "prometheus"
            },
            "hide": 0,
            "includeAll": false,
            "label": "Data Source",
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
            "current": {
              "isNone": true,
              "selected": false,
              "text": "None",
              "value": ""
            },
            "datasource": {
              "uid": "$datasource"
            },
            "definition": "",
            "hide": 2,
            "includeAll": false,
            "multi": false,
            "name": "cluster",
            "options": [],
            "query": {
              "query": "label_values(up{job=\"kube-state-metrics\"}, cluster)",
              "refId": "prometheus-cluster-Variable-Query"
            },
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
            "current": {},
            "datasource": {
              "uid": "$datasource"
            },
            "definition": "",
            "hide": 0,
            "includeAll": false,
            "multi": true,
            "name": "node",
            "options": [],
            "query": {
              "query": "label_values(kube_node_info{cluster=\"$cluster\"}, node)",
              "refId": "prometheus-node-Variable-Query"
            },
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
      "timezone": "Asia/Shanghai",
      "uid": "global001",
      "title": "My Node Compute Resources ",
      "version": 1,
      "weekStart": ""
    }