# openldap

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: latest](https://img.shields.io/badge/AppVersion-latest-informational?style=flat-square)

A Helm chart for Kubernetes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
|  | phpldapadmin | 0.1.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` | Not supported at this time.  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"roertel/openldap"` | Image to use for deploying. |
| image.tag | string | `"latest"` | Override the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` |  |
| ldapDomain | string | `"example.com"` | LDAP Domain in FQDN format. For example, `example.com` will convert to `dc=example,dc=com`.  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| persistence.enabled | bool | `false` | Enable the database to persist across restarts.  |
| persistence.size | string | `"1Gi"` | Database size.  |
| persistence.storageClass | string | `"local-path"` | Storage Class for the persistent volume |
| phpldapadmin.enabled | bool | `true` | Enable PHPLDAPAdmin. See subchart for settings. |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` | Number of replicas. Only 1 is currently supported.  |
| resources | object | `{}` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `101` |  |
| service.port | int | `389` | Port to listen on |
| service.type | string | `"ClusterIP"` | Service type. Change this to expose outside of K8s |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `false` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | If not set and create is true, a name is generated using the fullname template |
| slapd.listeners | object | `{"extraEnv":{},"ldap":{"containerPort":1389,"enabled":true,"port":389,"scheme":"ldap"},"ldaps":{"containerPort":1636,"enabled":false,"port":636,"scheme":"ldaps"}}` | Configure one or more listeners (LDAP and/or LDAPS). |
| slapd.listeners.extraEnv | object | `{}` | Extra environment variables to set. |
| slapd.listeners.ldap.containerPort | int | `1389` | Set to >1024 to allow container to run as non-root user for improved security. |
| slapd.listeners.ldap.port | int | `389` | External port. |
| slapd.listeners.ldap.scheme | string | `"ldap"` | Only ldap & ldaps is supported. |
| slapd.listeners.ldaps.enabled | bool | `false` | LDAPS requires TLS into to be set, above. |
| slapd.secrets | object | `{}` |  |
| tls.certificate | object | `{"commonName":"example.com","issuerRef":{"name":"default"},"optional":{}}` | Mandatory if `type` is `certificate`.  |
| tls.certificate.commonName | string | `"example.com"` | Set to the FQDN of your LDAP server |
| tls.certificate.issuerRef.name | string | `"default"` | This is most likely not correct for your setup. |
| tls.enabled | bool | `false` | Enable TLS (LDAPS). |
| tls.secret | string | `"secret-name"` | Mandatory and created outside of Helm if `type` is `secret`. Muse have key, cert & chain values. |
| tls.type | string | `"certificate"` | TLS source: certificate or secret |
| tolerations | list | `[]` |  |
