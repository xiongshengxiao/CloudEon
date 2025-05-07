apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: seatunnel-service-monitor
  labels:
    team: frontend
spec:
  selector:
    matchLabels:
      sname: ${serviceFullName}
  endpoints:
  - port: metrics
    path: /hazelcast/rest/instance/metrics
---
kind: Service
apiVersion: v1
metadata:
  name: metrics-seatunnel-master
  labels:
    sname: ${serviceFullName}
    roleFullName: seatunnel-master
spec:
  selector:
    sname: ${serviceFullName}
    roleFullName: seatunnel-master
  ports:
  - name: metrics
    port: ${conf['seatunnel.master.join.port']}
---
kind: Service
apiVersion: v1
metadata:
  name: metrics-seatunnel-worker
  labels:
    sname: ${serviceFullName}
    roleFullName: seatunnel-worker
spec:
  selector:
    sname: ${serviceFullName}
    roleFullName: seatunnel-worker
  ports:
  - name: metrics
    port: ${conf['seatunnel.worker.join.port']}