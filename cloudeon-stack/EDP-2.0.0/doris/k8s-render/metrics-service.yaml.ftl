kind: Service
apiVersion: v1
metadata:
  name: metrics-doris-fe-master
  labels:
    sname: ${serviceFullName}
    roleFullName: doris-fe-master
    enable-default-service-monitor: true
spec:
  selector:
    sname: ${serviceFullName}
    roleFullName: doris-fe-master
  ports:
  - name: metrics
    port: ${conf['http_port']}
---
kind: Service
apiVersion: v1
metadata:
  name: metrics-doris-fe-follower
  labels:
    sname: ${serviceFullName}
    roleFullName: doris-fe-follower
    enable-default-service-monitor: true
spec:
  selector:
    sname: ${serviceFullName}
    roleFullName: doris-fe-follower
  ports:
  - name: metrics
    port: ${conf['http_port']}
---
kind: Service
apiVersion: v1
metadata:
  name: metrics-doris-fe-observer
  labels:
    sname: ${serviceFullName}
    roleFullName: doris-fe-observer
    enable-default-service-monitor: true
spec:
  selector:
    sname: ${serviceFullName}
    roleFullName: doris-fe-observer
  ports:
  - name: metrics
    port: ${conf['http_port']}
---
kind: Service
apiVersion: v1
metadata:
  name: metrics-doris-be
  labels:
    sname: ${serviceFullName}
    roleFullName: doris-be
    enable-default-service-monitor: true
spec:
  selector:
    sname: ${serviceFullName}
    roleFullName: doris-be
  ports:
  - name: metrics
    port: ${conf['webserver_port']}