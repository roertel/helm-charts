# minecraft-overviewer

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.17.0](https://img.shields.io/badge/AppVersion-0.17.0-informational?style=flat-square)

A Helm chart for Minecraft Overviewer

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| config.files."config.py" | string | `"worlds[\"World\"] = \"/srv/world\"\noutputdir = \"/tmp/overviewer\"\ntexturepath = \"/srv/minecraft_server.1.17.1.jar\"\nrenders[\"day\"] = {\n        \"world\": \"World\",\n        \"title\": \"Daytime\",\n        \"rendermode\": \"smooth_lighting\",\n        \"dimension\": \"overworld\"\n}\nrenders[\"night\"] = {\n        \"world\": \"World\",\n        \"title\": \"Nighttime\",\n        \"rendermode\": \"smooth_night\",\n        \"dimension\": \"overworld\"\n}\nrenders[\"nether\"] = {\n        \"world\": \"World\",\n        \"title\": \"Nether\",\n        \"rendermode\": \"nether_smooth_lighting\",\n        \"dimension\": \"nether\"\n}\n"` |  |
| fullnameOverride | string | `""` |  |
| image.display.pullPolicy | string | `"IfNotPresent"` |  |
| image.display.repository | string | `"nginx"` |  |
| image.display.tag | string | `"stable"` |  |
| image.renderer.pullPolicy | string | `"IfNotPresent"` |  |
| image.renderer.repository | string | `"mide/minecraft-overviewer"` |  |
| image.renderer.tag | string | `"latest"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"minecraft-overviewer.local"` |  |
| ingress.hosts[0].paths[0].backend.serviceName | string | `"minecraft-overviewer.local"` |  |
| ingress.hosts[0].paths[0].backend.servicePort | int | `80` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.tls | list | `[]` |  |
| map.persistent | bool | `false` |  |
| map.size | string | `"1Gi"` |  |
| map.storageClassName | string | `""` |  |
| minecraftVersion | string | `"1.17"` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext.fsGroup | int | `2000` |  |
| regenerationSchedule | string | `"@daily"` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |
| world | object | `{}` |  |

