# openldap

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: latest](https://img.shields.io/badge/AppVersion-latest-informational?style=flat-square)

A Helm chart for Kubernetes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
|  | phpldapadmin | 0.1.x |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"roertel/openldap"` |  |
| image.tag | string | `"latest"` |  |
| imagePullSecrets | list | `[]` |  |
| ldapDomain | string | `"example.com"` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| persistence.enabled | bool | `false` |  |
| persistence.size | string | `"1Gi"` |  |
| persistence.storageClass | string | `"nfs"` |  |
| phpldapadmin.enabled | bool | `true` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `101` |  |
| service.port | int | `389` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `false` |  |
| serviceAccount.name | string | `""` |  |
| slapd.listeners.ldap.containerPort | int | `1389` |  |
| slapd.listeners.ldap.enabled | bool | `true` |  |
| slapd.listeners.ldap.port | int | `389` |  |
| slapd.listeners.ldap.scheme | string | `"ldap"` |  |
| slapd.listeners.ldaps.containerPort | int | `1636` |  |
| slapd.listeners.ldaps.enabled | bool | `false` |  |
| slapd.listeners.ldaps.port | int | `636` |  |
| slapd.listeners.ldaps.scheme | string | `"ldaps"` |  |
| tls.certificate.commonName | string | `"example.com"` |  |
| tls.certificate.issuerRef.name | string | `"default"` |  |
| tls.certificate.optional | object | `{}` |  |
| tls.enabled | bool | `false` |  |
| tls.secret | string | `"secret-name"` |  |
| tls.type | string | `"certificate"` |  |
| tolerations | list | `[]` |  |

