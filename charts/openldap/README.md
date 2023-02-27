# openldap

![Version: 2.4.58-2](https://img.shields.io/badge/Version-2.4.58--2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.1-1](https://img.shields.io/badge/AppVersion-1.0.1--1-informational?style=flat-square)

A Helm chart for OpenLDAP

**Homepage:** <https://github.com/roertel/helm-charts/charts/openldap>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| roertel | <roertel@users.noreply.github.com> |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../phpldapadmin | phpldapadmin | 0.1.4-0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| replicaCount | int | `1` | Number of replicas. Only 1 is currently supported. |
| image.repository | string | `"roertel/openldap"` | Image to use for deploying. |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.tag | string | `nil` | Override the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| fullnameOverride | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `101` |  |
| serviceAccount.create | bool | `false` | Specifies whether a service account should be created |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.name | string | `""` | If not set and create is true, a name is generated using the fullname template |
| service.type | string | `"ClusterIP"` | Service type. Change this to expose outside of K8s |
| service.port | int | `389` | Port to listen on |
| resources | object | `{}` |  |
| autoscaling.enabled | bool | `false` | Not supported at this time. |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| nodeSelector | object | `{}` |  |
| tolerations | list | `[]` |  |
| affinity | object | `{}` |  |
| tls.enabled | bool | `false` | Enable TLS (LDAPS). |
| tls.type | string | `"certificate"` | TLS source: certificate or secret |
| tls.secret | string | `"secret-name"` | Mandatory and created outside of Helm if `type` is `secret`. Must have key, cert & chain values. |
| tls.certificate | object | `{"commonName":"example.com","issuerRef":{"name":"default"},"optional":{}}` | Mandatory if `type` is `certificate`. |
| tls.certificate.issuerRef.name | string | `"default"` | This is most likely not correct for your setup. |
| tls.certificate.commonName | string | `"example.com"` | Set to the FQDN of your LDAP server |
| persistence.enabled | bool | `false` | Enable the database to persist across restarts. |
| persistence.size | string | `"1Gi"` | Database size. |
| persistence.storageClass | string | `"local-path"` | Storage Class for the persistent volume |
| ldapDomain | string | `"example.com"` | LDAP Domain in FQDN format. For example, `example.com` will convert to `dc=example,dc=com`. |
| ldapOrganization | string | `"Example Organization"` |  |
| slapd.secrets | object | `{}` |  |
| slapd.listeners.ldap.enabled | bool | `true` | Enable the LDAP protocol |
| slapd.listeners.ldap.scheme | string | `"ldap"` | Only ldap & ldaps is supported. |
| slapd.listeners.ldap.containerPort | int | `1389` | Set to >1024 to allow container to run as non-root user for improved security. |
| slapd.listeners.ldap.port | int | `389` | External port. |
| slapd.listeners.ldaps.enabled | bool | `false` | Enable the LDAPS protocol. LDAPS requires TLS into to be set, above. |
| slapd.listeners.ldaps.scheme | string | `"ldaps"` |  |
| slapd.listeners.ldaps.containerPort | int | `1636` | Set to >1024 to allow container to run as non-root user for improved security. |
| slapd.listeners.ldaps.port | int | `636` |  |
| slapd.listeners.extraEnv | object | `{}` | Extra environment variables to set. |
| phpldapadmin.enabled | bool | `true` | Enable PHPLDAPAdmin. See sub-chart for settings. |
| phpldapadmin.replicaCount | int | `1` |  |
| phpldapadmin.image.repository | string | `"osixia/phpldapadmin"` |  |
| phpldapadmin.image.pullPolicy | string | `"IfNotPresent"` |  |
| phpldapadmin.image.tag | string | `""` |  |
| phpldapadmin.imagePullSecrets | list | `[]` |  |
| phpldapadmin.nameOverride | string | `""` |  |
| phpldapadmin.fullnameOverride | string | `""` |  |
| phpldapadmin.serviceAccount.create | bool | `true` |  |
| phpldapadmin.serviceAccount.annotations | object | `{}` |  |
| phpldapadmin.serviceAccount.name | string | `""` |  |
| phpldapadmin.podAnnotations | object | `{}` |  |
| phpldapadmin.podSecurityContext | object | `{}` |  |
| phpldapadmin.securityContext | object | `{}` |  |
| phpldapadmin.service.type | string | `"ClusterIP"` |  |
| phpldapadmin.service.port | int | `80` |  |
| phpldapadmin.service.annotations | object | `{}` |  |
| phpldapadmin.ingress.enabled | bool | `false` |  |
| phpldapadmin.ingress.annotations | object | `{}` |  |
| phpldapadmin.ingress.hosts[0].host | string | `"chart-example.local"` |  |
| phpldapadmin.ingress.hosts[0].paths[0].path | string | `"/"` |  |
| phpldapadmin.ingress.hosts[0].paths[0].backend.serviceName | string | `"chart-example.local"` |  |
| phpldapadmin.ingress.hosts[0].paths[0].backend.servicePort | int | `80` |  |
| phpldapadmin.ingress.tls | list | `[]` |  |
| phpldapadmin.resources | object | `{}` |  |
| phpldapadmin.autoscaling.enabled | bool | `false` |  |
| phpldapadmin.autoscaling.minReplicas | int | `1` |  |
| phpldapadmin.autoscaling.maxReplicas | int | `100` |  |
| phpldapadmin.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| phpldapadmin.nodeSelector | object | `{}` |  |
| phpldapadmin.tolerations | list | `[]` |  |
| phpldapadmin.affinity | object | `{}` |  |
| phpldapadmin.env.PHPLDAPADMIN_HTTPS | string | `"false"` |  |
| phpldapadmin.env.PHPLDAPADMIN_TRUST_PROXY_SSL | string | `"true"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
