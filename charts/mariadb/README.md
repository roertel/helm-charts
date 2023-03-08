# mariadb

![Version: 10.10.3](https://img.shields.io/badge/Version-10.10.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 10.10.2](https://img.shields.io/badge/AppVersion-10.10.2-informational?style=flat-square)

A Helm chart for MariaDB

**Homepage:** <https://github.com/roertel/helm-charts/charts/mariadb>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| roertel | <roertel@users.noreply.github.com> |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| replicaCount | int | `1` | Number of replicas. Only 1 is currently supported. |
| image.repository | string | `"mariadb"` | Image to use for deploying. |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.tag | string | `nil` | Override the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| fullnameOverride | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext.fsGroup | int | `999` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` | Some temp files are required. You can mount a temp to emptyDir or RW root |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `999` |  |
| securityContext.runAsGroup | int | `999` |  |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.name | string | `""` | If not set and create is true, a name is generated using the fullname template |
| service.type | string | `"ClusterIP"` | Service type. Change this to expose outside of K8s |
| service.port | int | `3306` | Port to listen on |
| resources | object | `{}` |  |
| autoscaling.enabled | bool | `false` | Not supported at this time. |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.maxReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| nodeSelector | object | `{}` |  |
| tolerations | list | `[]` |  |
| affinity | object | `{}` |  |
| tls.enabled | bool | `false` | Enable TLS. |
| tls.required | bool | `true` | Require clients to connect with TLS? |
| tls.versions | string | `nil` | Allowed TLS versions (TLSv1.2,TLSv1.3) |
| tls.type | string | `"certificate"` | TLS source: certificate or secret |
| tls.secret | string | `"secret-name"` | key, cert & chain values. |
| tls.certificate | object | `{"commonName":"example.com","issuerRef":{"name":"default"},"optional":{}}` | Mandatory if `type` is `certificate`. |
| tls.certificate.issuerRef.name | string | `"default"` | This is most likely not correct for your setup. |
| tls.certificate.commonName | string | `"example.com"` | Set to the FQDN of your server |
| tls.image.repository | string | `"ghcr.io/roertel/docker-mariadb-tls-sidecar"` | Image to use for the TLS refresher sidecar |
| tls.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| tls.image.tag | string | `"1.0.0"` | Image tag |
| tls.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| tls.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| tls.securityContext.runAsNonRoot | bool | `true` |  |
| tls.securityContext.runAsUser | int | `999` |  |
| tls.securityContext.runAsGroup | int | `999` |  |
| persistence.enabled | bool | `false` | Enable the database to persist across restarts. |
| persistence.size | string | `"1Gi"` | Database size. |
| persistence.storageClass | string | `"local-path"` | Storage Class for the persistent volume |
| startupProbe.enabled | bool | `true` | Enable the startup probe |
| readinessProbe.enabled | bool | `true` | Enable the readiness probe |
| livenessProbe.enabled | bool | `true` | Enable the liveness probe |
| ldap.enabled | bool | `false` | Enable LDAP authentication to MariaDB |
| ldap.image.repository | string | `"ghcr.io/roertel/docker-nslcd-sidecar"` | Image to use for the LDAP sidecar |
| ldap.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| ldap.image.tag | string | `"v1.0.0"` | Image tag |
| ldap.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| ldap.securityContext.readOnlyRootFilesystem | bool | `false` | Needs to be false if templates are in use |
| ldap.securityContext.runAsNonRoot | bool | `true` |  |
| ldap.securityContext.runAsUser | int | `999` |  |
| ldap.securityContext.runAsGroup | int | `999` |  |
| ldap.uri | string | `"ldaps://ldap.example.com/"` | LDAP URI or comma-delimited URI list |
| ldap.base | string | `"dc=example,dc=com"` | LDAP search base in DC= format |
| ldap.bindDn | string | `"cn=bind,ou=system,dc=example,dc=com"` | LDAP bind user |
| ldap.bindPw | string | `"SecretPasswordChangeMe"` | LDAP bind password |
| ldap.extraEnv | object | `{}` | Extra environment variables to set. |
| ldap.extraArgs | list | `[]` | Extra arguments to pass to nslcd |
| mysqld.rootPassword | string | `nil` | Administrative (root) password or one will be generated for you |
| mysqld.extraEnv | object | `{}` | See https://github.com/docker-library/docs/tree/master/mariadb#environment-variables |
| mysqld.extraArgs | list | `[]` | Extra arguments to pass to mysqld |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
