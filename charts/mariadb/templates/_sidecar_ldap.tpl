{{- define "sidecar-ldap" -}}
name: {{ .Chart.Name }}-ldap
securityContext: {{ toYaml .Values.ldap.securityContext | nindent 2 }}
image: "{{ .Values.ldap.image.repository }}:{{ .Values.ldap.image.tag | default .Chart.AppVersion }}"
imagePullPolicy: {{ .Values.ldap.image.pullPolicy | default "Always" }}
args: {{ .Values.ldap.extraArgs | toYaml | nindent 2 }}
env:
- {name: LDAP_URI, value: {{ .Values.ldap.uri | quote }}}
- {name: LDAP_BASE, value: {{ .Values.ldap.base | quote }}}
- {name: LDAP_BINDDN, value: {{ .Values.ldap.bindDn | quote }}}
{{- range $key, $value := .Values.ldap.extraEnv }}
- {name: {{ $key }}, value: "{{ $value }}"}
{{- end }}
resources: {{ toYaml .Values.ldap.resources | nindent 2 }}
volumeMounts:
- name: {{ include "mariadb.fullname" . }}-ldap
  mountPath: /templates
- name: {{ include "mariadb.fullname" . }}-run-ldap
  mountPath: /run/nslcd
- name: {{ include "mariadb.fullname" . }}-creds
  mountPath: /run/credentials/ldap-bindpw
  subPath: ldap-bindpw
{{- if .Values.tls.enabled }}
- name: {{ include "mariadb.fullname" . }}-tls
  mountPath: /run/tls/ca.crt
  subPath: ca.crt
{{- end }}
{{- end -}}