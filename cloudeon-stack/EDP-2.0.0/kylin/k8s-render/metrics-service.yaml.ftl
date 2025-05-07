kind: Service
apiVersion: v1
metadata:
  name: metrics-kylin-server
  labels:
    sname: ${serviceFullName}
    roleFullName: kylin-server
    enable-default-service-monitor: true
spec:
  selector:
    sname: ${serviceFullName}
    roleFullName: kylin-server
  ports:
  - name: metrics
    port: 5556
