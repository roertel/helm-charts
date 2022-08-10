{{/* Initialize the slapd database one time */}}
{{- define "ldaprc" }}
URI ldapi://%2fldap%2frun%2fslapd.sock
BINDDN 
{{- end }}
