# bridge-history-api

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

bridge-history-api helm charts

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
| additionalContainers.redis.image | string | `"redis"` |  |
| additionalContainers.redis.name | string | `"redis"` |  |
| command[0] | string | `"/bin/sh"` |  |
| command[1] | string | `"-c"` |  |
| command[2] | string | `"bridgehistoryapi-api --config /app/conf/bridge-history-config.json --metrics --metrics.addr 0.0.0.0 --metrics.port ${METRICS_PORT} --log.debug"` |  |
| controller.replicas | int | `1` |  |
| controller.strategy | string | `"RollingUpdate"` |  |
| controller.type | string | `"deployment"` |  |
| defaultProbes.custom | bool | `true` |  |
| defaultProbes.enabled | bool | `true` |  |
| defaultProbes.spec.httpGet.path | string | `"/health"` |  |
| defaultProbes.spec.httpGet.port | int | `8090` |  |
| env[0].name | string | `"METRICS_PORT"` |  |
| env[0].value | string | `"8090"` |  |
| global.fullnameOverride | string | `"bridge-history-api"` |  |
| global.nameOverride | string | `"bridge-history-api"` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"scrolltech/bridgehistoryapi-api"` |  |
| image.tag | string | `"v4.4.14"` |  |
| ingress.main.annotations | object | `{}` |  |
| ingress.main.enabled | bool | `true` |  |
| ingress.main.hosts[0].host | string | `"bridge-history-api.scrollsdk"` |  |
| ingress.main.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.main.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.main.ingressClassName | string | `"nginx"` |  |
| ingress.main.labels | object | `{}` |  |
| ingress.main.primary | bool | `true` |  |
| initContainers.1-wait-for-l1.command[0] | string | `"/bin/sh"` |  |
| initContainers.1-wait-for-l1.command[1] | string | `"-c"` |  |
| initContainers.1-wait-for-l1.command[2] | string | `"/wait-for-l1.sh $SCROLL_L1_RPC"` |  |
| initContainers.1-wait-for-l1.envFrom[0].configMapRef.name | string | `"bridge-history-api-env"` |  |
| initContainers.1-wait-for-l1.image | string | `"scrolltech/scroll-alpine:v0.0.1"` |  |
| initContainers.1-wait-for-l1.volumeMounts[0].mountPath | string | `"/wait-for-l1.sh"` |  |
| initContainers.1-wait-for-l1.volumeMounts[0].name | string | `"wait-for-l1-script"` |  |
| initContainers.1-wait-for-l1.volumeMounts[0].subPath | string | `"wait-for-l1.sh"` |  |
| initContainers.2-wait-for-l2-sequencer.args[0] | string | `"http"` |  |
| initContainers.2-wait-for-l2-sequencer.args[1] | string | `"$(SCROLL_L2_RPC)"` |  |
| initContainers.2-wait-for-l2-sequencer.args[2] | string | `"--expect-status-code"` |  |
| initContainers.2-wait-for-l2-sequencer.args[3] | string | `"200"` |  |
| initContainers.2-wait-for-l2-sequencer.args[4] | string | `"--timeout"` |  |
| initContainers.2-wait-for-l2-sequencer.args[5] | string | `"0"` |  |
| initContainers.2-wait-for-l2-sequencer.envFrom[0].configMapRef.name | string | `"bridge-history-api-env"` |  |
| initContainers.2-wait-for-l2-sequencer.image | string | `"atkrad/wait4x:latest"` |  |
| persistence.bridge-history-api.enabled | bool | `true` |  |
| persistence.bridge-history-api.mountPath | string | `"/app/conf/"` |  |
| persistence.bridge-history-api.name | string | `"bridge-history-config"` |  |
| persistence.bridge-history-api.type | string | `"configMap"` |  |
| persistence.wait-for-l1-script.defaultMode | string | `"0777"` |  |
| persistence.wait-for-l1-script.enabled | bool | `true` |  |
| persistence.wait-for-l1-script.name | string | `"wait-for-l1-script"` |  |
| persistence.wait-for-l1-script.type | string | `"configMap"` |  |
| probes.liveness.<<.custom | bool | `true` |  |
| probes.liveness.<<.enabled | bool | `true` |  |
| probes.liveness.<<.spec.httpGet.path | string | `"/health"` |  |
| probes.liveness.<<.spec.httpGet.port | int | `8090` |  |
| probes.readiness.<<.custom | bool | `true` |  |
| probes.readiness.<<.enabled | bool | `true` |  |
| probes.readiness.<<.spec.httpGet.path | string | `"/health"` |  |
| probes.readiness.<<.spec.httpGet.port | int | `8090` |  |
| probes.startup.<<.custom | bool | `true` |  |
| probes.startup.<<.enabled | bool | `true` |  |
| probes.startup.<<.spec.httpGet.path | string | `"/health"` |  |
| probes.startup.<<.spec.httpGet.port | int | `8090` |  |
| resources.limits.cpu | string | `"100m"` |  |
| resources.limits.memory | string | `"500Mi"` |  |
| resources.requests.cpu | string | `"50m"` |  |
| resources.requests.memory | string | `"100Mi"` |  |
| service.main.enabled | bool | `true` |  |
| service.main.ports.http.enabled | bool | `true` |  |
| service.main.ports.http.port | int | `8080` |  |
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
