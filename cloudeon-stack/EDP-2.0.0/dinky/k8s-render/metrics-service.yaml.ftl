kind: Service
apiVersion: v1
metadata:
  name: metrics-dinky
  labels:
    sname: ${serviceFullName}
    roleFullName: dinky-server
    enable-default-service-monitor: true
spec:
  selector:
    sname: ${serviceFullName}
    roleFullName: dinky-server
  ports:
  - name: metrics
    port: ${conf["dinky.jmx.port"]}