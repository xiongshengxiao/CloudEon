kind: Service
apiVersion: v1
metadata:
  name: metrics-starrocks-fe-master
  labels:
    sname: ${serviceFullName}
    roleFullName: starrocks-fe-master
    enable-default-service-monitor: true
spec:
  selector:
    sname: ${serviceFullName}
    roleFullName: starrocks-fe-master
  ports:
  - name: metrics
    port: ${conf['http_port']}
---
kind: Service
apiVersion: v1
metadata:
  name: metrics-starrocks-be
  labels:
    sname: ${serviceFullName}
    roleFullName: starrocks-be
    enable-default-service-monitor: true
spec:
  selector:
    sname: ${serviceFullName}
    roleFullName: starrocks-be
  ports:
  - name: metrics
    port: ${conf['be_http_port']}