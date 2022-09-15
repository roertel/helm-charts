{{- define "pre-init.ldif" }}
# One time initialization if the DB is not present. Executed via slapadd
dn: cn=config
objectClass: olcGlobal
cn: config
olcArgsFile: /ldap/run/slapd.args
olcPidFile: /ldap/run/slapd.pid
{{- if .Values.tls.enabled }}
olcTLSCACertificateFile: /ldap/tls/ca.crt
olcTLSCertificateFile: /ldap/tls/tls.crt
olcTLSCertificateKeyFile: /ldap/tls/tls.key
olcTLSCipherSuite: NORMAL
olcTLSProtocolMin: 3.3
{{- end }}

dn: cn=schema,cn=config
objectClass: olcSchemaConfig
cn: schema

include: file:///etc/ldap/schema/core.ldif
include: file:///etc/ldap/schema/cosine.ldif
include: file:///etc/ldap/schema/nis.ldif
include: file:///etc/ldap/schema/inetorgperson.ldif
include: file:///etc/ldap/schema/ppolicy.ldif

dn: cn=module,cn=config
objectClass: olcModuleList
cn: module
olcModulepath: /usr/lib/ldap
olcModuleload: back_mdb.la
olcModuleLoad: back_monitor.la
olcModuleload: pw-sha2.la

dn: olcDatabase=frontend,cn=config
objectClass: olcDatabaseConfig
objectClass: olcFrontendConfig
olcDatabase: frontend
olcPasswordHash: $LDAP_admin
olcAccess: to * 
  by dn.base="gidNumber={{ .Values.securityContext.runAsUser | default 0 }}+uidNumber={{ .Values.securityContext.runAsUser | default 0 }},cn=peercred,cn=external,cn=auth" manage 
  by * none

dn: olcDatabase=config,cn=config
objectClass: olcDatabaseConfig
olcDatabase: config
olcRootDN: cn=config
olcAccess: to * 
  by dn.base="gidNumber={{ .Values.securityContext.runAsUser | default 0 }}+uidNumber={{ .Values.securityContext.runAsUser | default 0 }},cn=peercred,cn=external,cn=auth" manage 
  by * none

dn: olcDatabase=monitor,cn=config
objectClass: olcDatabaseConfig
olcDatabase: monitor
olcAccess: to *
  by dn.subtree="gidNumber={{ .Values.securityContext.runAsUser | default 0 }}+uidNumber={{ .Values.securityContext.runAsUser | default 0 }},cn=peercred,cn=external,cn=auth" manage
  by * none

dn: olcDatabase=mdb,cn=config
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
{{- end }}