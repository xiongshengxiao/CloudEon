kind: Service
apiVersion: v1
metadata:
  name: metrics-datax-web
  labels:
    sname: ${serviceFullName}
    roleFullName: datax-web
    enable-default-service-monitor: true
spec:
  selector:
    sname: ${serviceFullName}
    roleFullName: datax-web
  ports:
  - name: metrics
    port: ${conf["datax_web.jmx.port"]}