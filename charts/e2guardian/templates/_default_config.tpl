{{/*
Default configuration file from source.
https://github.com/e2guardian/e2guardian/blob/v5.5/configs/e2guardian.conf.in
*/}}
{{- define "e2guardian.conf" -}}
language = 'ukenglish'
dockermode = on
icapport = 1344
languagedir = '/usr/share/e2guardian/languages'
cacertificatepath = '/etc/e2guardian/private/ca.pem'
caprivatekeypath = '/etc/e2guardian/private/ca.key'
certprivatekeypath = '/etc/e2guardian/private/cert.key'
generatedcertpath = '/etc/e2guardian/private/generatedcerts/'
sitelist = 'name=nomitm,path=__LISTDIR__/nomitmsitelist'
ipsitelist = 'name=nomitm,path=__LISTDIR__/nomitmsiteiplist'
maplist = 'name=defaultusermap, path=__LISTDIR__/../authplugins/filtergroupslist'
ipmaplist = 'name=ipmap, path=__LISTDIR__/../authplugins/ipgroups'
maplist = 'name=portmap, path=__LISTDIR__/../authplugins/portgroups'
iplist = 'name=bannedclient,messageno=100,logmessageno=103,path=__LISTDIR__/bannediplist'
iplist = 'name=exceptionclient,messageno=600,path=__LISTDIR__/exceptioniplist'
reverseclientiplookups = off
ipsitelist = 'name=authexception,messageno=602,path=__LISTDIR__/authexceptioniplist'
sitelist = 'name=authexception,messageno=602,path=__LISTDIR__/authexceptionsitelist'
urllist = 'name=authexception,messageno=603,path=__LISTDIR__/authexceptionurllist'
regexpboollist = 'name=browser,path=__LISTDIR__/browserregexplist'
dstatlocation = '/var/log/e2guardian/dstats.log'
reverseaddresslookups = off
usexforwardedfor = off
downloadmanager = '/etc/e2guardian/downloadmanagers/default.conf'
weightedphrasemode = 2
pidfilename = /run/e2guardian/e2.pid
originalip = off
set_error = 'stdout:LOG_ERR'
set_warning = 'stdout:LOG_WARNING'
{{- end }}
