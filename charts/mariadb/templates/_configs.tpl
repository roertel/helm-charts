{{- define "my.cnf" -}}
[mysqld]
innodb_use_native_aio=OFF
log-bin=ON
log-basename=binary_log
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

{{/*
Entrypoint wrapper to handle slower startups.
*/}}
{{- define "entrypoint.sh" -}}
#!/bin/bash
set -eo pipefail
shopt -s nullglob
# Override sleep to be 10x slower
sleep() { echo "Waiting...";/usr/bin/sleep ${1}0; }
source /usr/local/bin/docker-entrypoint.sh
_main mariadbd "$@"
{{- end }}
