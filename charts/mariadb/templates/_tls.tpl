{{- define "tls-init.sql" -}}
GRANT CONNECTION ADMIN on *.* TO 'connection_admin'@'localhost' IDENTIFIED VIA unix_socket;
{{- end -}}
