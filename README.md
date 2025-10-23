# helm-charts

A repository for helm charts. See the documentation for each chart in it's subdirectory.

|Chart Name|Chart Description|
|-|-|
|mariadb|MariaDB server.|
|mariadb-manifests|Helm chart to deploy a MariaDB with automated backups via the MariaDB operator.|
|minecraft-overviewer|Overviewer will generate Google maps-style pages for your Minecraft world.|
|ulogger-server|Self-hosted waypoint and GPS track logger.|

## General usage instructions

1. Add the repo
  `helm repo add roertel https://roertel.github.io/helm-charts/`
2. Install the chart
  `helm install <local name> <chart name>`

Alternatively, you can do it all in one command:
`helm install <local name> <chart name> --repo https://roertel.github.io/helm-charts`

Check each chart's README.md for customizable settings.
