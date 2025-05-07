apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: minio-service-monitor
  labels:
    team: frontend
spec:
  selector:
    matchLabels:
      sname: ${serviceFullName}
  endpoints:
  - port: metrics
    path: /minio/prometheus/metrics
  - port: metrics
    path: /minio/v2/metrics/cluster
  - port: metrics
    path: /minio/v2/metrics/node
---
kind: Service
apiVersion: v1
metadata:
  name: metrics-minio
  labels:
    sname: ${serviceFullName}
    roleFullName: minio-server
spec:
  selector:
    sname: ${serviceFullName}
    roleFullName: minio-server
  ports:
  - name: metrics
    port: ${conf['minio.metrics.port']}
