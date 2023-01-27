{{- define "sidecar-ldap" -}}
name: {{ .Chart.Name }}-ldap
securityContext: {{ toYaml .Values.ldap.securityContext | nindent 2 }}
image: "{{ .Values.ldap.image.repository }}:{{ .Values.ldap.image.tag | default .Chart.AppVersion }}"
imagePullPolicy: {{ .Values.ldap.image.pullPolicy | default "Always" }}
args: {{ .Values.ldap.extraArgs | toYaml | nindent 2 }}
# command: ['sleep', 'infinity']
env:
{{- range $key, $value := .Values.ldap.extraEnv }}
- {name: {{ $key }}, value: "{{ $value }}"}
{{- end }}
resources: {{ toYaml .Values.ldap.resources | nindent 2 }}
volumeMounts:
- name: {{ include "mariadb.fullname" . }}-ldap
  mountPath: /templates/
- name: {{ include "mariadb.fullname" . }}-run-ldap
  mountPath: /run/nslcd/
{{- if .Values.tls.enabled }}
# This is a hack & assumes that the CA for TLS is the same CA for LDAP
- name: {{ include "mariadb.fullname" . }}-tls-certs
  mountPath: /run/tls/ca.crt
  subPath: ca.crt
{{- end }}
{{- end -}}