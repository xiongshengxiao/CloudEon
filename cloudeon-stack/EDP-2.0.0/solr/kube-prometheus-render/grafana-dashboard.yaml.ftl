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
      "__inputs": [],
      "__requires": [
        {
          "type": "panel",
          "id": "gauge",
          "name": "Gauge",
          "version": ""
        },
        {
          "type": "grafana",
          "id": "grafana",
          "name": "Grafana",
          "version": "7.3.0"
        },
        {
          "type": "panel",
          "id": "graph",
          "name": "Graph",
          "version": ""
        },
        {
          "type": "datasource",
          "id": "prometheus",
          "name": "Prometheus",
          "version": "1.0.0"
        },
        {
          "type": "panel",
          "id": "stat",
          "name": "Stat",
          "version": ""
        }
      ],
      "annotations": {
        "list": [
          {
            "builtIn": 1,
            "datasource": "-- Grafana --",
            "enable": true,
            "hide": true,
            "iconColor": "rgba(0, 211, 255, 1)",
            "name": "Annotations & Alerts",
            "type": "dashboard"
          }
        ]
      },
      "description": "Default dashboard for Solr Exporter",
      "editable": true,
      "gnetId": 12456,
      "graphTooltip": 0,
      "id": null,
      "iteration": 1619091548109,
      "links": [
        {
          "icon": "external link",
          "tags": [],
          "title": "Solr project",
          "type": "link",
          "url": "https://solr.apache.org/"
        },
        {
          "icon": "external link",
          "tags": [],
          "title": "Solr Prometheus documentation",
          "type": "link",
          "url": "https://solr.apache.org/guide/monitoring-solr-with-prometheus-and-grafana.html"
        }
      ],
      "panels": [
        {
          "collapsed": false,
          "datasource": "$DS_PROMETHEUS",
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 0
          },
          "id": 64,
          "panels": [],
          "title": "Solr Cluster",
          "type": "row"
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": "$DS_PROMETHEUS",
          "fieldConfig": {
            "defaults": {
              "custom": {
                "align": null,
                "filterable": false
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
          "fill": 0,
          "fillGradient": 0,
          "gridPos": {
            "h": 8,
            "w": 6,
            "x": 0,
            "y": 1
          },
          "hiddenSeries": false,
          "id": 62,
          "legend": {
            "alignAsTable": false,
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 2,
          "nullPointMode": "null",
          "options": {
            "alertThreshold": true
          },
          "percentage": false,
          "pluginVersion": "7.3.0",
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [
            {
              "alias": "Total nodes",
              "lines": true
            },
            {
              "alias": "Live nodes",
              "bars": true,
              "color": "#37872D",
              "lines": false
            }
          ],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "solr_collections_live_nodes",
              "format": "time_series",
              "instant": false,
              "interval": "",
              "legendFormat": "Live nodes",
              "refId": "A"
            },
            {
              "expr": "count(count by (node_name) (solr_collections_replica_state)) < solr_collections_live_nodes or solr_collections_live_nodes",
              "hide": false,
              "interval": "",
              "intervalFactor": 1,
              "legendFormat": "Total nodes",
              "refId": "B"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "Number of live nodes",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "decimals": 0,
              "format": "short",
              "label": "",
              "logBase": 1,
              "max": null,
              "min": "0",
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": "Prometheus",
          "description": "",
          "fieldConfig": {
            "defaults": {
              "unit": "short"
            },
            "overrides": []
          },
          "fill": 0,
          "fillGradient": 0,
          "gridPos": {
            "h": 8,
            "w": 6,
            "x": 6,
            "y": 1
          },
          "hiddenSeries": false,
          "id": 221,
          "legend": {
            "alignAsTable": false,
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 2,
          "nullPointMode": "null",
          "options": {
            "alertThreshold": true
          },
          "percentage": false,
          "pluginVersion": "7.5.4",
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [
            {
              "$$hashKey": "object:395",
              "alias": "Ensemble size",
              "lines": true
            },
            {
              "$$hashKey": "object:396",
              "alias": "Healthy nodes",
              "bars": true,
              "color": "#5794F2",
              "lines": false
            }
          ],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "count(solr_zookeeper_nodestatus == 1)",
              "format": "time_series",
              "instant": false,
              "interval": "",
              "legendFormat": "Healthy nodes",
              "refId": "A"
            },
            {
              "expr": "solr_zookeeper_ensemble_size",
              "hide": false,
              "interval": "",
              "intervalFactor": 1,
              "legendFormat": "Ensemble size",
              "refId": "B"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "Zookeepers",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "$$hashKey": "object:413",
              "decimals": 0,
              "format": "short",
              "label": "",
              "logBase": 1,
              "max": null,
              "min": "0",
              "show": true
            },
            {
              "$$hashKey": "object:414",
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": true,
          "dashLength": 10,
          "dashes": false,
          "datasource": "$DS_PROMETHEUS",
          "fieldConfig": {
            "defaults": {
              "custom": {}
            },
            "overrides": []
          },
          "fill": 0,
          "fillGradient": 0,
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 1
          },
          "hiddenSeries": false,
          "id": 68,
          "legend": {
            "avg": false,
            "current": false,
            "hideEmpty": true,
            "hideZero": true,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": false,
          "linewidth": 1,
          "nullPointMode": "null",
          "options": {
            "alertThreshold": true
          },
          "percentage": false,
          "pluginVersion": "7.3.0",
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": true,
          "steppedLine": false,
          "targets": [
            {
              "expr": "solr_collections_shard_leader{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}",
              "interval": "",
              "legendFormat": "{{collection}} {{shard}} {{replica}} ({{node_name}})",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "Shard leaders",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "transformations": [],
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "decimals": 0,
              "format": "short",
              "label": "Leaders",
              "logBase": 1,
              "max": null,
              "min": "0",
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "datasource": "$DS_PROMETHEUS",
          "description": "",
          "fieldConfig": {
            "defaults": {
              "custom": {},
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
            "w": 3,
            "x": 0,
            "y": 9
          },
          "id": 74,
          "options": {
            "colorMode": "value",
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "auto",
            "reduceOptions": {
              "calcs": [
                "lastNotNull"
              ],
              "fields": "",
              "values": false
            },
            "textMode": "auto"
          },
          "pluginVersion": "7.3.0",
          "targets": [
            {
              "expr": "count(count by (collection) (solr_collections_replica_state{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}))",
              "interval": "",
              "legendFormat": "",
              "refId": "A"
            }
          ],
          "timeFrom": null,
          "timeShift": null,
          "title": "Number of collections",
          "type": "stat"
        },
        {
          "datasource": "$DS_PROMETHEUS",
          "description": "",
          "fieldConfig": {
            "defaults": {
              "custom": {},
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
            "w": 9,
            "x": 3,
            "y": 9
          },
          "id": 70,
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
          "pluginVersion": "7.3.0",
          "targets": [
            {
              "expr": "count(solr_collections_replica_state{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"})",
              "interval": "",
              "legendFormat": "Total replicas",
              "refId": "B"
            },
            {
              "expr": "count(solr_collections_replica_state{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"} == 1) OR on() vector(0)",
              "interval": "",
              "legendFormat": "Active",
              "refId": "D"
            },
            {
              "expr": "count(solr_collections_replica_state{state=\"down\",base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}) OR on() vector(0)",
              "interval": "",
              "legendFormat": "Down",
              "refId": "A"
            },
            {
              "expr": "count(solr_collections_replica_state{state=\"recovering\",base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}) OR on() vector(0)",
              "interval": "",
              "legendFormat": "Recovering",
              "refId": "C"
            },
            {
              "expr": "count(solr_collections_replica_state{state=\"recovery_failed\",base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}) OR on() vector(0)",
              "interval": "",
              "legendFormat": "Recovery failed",
              "refId": "E"
            }
          ],
          "timeFrom": null,
          "timeShift": null,
          "title": "Current replica state",
          "type": "gauge"
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": "$DS_PROMETHEUS",
          "fieldConfig": {
            "defaults": {
              "custom": {
                "align": null,
                "filterable": false
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
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 9
          },
          "hiddenSeries": false,
          "id": 72,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 1,
          "nullPointMode": "null",
          "options": {
            "alertThreshold": true
          },
          "percentage": false,
          "pluginVersion": "7.3.0",
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": true,
          "steppedLine": false,
          "targets": [
            {
              "expr": "1 - solr_collections_replica_state{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}",
              "interval": "",
              "legendFormat": "{{collection}} {{shard}} {{replica}} ({{node_name}})={{state}}",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "Replica state history",
          "description": "Active replicas have value 0. Non-active replicas will show stacked in the graph.",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "decimals": 0,
              "format": "short",
              "label": "Non-active states",
              "logBase": 1,
              "max": null,
              "min": 0,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "collapsed": true,
          "datasource": "$DS_PROMETHEUS",
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 17
          },
          "id": 211,
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "description": "Distributed QPS 1-min rate  aggregated by collection, roughly the current QPS across all nodes per collection",
              "fieldConfig": {
                "defaults": {
                  "custom": {},
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
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 8,
                "x": 0,
                "y": 18
              },
              "hiddenSeries": false,
              "id": 201,
              "legend": {
                "avg": false,
                "current": true,
                "hideEmpty": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "nullPointMode": "connected",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 2,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "sum by (collection) (solr_metrics_core_query_1minRate{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\",searchHandler=~\"$searchHandler\"})",
                  "interval": "",
                  "legendFormat": "{{collection}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Total QPS (by collection)",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "qps",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "description": "Distributed QPS 1-min rate aggregated by base_url (Solr node)",
              "fieldConfig": {
                "defaults": {
                  "custom": {},
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
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 8,
                "x": 8,
                "y": 18
              },
              "hiddenSeries": false,
              "id": 202,
              "legend": {
                "avg": false,
                "current": true,
                "hideEmpty": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 2,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "sum by (base_url) (solr_metrics_core_query_1minRate{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\",searchHandler=~\"$searchHandler\"})",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}",
                  "refId": "A"
                }
              ],
              "thresholds": [
                {
                  "colorMode": "critical",
                  "fill": true,
                  "line": true,
                  "op": "gt",
                  "yaxis": "left"
                }
              ],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Total QPS (by node)",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 8,
                "x": 16,
                "y": 18
              },
              "hiddenSeries": false,
              "id": 206,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": true,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "connected",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_core_query_p95_ms{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\",searchHandler=~\"$searchHandler\"}",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}  {{core}}  {{searchHandler}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Distributed Query Time per Core (p95 ms)",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 8,
                "x": 0,
                "y": 25
              },
              "hiddenSeries": false,
              "id": 204,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": true,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_core_query_5minRate{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\",searchHandler=~\"$searchHandler\"}",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}  {{core}}  {{searchHandler}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Distributed QPS per Core (5-min rate)",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 8,
                "x": 8,
                "y": 25
              },
              "hiddenSeries": false,
              "id": 205,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": true,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "connected",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_core_query_p99_ms{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\",searchHandler=~\"$searchHandler\"}",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}  {{core}}  {{searchHandler}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Distributed Query Time per Core (p99 ms)",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "ms",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 8,
                "x": 16,
                "y": 25
              },
              "hiddenSeries": false,
              "id": 203,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": true,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_core_query_1minRate{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\",searchHandler=~\"$searchHandler\"}",
                  "format": "time_series",
                  "instant": false,
                  "interval": "",
                  "intervalFactor": 3,
                  "legendFormat": "{{base_url}}  {{core}}  {{searchHandler}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Distributed QPS per Core (1-min rate)",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "qps",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 8,
                "x": 0,
                "y": 32
              },
              "hiddenSeries": false,
              "id": 207,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": true,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "connected",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_core_query_p75_ms{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\",searchHandler=~\"$searchHandler\"}",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}  {{core}}  {{searchHandler}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Distributed Query Time per Core (p75 ms)",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "description": "Helps identify if a core is receiving more traffic than other cores, possibly indicating unbalanced load.",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 8,
                "x": 8,
                "y": 32
              },
              "hiddenSeries": false,
              "id": 218,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": true,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "connected",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_core_query_local_count{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\",searchHandler=~\"$searchHandler\"}[1m])",
                  "format": "time_series",
                  "instant": false,
                  "interval": "",
                  "intervalFactor": 3,
                  "legendFormat": "{{base_url}}/{{core}}{{searchHandler}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Local Query Count per Core",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "qps",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 8,
                "x": 16,
                "y": 32
              },
              "hiddenSeries": false,
              "id": 219,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": true,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "connected",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_core_query_local_1minRate{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\",searchHandler=~\"$searchHandler\"}",
                  "format": "time_series",
                  "instant": false,
                  "interval": "",
                  "intervalFactor": 3,
                  "legendFormat": "{{base_url}}/{{core}}{{searchHandler}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Local QPS per Core (1-min rate)",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "qps",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 8,
                "x": 0,
                "y": 39
              },
              "hiddenSeries": false,
              "id": 217,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": true,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "connected",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_core_query_local_p95_ms{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\",searchHandler=~\"$searchHandler\"}",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 3,
                  "legendFormat": "{{base_url}}/{{core}}{{searchHandler}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Local Query Time per Core (p95 ms)",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 8,
                "x": 8,
                "y": 39
              },
              "hiddenSeries": false,
              "id": 210,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": true,
                "hideEmpty": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_core_query_client_errors_1minRate{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\",searchHandler=~\"$searchHandler\"}",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}  {{core}}  {{searchHandler}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Query Client Errors per Core (1-min rate)",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 8,
                "x": 16,
                "y": 39
              },
              "hiddenSeries": false,
              "id": 209,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": true,
                "hideEmpty": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_core_query_errors_1minRate{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\",searchHandler=~\"$searchHandler\"}",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}  {{core}}  {{searchHandler}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Query Errors per Core (1-min rate)",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            }
          ],
          "repeat": null,
          "title": "Query Metrics",
          "type": "row"
        },
        {
          "collapsed": true,
          "datasource": "$DS_PROMETHEUS",
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 18
          },
          "id": 212,
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 0,
                "y": 19
              },
              "hiddenSeries": false,
              "id": 2,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_jetty_requests_total{base_url=~\"$base_url\"}[1m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{method}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Requests",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "description": "",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 12,
                "y": 19
              },
              "hiddenSeries": false,
              "id": 1,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_jetty_response_total{base_url=~\"$base_url\"}[1m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{status}}",
                  "refId": "A",
                  "step": 40
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Response",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 24,
                "x": 0,
                "y": 26
              },
              "hiddenSeries": false,
              "id": 55,
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
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_jetty_dispatches_total{base_url=~\"$base_url\"}[1m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Dispatches",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            }
          ],
          "repeat": null,
          "title": "Jetty Metrics",
          "type": "row"
        },
        {
          "collapsed": true,
          "datasource": "$DS_PROMETHEUS",
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 19
          },
          "id": 213,
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 0,
                "y": 20
              },
              "hiddenSeries": false,
              "id": 3,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_jvm_buffers{base_url=~\"$base_url\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{pool}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Buffers",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 12,
                "y": 20
              },
              "hiddenSeries": false,
              "id": 4,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_jvm_buffers_bytes{base_url=~\"$base_url\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{pool}} {{item}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Buffer Size",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "decbytes",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 0,
                "y": 27
              },
              "hiddenSeries": false,
              "id": 5,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_jvm_gc_total{base_url=~\"$base_url\"}[1m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{item}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "GC Count",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 12,
                "y": 27
              },
              "hiddenSeries": false,
              "id": 6,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_jvm_gc_seconds_total{base_url=~\"$base_url\"}[1m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{item}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "GC Time",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "decimals": null,
                  "format": "s",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 0,
                "y": 34
              },
              "hiddenSeries": false,
              "id": 7,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_jvm_memory_heap_bytes{base_url=~\"$base_url\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{item}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Heap Size",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "decbytes",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 12,
                "y": 34
              },
              "hiddenSeries": false,
              "id": 8,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_jvm_memory_non_heap_bytes{base_url=~\"$base_url\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{item}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Non-Heap Size",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "decbytes",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 0,
                "y": 41
              },
              "hiddenSeries": false,
              "id": 9,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_jvm_memory_pools_bytes{base_url=~\"$base_url\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{space}} {{item}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Pool Size",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "decbytes",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 12,
                "y": 41
              },
              "hiddenSeries": false,
              "id": 10,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_jvm_memory_bytes{base_url=~\"$base_url\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{item}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Memory Size",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "decbytes",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 24,
                "x": 0,
                "y": 48
              },
              "hiddenSeries": false,
              "id": 16,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
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
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_jvm_threads{base_url=~\"$base_url\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{item}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Threads",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            }
          ],
          "repeat": null,
          "title": "JVM Metrics",
          "type": "row"
        },
        {
          "collapsed": true,
          "datasource": "$DS_PROMETHEUS",
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 20
          },
          "id": 214,
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 0,
                "y": 21
              },
              "hiddenSeries": false,
              "id": 11,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_jvm_os_memory_bytes{base_url=~\"$base_url\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{item}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Memory Size",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "decbytes",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 12,
                "y": 21
              },
              "hiddenSeries": false,
              "id": 12,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_jvm_os_file_descriptors{base_url=~\"$base_url\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{item}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "File Descriptors",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 0,
                "y": 28
              },
              "hiddenSeries": false,
              "id": 13,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_jvm_os_cpu_load{base_url=~\"$base_url\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{item}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "CPU Load",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "percentunit",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 12,
                "y": 28
              },
              "hiddenSeries": false,
              "id": 14,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_jvm_os_cpu_time_seconds{base_url=~\"$base_url\"}[1m])",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{item}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "CPU Time",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 24,
                "x": 0,
                "y": 35
              },
              "hiddenSeries": false,
              "id": 15,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
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
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_jvm_os_load_average{base_url=~\"$base_url\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{item}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Load Average",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            }
          ],
          "repeat": null,
          "title": "OS Metrics",
          "type": "row"
        },
        {
          "collapsed": true,
          "datasource": "$DS_PROMETHEUS",
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 21
          },
          "id": 215,
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 0,
                "y": 22
              },
              "hiddenSeries": false,
              "id": 19,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_node_requests_total{base_url=~\"$base_url\"}",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{handler}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Requests",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 12,
                "y": 22
              },
              "hiddenSeries": false,
              "id": 22,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_node_time_seconds_total{base_url=~\"$base_url\"}[1m])",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}{{handler}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Request Time",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 0,
                "y": 29
              },
              "hiddenSeries": false,
              "id": 17,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_node_client_errors_total{base_url=~\"$base_url\"}[1m])",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}{{handler}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Client Errors",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 12,
                "y": 29
              },
              "hiddenSeries": false,
              "id": 20,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_node_server_errors_total{base_url=~\"$base_url\"}[1m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}{{handler}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Server Errors",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 0,
                "y": 36
              },
              "hiddenSeries": false,
              "id": 18,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_node_errors_total{base_url=~\"$base_url\"}[1m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}{{handler}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Errors",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 12,
                "y": 36
              },
              "hiddenSeries": false,
              "id": 21,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_node_timeouts_total{base_url=~\"$base_url\"}[1m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}{{handler}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Timeouts",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 0,
                "y": 43
              },
              "hiddenSeries": false,
              "id": 23,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_node_cores{base_url=~\"$base_url\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{item}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Cores",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 12,
                "y": 43
              },
              "hiddenSeries": false,
              "id": 24,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_node_core_root_fs_bytes{base_url=~\"$base_url\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{item}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Core Root File System",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "decbytes",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 0,
                "y": 50
              },
              "hiddenSeries": false,
              "id": 25,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_node_thread_pool_completed_total{base_url=~\"$base_url\"}",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{handler}} {{executor}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Thread Pool Completed",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 12,
                "y": 50
              },
              "hiddenSeries": false,
              "id": 26,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_node_thread_pool_submitted_total{base_url=~\"$base_url\"}",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{handler}} {{executor}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Thread Pool Submitted",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 24,
                "x": 0,
                "y": 57
              },
              "hiddenSeries": false,
              "id": 27,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
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
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_node_thread_pool_running{base_url=~\"$base_url\"}",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{handler}} {{executor}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Thread Pool Running",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 16,
                "x": 0,
                "y": 64
              },
              "hiddenSeries": false,
              "id": 28,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
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
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_node_connections{base_url=~\"$base_url\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}} {{handler}} {{item}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Connections",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "description": "Number of leaders on each node",
              "fieldConfig": {
                "defaults": {
                  "custom": {},
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
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 8,
                "x": 16,
                "y": 64
              },
              "hiddenSeries": false,
              "id": 220,
              "legend": {
                "avg": false,
                "current": true,
                "hideEmpty": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 2,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "sum by (base_url) (solr_collections_shard_leader{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"})",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}",
                  "refId": "A"
                }
              ],
              "thresholds": [
                {
                  "colorMode": "critical",
                  "fill": true,
                  "line": true,
                  "op": "gt",
                  "yaxis": "left"
                }
              ],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Leader Count (by node)",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            }
          ],
          "repeat": null,
          "title": "Node Metrics",
          "type": "row"
        },
        {
          "collapsed": true,
          "datasource": "$DS_PROMETHEUS",
          "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 22
          },
          "id": 216,
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 0,
                "y": 23
              },
              "hiddenSeries": false,
              "id": 31,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_core_requests_total{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}[1m])",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}}{{handler}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Requests",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 12,
                "y": 23
              },
              "hiddenSeries": false,
              "id": 34,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_core_time_seconds_total{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}[1m])",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}}{{handler}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Request Time",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 0,
                "y": 30
              },
              "hiddenSeries": false,
              "id": 29,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_core_client_errors_total{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}[1m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}}{{handler}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Client Errors",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 12,
                "y": 30
              },
              "hiddenSeries": false,
              "id": 32,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_core_server_errors_total{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}[1m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}}{{handler}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Server Errors",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 0,
                "y": 37
              },
              "hiddenSeries": false,
              "id": 30,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_core_errors_total{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}[1m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}}{{handler}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Errors",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 12,
                "y": 37
              },
              "hiddenSeries": false,
              "id": 33,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_core_timeouts_total{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}[1m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}}{{handler}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Timeouts",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 0,
                "y": 44
              },
              "hiddenSeries": false,
              "id": 35,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_core_searcher_cache_ratio{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}} {{type}} {{item}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Searcher Cache Hit Ratio",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 12,
                "y": 44
              },
              "hiddenSeries": false,
              "id": 36,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_core_searcher_cache{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}} {{type}} {{item}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Searcher Cache",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 0,
                "y": 51
              },
              "hiddenSeries": false,
              "id": 37,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_core_searcher_warmup_time_seconds{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}} {{type}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Searcher Warm Up Time",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 12,
                "y": 51
              },
              "hiddenSeries": false,
              "id": 38,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_core_searcher_cumulative_cache_total{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}[1m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}} {{type}} {{item}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Searcher Cumulative Cache",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 0,
                "y": 58
              },
              "hiddenSeries": false,
              "id": 39,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_core_fs_bytes{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "File System",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "decbytes",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 12,
                "y": 58
              },
              "hiddenSeries": false,
              "id": 40,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_core_index_size_bytes{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Index Size",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "decbytes",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 24,
                "x": 0,
                "y": 65
              },
              "hiddenSeries": false,
              "id": 41,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
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
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_core_searcher_documents{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}} {{item}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Searcher Documents",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 0,
                "y": 72
              },
              "hiddenSeries": false,
              "id": 42,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "rightSide": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_core_update_handler_adds_total{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}[1m])",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Update Handler Adds (cumulative)",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 12,
                "y": 72
              },
              "hiddenSeries": false,
              "id": 46,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "solr_metrics_core_update_handler_pending_docs{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Pending Docs",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 8,
                "x": 0,
                "y": 79
              },
              "hiddenSeries": false,
              "id": 43,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_core_update_handler_deletes_by_id_total{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}[1m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Update Handler Deletes By ID",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 8,
                "x": 8,
                "y": 79
              },
              "hiddenSeries": false,
              "id": 44,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_core_update_handler_deletes_by_query_total{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}[1m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Update Handler Deletes By Query",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 8,
                "x": 16,
                "y": 79
              },
              "hiddenSeries": false,
              "id": 47,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_core_update_handler_expunge_deletes_total{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}[1m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Update Handler Expunge Deletes",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 0,
                "y": 86
              },
              "hiddenSeries": false,
              "id": 48,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_core_update_handler_merges_total{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}[1m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Update Handler Merges",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 12,
                "y": 86
              },
              "hiddenSeries": false,
              "id": 52,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_core_update_handler_splits_total{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}[1m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Update Handler Splits",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 0,
                "y": 93
              },
              "hiddenSeries": false,
              "id": 49,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_core_update_handler_optimizes_total{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}[1m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Update Handler Optimizes",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 12,
                "x": 12,
                "y": 93
              },
              "hiddenSeries": false,
              "id": 50,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_core_update_handler_rollbacks_total{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}[1m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Update Handler Rollbacks",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 8,
                "x": 0,
                "y": 100
              },
              "hiddenSeries": false,
              "id": 51,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_core_update_handler_soft_auto_commits_total{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}[1m])",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Update Handler Soft Auto Commits",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 8,
                "x": 8,
                "y": 100
              },
              "hiddenSeries": false,
              "id": 53,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_core_update_handler_auto_commits_total{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}[1m])",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Update Handler Auto Commits",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 8,
                "x": 16,
                "y": 100
              },
              "hiddenSeries": false,
              "id": 54,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_core_update_handler_commits_total{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}[1m])",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Update Handler Commits",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "$DS_PROMETHEUS",
              "fieldConfig": {
                "defaults": {
                  "custom": {}
                },
                "overrides": []
              },
              "fill": 1,
              "fillGradient": 0,
              "gridPos": {
                "h": 7,
                "w": 24,
                "x": 0,
                "y": 107
              },
              "hiddenSeries": false,
              "id": 45,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": false,
                "hideEmpty": true,
                "hideZero": true,
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
              "nullPointMode": "null",
              "options": {
                "alertThreshold": true
              },
              "percentage": false,
              "pluginVersion": "7.3.0",
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "increase(solr_metrics_core_update_handler_errors_total{base_url=~\"$base_url\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\",core=~\"$core\"}[1m])",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{base_url}}/{{core}}",
                  "refId": "A"
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeRegions": [],
              "timeShift": null,
              "title": "Update Handler Errors",
              "tooltip": {
                "shared": true,
                "sort": 2,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ],
              "yaxis": {
                "align": false,
                "alignLevel": null
              }
            }
          ],
          "repeat": null,
          "title": "Core Metrics",
          "type": "row"
        }
      ],
      "refresh": "30s",
      "schemaVersion": 26,
      "style": "dark",
      "tags": [],
      "templating": {
        "list": [
          {
            "current": {
              "selected": false,
              "text": "Prometheus",
              "value": "Prometheus"
            },
            "hide": 2,
            "includeAll": false,
            "label": "Datasource",
            "multi": false,
            "name": "DS_PROMETHEUS",
            "options": [],
            "query": "prometheus",
            "refresh": 1,
            "regex": "/.*Prometheus.*/i",
            "skipUrlSync": false,
            "type": "datasource"
          },
          {
            "allValue": ".*",
            "current": {},
            "datasource": "$DS_PROMETHEUS",
            "definition": "",
            "error": null,
            "hide": 0,
            "includeAll": true,
            "label": null,
            "multi": true,
            "name": "zk_host",
            "options": [],
            "query": "label_values(solr_ping{zk_host=~\".+\"},zk_host)",
            "refresh": 1,
            "regex": "/(.+)/",
            "skipUrlSync": false,
            "sort": 1,
            "tagValuesQuery": "",
            "tags": [],
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          },
          {
            "allValue": ".*",
            "current": {},
            "datasource": "$DS_PROMETHEUS",
            "definition": "",
            "error": null,
            "hide": 0,
            "includeAll": true,
            "label": null,
            "multi": true,
            "name": "base_url",
            "options": [],
            "query": "label_values(solr_ping{base_url=~\".+\"},base_url)",
            "refresh": 1,
            "regex": "/(.+)/",
            "skipUrlSync": false,
            "sort": 1,
            "tagValuesQuery": "",
            "tags": [],
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          },
          {
            "allValue": ".*",
            "current": {},
            "datasource": "$DS_PROMETHEUS",
            "definition": "",
            "error": null,
            "hide": 0,
            "includeAll": true,
            "label": null,
            "multi": true,
            "name": "collection",
            "options": [],
            "query": "label_values(solr_collections_shard_state{zk_host=~\"$zk_host\",collection=~\".+\"},collection)",
            "refresh": 1,
            "regex": "/(.+)/",
            "skipUrlSync": false,
            "sort": 1,
            "tagValuesQuery": "",
            "tags": [],
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          },
          {
            "allValue": ".*",
            "current": {},
            "datasource": "$DS_PROMETHEUS",
            "definition": "",
            "error": null,
            "hide": 0,
            "includeAll": true,
            "label": null,
            "multi": true,
            "name": "shard",
            "options": [],
            "query": "label_values(solr_collections_shard_state{zk_host=~\"$zk_host\",collection=~\"$collection\",shard=~\".+\"},shard)",
            "refresh": 1,
            "regex": "/(.+)/",
            "skipUrlSync": false,
            "sort": 1,
            "tagValuesQuery": "",
            "tags": [],
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          },
          {
            "allValue": ".*",
            "current": {},
            "datasource": "$DS_PROMETHEUS",
            "definition": "",
            "error": null,
            "hide": 0,
            "includeAll": true,
            "label": null,
            "multi": true,
            "name": "replica",
            "options": [],
            "query": "label_values(solr_collections_replica_state{zk_host=~\"$zk_host\",collection=~\"$collection\",shard=~\"$shard\",replica=~\".+\"},replica)",
            "refresh": 1,
            "regex": "/(.+)/",
            "skipUrlSync": false,
            "sort": 1,
            "tagValuesQuery": "",
            "tags": [],
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          },
          {
            "allValue": ".*",
            "current": {},
            "datasource": "$DS_PROMETHEUS",
            "definition": "",
            "error": null,
            "hide": 0,
            "includeAll": true,
            "label": null,
            "multi": true,
            "name": "core",
            "options": [],
            "query": "label_values(solr_collections_replica_state{zk_host=~\"$zk_host\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\"},core)",
            "refresh": 1,
            "regex": "/(.+)/",
            "skipUrlSync": false,
            "sort": 1,
            "tagValuesQuery": "",
            "tags": [],
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          },
          {
            "allValue": ".*",
            "current": {},
            "datasource": "$DS_PROMETHEUS",
            "definition": "label_values(solr_metrics_core_query_errors_1minRate{zk_host=~\"$zk_host\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\"},searchHandler)",
            "error": null,
            "hide": 0,
            "includeAll": true,
            "label": null,
            "multi": true,
            "name": "searchHandler",
            "options": [],
            "query": "label_values(solr_metrics_core_query_errors_1minRate{zk_host=~\"$zk_host\",collection=~\"$collection\",shard=~\"$shard\",replica=~\"$replica\"},searchHandler)",
            "refresh": 1,
            "regex": "/(.+)/",
            "skipUrlSync": false,
            "sort": 1,
            "tagValuesQuery": "",
            "tags": [],
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          }
        ]
      },
      "time": {
        "from": "now-15m",
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
      "title": "Solr Dashboard",
      "uid": "solr001",
      "version": 2
    }