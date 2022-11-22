{{ define "config.ldif" }}
# Executed after LDAP is started and with subsequent restarts.
# May be run more than once. Executed via ldapmodify -ca as admin.
# Script will be filtered through envsubst prior to running.
dn: {{ cat "dc=" .Values.ldapDomain | replace "." ",dc=" | nospace }}
changetype: add
objectClass: dcObject
objectClass: organization
objectClass: top
o: {{ .Values.ldapOrganization }}

dn: ou=groups,{{ cat "dc=" .Values.ldapDomain | replace "." ",dc=" | nospace }}
changetype: add
objectClass: organizationalUnit
objectClass: top
ou: groups

dn: ou=users,{{ cat "dc=" .Values.ldapDomain | replace "." ",dc=" | nospace }}
changetype: add
objectClass: organizationalUnit
objectClass: top
ou: users

dn: ou=system,{{ cat "dc=" .Values.ldapDomain | replace "." ",dc=" | nospace }}
changetype: add
objectClass: organizationalUnit
objectClass: top
ou: system

{{ end }}