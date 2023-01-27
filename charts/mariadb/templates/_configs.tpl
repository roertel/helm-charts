{{- define "my.cnf" -}}
[mysqld]
{{- if .Values.tls.enabled }}
ssl-ca = /run/tls/ca.crt
ssl-cert = /run/tls/tls.crt
ssl-key = /run/tls/tls.key
{{- if .Values.tls.required }}
require-secure-transport = on
{{- end }}
tls-version = {{ .Values.tls.versions | default "TLSv1.2,TLSv1.3" }}
{{- end }}
{{- end }}
