# helm-charts

A repository for helm charts. See the documentation for each chart in it's subdirectory.

|Chart Name|Chart Description|
|-|-|
|mariadb|MariaDB server.|
|mariadb-operator|Helm chart to deploy a MariaDB with automated backups via the MariaDB operator.|
|minecraft-overviewer|Overviewer will generate Google maps-style pages for your Minecraft world.|
|nginx-default-backend|Default backend for nginx. Used for customizing HTTP error messages.|
|openldap|OpenLDAP server including PHPLDAPAdmin.|
|phpldapadmin|Web management of LDAP.|
|soft-serve|A tasty, self-hostable Git server for the command line|
|duplicity|Back up your PVCs with Duplicity.|

## General usage instructions

1. Add the repo
  `helm repo add roertel https://roertel.github.io/helm-charts/`
2. Install the chart
  `helm install <local name> <chart name>`

Alternatively, you can do it all in one command:
`helm install <local name> <chart name> --repo https://roertel.github.io/helm-charts`

Check each chart's README.md for customizable settings.
