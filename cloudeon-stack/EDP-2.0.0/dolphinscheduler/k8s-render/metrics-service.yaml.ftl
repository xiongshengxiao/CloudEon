apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: ds-service-monitor
  labels:
    team: frontend
spec:
  selector:
    matchLabels:
      sname: ${serviceFullName}
  endpoints:
  - port: metrics
    path: /actuator/prometheus
---
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: ds-api-service-monitor
  labels:
    team: frontend
spec:
  selector:
    matchLabels:
      sname: ${serviceFullName}
      roleFullName: ds-api
  endpoints:
  - port: metrics
    path: /dolphinscheduler/actuator/prometheus
---
kind: Service
apiVersion: v1
metadata:
  name: metrics-ds-master
  labels:
    sname: ${serviceFullName}
    roleFullName: ds-master
spec:
  selector:
    sname: ${serviceFullName}
    roleFullName: ds-master
  ports:
  - name: metrics
    port: ${conf['master.server.port']}
---
kind: Service
apiVersion: v1
metadata:
  name: metrics-ds-worker
  labels:
    sname: ${serviceFullName}
    roleFullName: ds-worker
spec:
  selector:
    sname: ${serviceFullName}
    roleFullName: ds-worker
  ports:
  - name: metrics
    port: ${conf['worker.server.port']}
---
kind: Service
apiVersion: v1
metadata:
  name: metrics-ds-api
  labels:
    sname: ${serviceFullName}
    roleFullName: ds-api
spec:
  selector:
    sname: ${serviceFullName}
    roleFullName: ds-api
  ports:
  - name: metrics
    port: ${conf['api.server.port']}
---
kind: Service
apiVersion: v1
metadata:
  name: metrics-ds-alert
  labels:
    sname: ${serviceFullName}
    roleFullName: ds-alert
spec:
  selector:
    sname: ${serviceFullName}
    roleFullName: ds-alert
  ports:
  - name: metrics
    port: ${conf['alert.server.port']}