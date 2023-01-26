{{- define "volumes" -}}
- name: {{ include "mariadb.fullname" . }}-init
  configMap:
    name: {{ include "mariadb.fullname" . }}
    items:
    {{- if .Values.ldap.enabled }}
    - key: "ldap-init.sql"
      path: "ldap-init.sql"
    {{- end }}
- name: {{ include "mariadb.fullname" . }}-config
  configMap:
    name: {{ include "mariadb.fullname" . }}
    items:
    - key: "my.cnf"
      path: "my.cnf"
    {{- if .Values.ldap.enabled }}
    - key: "nsswitch.conf"
      path: "nsswitch.conf"
    - key: "mariadb"
      path: "mariadb"
    {{- end }}
- name: {{ include "mariadb.fullname" . }}-data
  {{- if .Values.persistence.enabled }}
  persistentVolumeClaim:
    claimName: {{ include "mariadb.fullname" . }}
  {{- else }}
  emptyDir:
  {{- end }}
- name: {{ include "mariadb.fullname" . }}-run-db
  emptyDir:
- name: {{ include "mariadb.fullname" . }}-run-ldap
  emptyDir:
- name: {{ include "mariadb.fullname" . }}-creds
  secret:
    secretName: {{ include "mariadb.fullname" . }}
    defaultMode: 0444
    items:
    - key: "mariadb-root-password"
      path: "mariadb-root-password"
{{- if .Values.tls.enabled }}
- name: {{ include "mariadb.fullname" . }}-tls-certs
  secret:
    {{- if eq .Values.tls.type "certificate" }}
    secretName: {{ include "mariadb.fullname" . }}-tls
    {{- else if eq .Values.tls.type "secret" }}
    secretName: {{ .Values.tls.secret | quote }}
    {{- end }}
    defaultMode: 0444
- name: {{ include "mariadb.fullname" . }}-tls-home
  secret:
    secretName: {{ include "mariadb.fullname" . }}
    defaultMode: 0444
    items:
    - key: "connection-admin-my.cnf"
      path: ".my.cnf"
- name: {{ include "mariadb.fullname" . }}-tls-init
  secret:
    secretName: {{ include "mariadb.fullname" . }}
    defaultMode: 0444
    items:
    - key: "tls-init.sql"
      path: "tls-init.sql"
{{- end }}
{{- if .Values.ldap.enabled }}
- name: {{ include "mariadb.fullname" . }}-ldap
  secret:
    secretName: {{ include "mariadb.fullname" . }}
    defaultMode: 0444
    items:
    - key: "nslcd.conf.tpl"
      path: "nslcd.conf.tpl"
{{- end }}
{{- end -}}
