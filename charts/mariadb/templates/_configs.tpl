{{ define "my.cnf" }}
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
{{/************************************************************************/}}
{{ define "nslcd.conf" }}
# /etc/nslcd.conf
# nslcd configuration file. See nslcd.conf(5)
# for details.

# The user and group nslcd should run as.
uid nslcd
gid nslcd

# The location at which the LDAP server(s) should be reachable.
uri $LDAP_URI

# The search base that will be used for all queries.
base $LDAP_BASE

# The LDAP protocol version to use.
#ldap_version 3

# The DN to bind with for normal lookups.
binddn $LDAP_BINDDN
bindpw $LDAP_BINDPW

# The DN used for password modifications by root.
#rootpwmoddn cn=admin,dc=example,dc=com

# SSL options
{{- if .Values.ldap.tls.enabled }}
ssl on
tls_reqcert always
tls_cacertfile /run/tls/ca.crt
{{- else }}
#ssl off
#tls_reqcert never
tls_cacertfile /etc/ssl/certs/ca-certificates.crt
{{- end }}

# The search scope.
#scope sub

{{- end }}
