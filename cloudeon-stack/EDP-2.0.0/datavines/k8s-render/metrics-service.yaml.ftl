kind: Service
apiVersion: v1
metadata:
  name: metrics-datavines
  labels:
    sname: ${serviceFullName}
    roleFullName: datavines-server
    enable-default-service-monitor: true
spec:
  selector:
    sname: ${serviceFullName}
    roleFullName: datavines-server
  ports:
  - name: metrics
    port: ${conf["datavines.jmx.port"]}
