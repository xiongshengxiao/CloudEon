kind: Service
apiVersion: v1
metadata:
  name: metrics-superset
  labels:
    sname: ${serviceFullName}
    roleFullName: superset-server
    enable-default-service-monitor: true
spec:
  selector:
    sname: ${serviceFullName}
    roleFullName: superset-server
  ports:
  - name: metrics
    port: ${conf["superset.jmx.port"]}