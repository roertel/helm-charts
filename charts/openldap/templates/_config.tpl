{{ define "config.ldif" }}
# Executed after LDAP is started and with subsequent restarts. 
# May be run more than once. Executed via ldapmodify -ca as an admin.
# Script will be filtered through envsubst prior to running. 
dn: olcDatabase=mdb,cn=config
changetype: add
objectClass: olcDatabaseConfig
objectClass: olcMdbConfig
olcDatabase: mdb
olcSuffix: $LDAPBASE
olcRootDN: cn=admin,$LDAPBASE
olcRootPW: $LDAP_admin
olcDbDirectory: /ldap/slapd.d
olcDbIndex: objectClass,uid,uidNumber,gidNumber eq
olcDbMaxSize: 10485760
olcAccess: to attrs=userPassword
  by self write
  by anonymous auth
  by dn.subtree="gidNumber={{ .Values.securityContext.runAsUser | default 0 }}+uidNumber={{ .Values.securityContext.runAsUser | default 0 }},cn=peercred,cn=external,cn=auth" manage
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

dn: $LDAPBASE
changetype: add
objectClass: dcObject
objectClass: organization
objectClass: top
o:
dc: 

dn: ou=groups,$LDAPBASE
changetype: add
objectClass: organizationalUnit
objectClass: top
ou: groups

dn: ou=users,$LDAPBASE
changetype: add
objectClass: organizationalUnit
objectClass: top
ou: users

dn: ou=system,$LDAPBASE
changetype: add
objectClass: organizationalUnit
objectClass: top
ou: system

{{ end }}