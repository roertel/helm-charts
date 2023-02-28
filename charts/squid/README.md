# squid-guardian

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 5.6-22.10_beta](https://img.shields.io/badge/AppVersion-5.6--22.10_beta-informational?style=flat-square)

A Helm chart to run Squid with e2Guardian on Kubernetes.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| roertel | <roertel@users.noreply.github.com> |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| replicaCount | int | `1` | Number of replicas to start. |
| configuration | string | `nil` | main (squid.conf) configuration file override. |
| extraConfiguration | object | `{}` | Configuration snippets to add. NOTE: This will remove some default configurations. |
| extraEnv | object | `{}` | Extra environment variables. Consider TZ=UTC. |
| image.repository | string | `"ubuntu/squid"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| fullnameOverride | string | `""` |  |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created. |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account. |
| serviceAccount.name | string | `""` | If not set and create is true, a name is generated using the fullname template. |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.type | string | `"ClusterIP"` |  |
| service.port | int | `3128` |  |
| ingress.enabled | bool | `false` |  |
| ingress.className | string | `""` |  |
| ingress.annotations | object | `{}` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| resources | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| nodeSelector | object | `{}` |  |
| tolerations | list | `[]` |  |
| affinity | object | `{}` |  |
| livenessProbe.enabled | bool | `true` | Enable the probe |
| livenessProbe.failureThreshold | int | `nil` | Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1. |
| livenessProbe.initialDelaySeconds | int | `nil` | Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes |
| livenessProbe.periodSeconds | int | `nil` | How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1. |
| livenessProbe.successThreshold | int | `nil` | Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1. |
| livenessProbe.terminationGracePeriodSeconds | int | `nil` | Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset. |
| livenessProbe.timeoutSeconds | int | `nil` | Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes |
| readinessProbe.enabled | bool | `true` | Enable the probe |
| readinessProbe.failureThreshold | int | `nil` | Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1. |
| readinessProbe.initialDelaySeconds | int | `nil` | Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes |
| readinessProbe.periodSeconds | int | `nil` | How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1. |
| readinessProbe.successThreshold | int | `nil` | Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1. |
| readinessProbe.terminationGracePeriodSeconds | int | `nil` | Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset. |
| readinessProbe.timeoutSeconds | int | `nil` | Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes |
| e2guardian | object | `{"enabled":false}` | Settings for e2Guardian sub-chart |
| e2guardian.enabled | bool | `false` | Enable e2Guardian |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
