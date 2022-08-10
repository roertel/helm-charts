{{- define "base.ldif" }}
# Initialize the base (user) database. Changes to this file will only run on first-time initialization. 
dn: olcDatabase=mdb,cn=config
objectClass: olcDatabaseConfig
objectClass: olcMdbConfig
olcDatabase: mdb
olcSuffix: $LDAPBASE
olcRootDN: cn=admin,$LDAPBASE
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
  by dn.subtree="ou=system,$LDAPBASE" read
  by * none
olcAccess: to dn.subtree="ou=system,$LDAPBASE" 
  by dn.subtree="uidNumber={{ .Values.securityContext.runAsUser | default 0 }},cn=peercred,cn=external,cn=auth" manage
  by * none
olcAccess: to dn.subtree="$LDAPBASE" 
  by dn.subtree="uidNumber={{ .Values.securityContext.runAsUser | default 0 }},cn=peercred,cn=external,cn=auth" manage
  by users read 
  by * none
{{- end }}
