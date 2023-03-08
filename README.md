# helm-charts

A repository for helm charts. See the documentation for each chart in it's subdirectory.

|Chart Name|Chart Description|
|-|-|
|minecraft-overviewer|Overviewer will generate Google maps-style pages for your Minecraft world.|
|openldap|OpenLDAP server including PHPLDAPAdmin.|
|mariadb|MariaDB server.|

## General usage instructions

1. Add the repo
  `helm repo add roertel https://roertel.github.io/helm-charts/`
2. Install the chart
  `helm install <local name> <chart name>`

Alternatively, you can do it all in one command:
`helm install <local name> <chart name> --repo https://roertel.github.io/helm-charts`
