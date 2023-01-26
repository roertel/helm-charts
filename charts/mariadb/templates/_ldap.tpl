{{- define "nslcd.conf.tpl" -}}
uri {{ .Values.ldap.uri }}
base {{ .Values.ldap.base }}
binddn {{ .Values.ldap.bindDn }}
bindpw {{ .Values.ldap.bindPw }}
{{- if and (hasKey .Values.ldap "tls") (hasKey .Values.ldap.tls "enabled") .Values.ldap.tls.enabled }}
ssl on
tls_reqcert demand
{{- if .Values.tls.enabled }}
tls_cacertfile /run/tls/ca.crt
{{- else }}
tls_cacertfile /etc/ssl/certs/ca-certificates.crt
{{- end }}
{{- else }}
tls_cacertfile /etc/ssl/certs/ca-certificates.crt
{{- end }}
{{- end -}}
{{- /************************************************************************/ -}}
{{- define "nsswitch.conf" -}}
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
{{- /************************************************************************/ -}}
{{- define "pam-mariadb" -}}
auth sufficient pam_ldap.so
account sufficient pam_ldap.so
{{- end -}}
{{/************************************************************************/}}
{{- define "ldap-init.sql" -}}
INSTALL SONAME 'auth_pam';
{{- end -}}
