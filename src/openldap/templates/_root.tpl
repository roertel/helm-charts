{{- define "root.ldif" }}
# Initialize the root (user) database
dn: olcDatabase=mdb,cn=config
objectClass: olcDatabaseConfig
objectClass: olcMdbConfig
olcDatabase: mdb
olcSuffix: {{ .ldapSuffix }}
olcRootDN: cn=admin,$LDAP_suffix
olcRootPW: $LDAP_admin
olcDbDirectory: /ldapdata
olcDbIndex: objectClass,uid,uidNumber,gidNumber eq
olcDbMaxSize: 10485760
olcAccess: to attrs=userPassword
  by self write
  by anonymous auth
  by dn.subtree="uidNumber={{ .Values.securityContext.runAsUser | default 0 }},cn=peercred,cn=external,cn=auth" manage
  by * none
olcAccess: to attrs=shadowLastChange by self write
  by dn.subtree="uidNumber={{ .Values.securityContext.runAsUser | default 0 }},cn=peercred,cn=external,cn=auth" manage
  by dn.subtree="ou=system,$LDAP_suffix" read
  by * none
olcAccess: to dn.subtree="ou=system,$LDAP_suffix" 
  by dn.subtree="uidNumber={{ .Values.securityContext.runAsUser | default 0 }},cn=peercred,cn=external,cn=auth" manage
  by * none
olcAccess: to dn.subtree="$LDAP_suffix" 
  by dn.subtree="uidNumber={{ .Values.securityContext.runAsUser | default 0 }},cn=peercred,cn=external,cn=auth" manage
  by users read 
  by * none
{{- end }}
