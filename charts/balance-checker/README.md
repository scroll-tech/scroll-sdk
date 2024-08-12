# balance-checker

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

balance-checker helm charts

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| scroll-tech | <sebastien@scroll.io> |  |

## Requirements

Kubernetes: `>=1.22.0-0`

| Repository | Name | Version |
|------------|------|---------|
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | common | 1.5.1 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | external-secrets-lib | 0.0.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| defaultProbes.custom | bool | `true` |  |
| defaultProbes.enabled | bool | `true` |  |
| defaultProbes.spec.httpGet.path | string | `"/"` |  |
| defaultProbes.spec.httpGet.port | int | `8090` |  |
| env[0].name | string | `"CONFIG_PATH"` |  |
| env[0].value | string | `"app/config/balance-checker-config.json"` |  |
| env[1].name | string | `"BIND_PORT"` |  |
| env[1].value | string | `"8080"` |  |
| env[2].name | string | `"METRICS_PORT"` |  |
| env[2].value | string | `"8090"` |  |
| env[3].name | string | `"METRICS_URL"` |  |
| env[3].value | string | `"0.0.0.0"` |  |
| env[4].name | string | `"SLACK_NOTIFY_URL"` |  |
| env[4].value | string | `""` |  |
| global.fullnameOverride | string | `"balance-checker"` |  |
| global.nameOverride | string | `"balance-checker"` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"scrolltech/balance-checker"` |  |
| image.tag | string | `"0.0.2"` |  |
| initContainers.1-wait-for-l1.command[0] | string | `"/bin/sh"` |  |
| initContainers.1-wait-for-l1.command[1] | string | `"-c"` |  |
| initContainers.1-wait-for-l1.command[2] | string | `"/wait-for-l1.sh $SCROLL_L1_RPC"` |  |
| initContainers.1-wait-for-l1.envFrom[0].configMapRef.name | string | `"balance-checker-env"` |  |
| initContainers.1-wait-for-l1.image | string | `"scrolltech/scroll-alpine:v0.0.1"` |  |
| initContainers.1-wait-for-l1.volumeMounts[0].mountPath | string | `"/wait-for-l1.sh"` |  |
| initContainers.1-wait-for-l1.volumeMounts[0].name | string | `"wait-for-l1-script"` |  |
| initContainers.1-wait-for-l1.volumeMounts[0].subPath | string | `"wait-for-l1.sh"` |  |
| initContainers.2-wait-for-l2-rpc.args[0] | string | `"http"` |  |
| initContainers.2-wait-for-l2-rpc.args[1] | string | `"http://l2-rpc:8545"` |  |
| initContainers.2-wait-for-l2-rpc.args[2] | string | `"--expect-status-code"` |  |
| initContainers.2-wait-for-l2-rpc.args[3] | string | `"200"` |  |
| initContainers.2-wait-for-l2-rpc.args[4] | string | `"--timeout"` |  |
| initContainers.2-wait-for-l2-rpc.args[5] | string | `"0"` |  |
| initContainers.2-wait-for-l2-rpc.image | string | `"atkrad/wait4x:latest"` |  |
| persistence.app_name.enabled | bool | `true` |  |
| persistence.app_name.mountPath | string | `"/app/config/"` |  |
| persistence.app_name.name | string | `"balance-checker-config"` |  |
| persistence.app_name.type | string | `"configMap"` |  |
| persistence.env.enabled | bool | `true` |  |
| persistence.env.mountPath | string | `"/config/"` |  |
| persistence.env.name | string | `"balance-checker-env"` |  |
| persistence.env.type | string | `"configMap"` |  |
| persistence.wait-for-l1-script.defaultMode | string | `"0777"` |  |
| persistence.wait-for-l1-script.enabled | bool | `true` |  |
| persistence.wait-for-l1-script.name | string | `"wait-for-l1-script"` |  |
| persistence.wait-for-l1-script.type | string | `"configMap"` |  |
| probes.liveness.<<.custom | bool | `true` |  |
| probes.liveness.<<.enabled | bool | `true` |  |
| probes.liveness.<<.spec.httpGet.path | string | `"/"` |  |
| probes.liveness.<<.spec.httpGet.port | int | `8090` |  |
| probes.readiness.<<.custom | bool | `true` |  |
| probes.readiness.<<.enabled | bool | `true` |  |
| probes.readiness.<<.spec.httpGet.path | string | `"/"` |  |
| probes.readiness.<<.spec.httpGet.port | int | `8090` |  |
| probes.startup.<<.custom | bool | `true` |  |
| probes.startup.<<.enabled | bool | `true` |  |
| probes.startup.<<.spec.httpGet.path | string | `"/"` |  |
| probes.startup.<<.spec.httpGet.port | int | `8090` |  |
| resources.limits.cpu | string | `"100m"` |  |
| resources.limits.memory | string | `"500Mi"` |  |
| resources.requests.cpu | string | `"50m"` |  |
| resources.requests.memory | string | `"100Mi"` |  |
| service.main.enabled | bool | `true` |  |
| service.main.ports.http.enabled | bool | `true` |  |
| service.main.ports.http.port | int | `80` |  |
| service.main.ports.metrics.enabled | bool | `true` |  |
| service.main.ports.metrics.port | int | `8090` |  |
| service.main.ports.metrics.targetPort | int | `8090` |  |
| serviceMonitor.main.enabled | bool | `true` |  |
| serviceMonitor.main.endpoints[0].interval | string | `"1m"` |  |
| serviceMonitor.main.endpoints[0].port | string | `"metrics"` |  |
| serviceMonitor.main.endpoints[0].scrapeTimeout | string | `"10s"` |  |
| serviceMonitor.main.labels.release | string | `"scroll-sdk"` |  |
| serviceMonitor.main.serviceName | string | `"{{ include \"scroll.common.lib.chart.names.fullname\" $ }}"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
