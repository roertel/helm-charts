{{- define "sidecar-tls" -}}
name: {{ .Chart.Name }}-tls
securityContext: {{ toYaml .Values.tls.securityContext | nindent 2 }}
image: "{{ .Values.tls.image.repository }}:{{ .Values.tls.image.tag | default .Chart.AppVersion }}"
imagePullPolicy: {{ .Values.tls.image.pullPolicy | default "Always" }}
args:  {{ .Values.tls.extraArgs | toYaml | nindent 2 }}
env:
{{- range $key, $value := .Values.tls.extraEnv }}
- {name: {{ $key }}, value: "{{ $value }}"}
{{- end }}
resources: {{ toYaml .Values.tls.resources | nindent 2 }}
volumeMounts:
- name: {{ include "mariadb.fullname" . }}-run-db
  mountPath: /run/mysqld
- name: {{ include "mariadb.fullname" . }}-tls-certs
  mountPath: /run/tls
- name: {{ include "mariadb.fullname" . }}-tls-home
  mountPath: /home/.my.cnf
  subPath: .my.cnf
{{- end -}}
