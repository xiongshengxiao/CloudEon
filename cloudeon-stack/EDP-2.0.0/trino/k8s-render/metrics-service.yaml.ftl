kind: Service
apiVersion: v1
metadata:
  name: metrics-trino-coordinator
  labels:
    sname: ${serviceFullName}
    roleFullName: trino-coordinator
    enable-default-service-monitor: true
spec:
  selector:
    sname: ${serviceFullName}
    roleFullName: trino-coordinator
  ports:
  - name: metrics
    port: 8098
---
kind: Service
apiVersion: v1
metadata:
  name: metrics-trino-worker
  labels:
    sname: ${serviceFullName}
    roleFullName: trino-worker
    enable-default-service-monitor: true
spec:
  selector:
    sname: ${serviceFullName}
    roleFullName: trino-worker
  ports:
  - name: metrics
    port: 8099