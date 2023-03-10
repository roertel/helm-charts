{{- define "container" -}}
name: {{ .Chart.Name }}
securityContext: {{ toYaml .Values.securityContext | nindent 2 }}
image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
imagePullPolicy: {{ .Values.image.pullPolicy | default "Always" }}
# command: ["sleep", "infinity"]  # for debugging
command: ["/usr/local/bin/entrypoint.sh"]
args: {{ range .Values.mysqld.extraArgs }}{{ . }}{{- end }}
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
{{- if .Values.readinessProbe.enabled }}
readinessProbe:
  initialDelaySeconds: 30
  periodSeconds: 60
  exec:
    command:
    - /usr/bin/bash
    - -c
    - "mysqladmin ping -uroot -p\"$(cat $MYSQL_ROOT_PASSWORD_FILE)\""
{{- end }}
resources: {{ toYaml .Values.resources | nindent 2 }}
volumeMounts:
- name: {{ include "mariadb.fullname" . }}-run-db
  mountPath: /run/mysqld
- name: {{ include "mariadb.fullname" . }}-data
  mountPath: /var/lib/mysql
- name: {{ include "mariadb.fullname" . }}-temp
  mountPath: /tmp
- name: {{ include "mariadb.fullname" . }}-config
  mountPath: /usr/local/bin/entrypoint.sh
  subPath: entrypoint.sh
- name: {{ include "mariadb.fullname" . }}-config
  mountPath: /etc/mysql/conf.d/my.cnf
  subPath: my.cnf
  readOnly: true
- name: {{ include "mariadb.fullname" . }}-creds
  mountPath: /run/credentials/mariadb-root-password
  subPath: mariadb-root-password
  readOnly: true
{{- if .Values.tls.enabled }}
- name: {{ include "mariadb.fullname" . }}-tls-certs
  mountPath: /run/tls
  readOnly: true
- name: {{ include "mariadb.fullname" . }}-tls-init
  mountPath: /docker-entrypoint-initdb.d/tls-init.sql
  subPath: tls-init.sql
{{- end }}
{{- if .Values.ldap.enabled }}
- name: {{ include "mariadb.fullname" . }}-init
  mountPath: /docker-entrypoint-initdb.d/ldap-init.sql
  subPath: ldap-init.sql
- name: {{ include "mariadb.fullname" . }}-run-ldap
  mountPath: /var/run/nslcd/
- name: {{ include "mariadb.fullname" . }}-config
  mountPath: /etc/pam.d/mariadb
  subPath: mariadb
- name: {{ include "mariadb.fullname" . }}-config
  mountPath: /etc/nsswitch.conf
  subPath: nsswitch.conf
{{- end }}
{{- end -}}
