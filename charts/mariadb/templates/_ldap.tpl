{{- define "nslcd.conf" -}}
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
{{- if and (hasKey .Values.ldap "tls") (hasKey .Values.ldap.tls "enabled") .Values.ldap.tls.enabled }}
ssl on
tls_reqcert demand
{{- if .Values.tls.enabled }}
tls_cacertfile /run/tls/ca.crt
{{- else }}
tls_cacertfile /etc/ssl/certs/ca-certificates.crt
{{- end }}
{{- else }}
#ssl off
#tls_reqcert never
tls_cacertfile /etc/ssl/certs/ca-certificates.crt
{{- end }}

# The search scope.
#scope sub
{{- end -}}
{{/************************************************************************/}}
{{- define "nsswitch.conf" -}}
# /etc/nsswitch.conf
#
# Example configuration of GNU Name Service Switch functionality.
# If you have the `glibc-doc-reference' and `info' packages installed, try:
# `info libc "Name Service Switch"' for information about this file.

passwd:         files ldap
group:          files ldap
shadow:         files ldap
gshadow:        files

hosts:          files dns
networks:       files

protocols:      db files
services:       db files
ethers:         db files
rpc:            db files

netgroup:       nis

{{- end -}}
{{/************************************************************************/}}
{{- define "pam-mariadb" -}}
auth sufficient pam_ldap.so
account sufficient pam_ldap.so
{{- end -}}
{{/************************************************************************/}}
{{- define "ldap-init.sql" -}}
INSTALL SONAME 'auth_pam';
{{- end -}}
