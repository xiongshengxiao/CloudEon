- type: log
  enabled: true
  fields:
    service: DORIS
    role: ${ROLE_FULL_NAME?replace("-", "_")?upper_case}
  paths:
    - /workspace/logs/*fe*.log
  multiline.pattern: '^[0-9]{4}-[0-9]{2}-[0-9]{2}'
  multiline.negate: true
  multiline.match: after
  close_timeout: 5m


- type: log
  enabled: true
  fields:
    service: DORIS
    role: DORIS_BE
  paths:
    - /workspace/logs/*be*.log
  multiline.pattern: '^[0-9]{4}-[0-9]{2}-[0-9]{2}'
  multiline.negate: true
  multiline.match: after
  close_timeout: 5m
