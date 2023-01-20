{{- define "container" -}}
name: {{ .Chart.Name }}
securityContext: {{ toYaml .Values.securityContext | nindent 2 }}
image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
imagePullPolicy: {{ .Values.image.pullPolicy | default "Always" }}
# command: ["sleep", "infinity"]  # for debugging
# command: ["bash", "-x", "/usr/local/bin/docker-entrypoint.sh", "mariadbd"]
args: {{- range .Values.mysqld.extraArgs }}{{ . }}{{- end }}
env:
- name: MYSQL_ROOT_PASSWORD_FILE
  value: /run/credentials/mariadb-root-password
{{- range $key, $value := .Values.mysqld.extraEnv }}
- {name: {{ $key }}, value: "{{ $value }}"}
{{- end }}
ports:
- name: mysql
  containerPort: 3306
  protocol: TCP
{{- if .Values.startupProbe.enabled }}
startupProbe:
  failureThreshold: 10
  periodSeconds: 30
  tcpSocket:
    port: mysql
{{- end }}
{{- if .Values.readinessProbe.enabled }}
readinessProbe:
  initialDelaySeconds: 30
  periodSeconds: 60
  tcpSocket:
    port: mysql
{{- end }}
{{- if .Values.livenessProbe.enabled }}
livenessProbe:
  initialDelaySeconds: 30
  periodSeconds: 600
  tcpSocket:
    port: mysql
{{- end }}
resources: {{ toYaml .Values.resources | nindent 2 }}
volumeMounts:
- name: {{ include "mariadb.fullname" . }}-run-db
  mountPath: /run/mysqld
  readOnly: false
- name: {{ include "mariadb.fullname" . }}-data
  mountPath: /var/lib/mysql
  readOnly: false
- name: {{ include "mariadb.fullname" . }}-config
  mountPath: /etc/mysql/conf.d/my.cnf
  subPath: my.cnf
  readOnly: true
- name: {{ include "mariadb.fullname" . }}-creds
  mountPath: /run/credentials/mariadb-root-password
  subPath: mariadb-root-password
  readOnly: true
- name: {{ include "mariadb.fullname" . }}-init
  mountPath: /docker-entrypoint-initdb.d/
{{- if .Values.tls.enabled }}
- name: {{ include "mariadb.fullname" . }}-tls
  mountPath: /run/tls
  readOnly: true
{{- end }}
{{- if .Values.ldap.enabled }}
- name: {{ include "mariadb.fullname" . }}-config
  mountPath: /etc/pam.d/mariadb
  subPath: mariadb
{{- end }}
{{- end -}}
