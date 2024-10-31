# chain-monitor

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

chain-monitor helm charts

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| scroll-tech | <sebastien@scroll.io> |  |

## Requirements

Kubernetes: `>=1.22.0-0`

| Repository | Name | Version |
|------------|------|---------|
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | common | 1.5.1 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | external-secrets-lib | 0.0.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| command[0] | string | `"/bin/sh"` |  |
| command[1] | string | `"-c"` |  |
| command[2] | string | `"chain-monitor --config /app/config/chain-monitor-config.json --http --http.port ${CHAIN_MONITOR_SERVER_PORT} --metrics --metrics.addr 0.0.0.0 --metrics.port ${CHAIN_MONITOR_METRICS_PORT} --verbosity 3"` |  |
| defaultProbes.enabled | bool | `false` |  |
| envFrom[0].configMapRef.name | string | `"chain-monitor-env"` |  |
| env[0].name | string | `"CHAIN_MONITOR_SERVER_PORT"` |  |
| env[0].value | int | `8080` |  |
| env[1].name | string | `"CHAIN_MONITOR_METRICS_PORT"` |  |
| env[1].value | int | `8090` |  |
| global.fullnameOverride | string | `"chain-monitor"` |  |
| global.nameOverride | string | `"chain-monitor"` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"scrolltech/chain-monitorv2"` |  |
| image.tag | string | `"v1.1.29"` |  |
| initContainers.1-check-postgres-connection.args[0] | string | `"postgresql"` |  |
| initContainers.1-check-postgres-connection.args[1] | string | `"$(SCROLL_CHAIN_MONITOR_DB_CONFIG_DSN)"` |  |
| initContainers.1-check-postgres-connection.args[2] | string | `"--timeout"` |  |
| initContainers.1-check-postgres-connection.args[3] | string | `"0"` |  |
| initContainers.1-check-postgres-connection.envFrom[0].configMapRef.name | string | `"chain-monitor-env"` |  |
| initContainers.1-check-postgres-connection.image | string | `"atkrad/wait4x:latest"` |  |
| initContainers.2-migrate-db.command[0] | string | `"/bin/sh"` |  |
| initContainers.2-migrate-db.command[1] | string | `"-c"` |  |
| initContainers.2-migrate-db.command[2] | string | `"chain-monitor --config /app/config/chain-monitor-config.json --db --db.migrate"` |  |
| initContainers.2-migrate-db.envFrom[0].configMapRef.name | string | `"chain-monitor-env"` |  |
| initContainers.2-migrate-db.image | string | `"scrolltech/chain-monitorv2:v1.1.29"` |  |
| initContainers.2-migrate-db.volumeMounts[0].mountPath | string | `"/app/config/"` |  |
| initContainers.2-migrate-db.volumeMounts[0].name | string | `"chain-monitor"` |  |
| initContainers.3-wait-for-l1.command[0] | string | `"/bin/sh"` |  |
| initContainers.3-wait-for-l1.command[1] | string | `"-c"` |  |
| initContainers.3-wait-for-l1.command[2] | string | `"/wait-for-l1.sh $SCROLL_L1_RPC"` |  |
| initContainers.3-wait-for-l1.envFrom[0].configMapRef.name | string | `"chain-monitor-env"` |  |
| initContainers.3-wait-for-l1.image | string | `"scrolltech/scroll-alpine:v0.0.1"` |  |
| initContainers.3-wait-for-l1.volumeMounts[0].mountPath | string | `"/wait-for-l1.sh"` |  |
| initContainers.3-wait-for-l1.volumeMounts[0].name | string | `"wait-for-l1-script"` |  |
| initContainers.3-wait-for-l1.volumeMounts[0].subPath | string | `"wait-for-l1.sh"` |  |
| initContainers.4-wait-for-l2-sequencer.args[0] | string | `"http"` |  |
| initContainers.4-wait-for-l2-sequencer.args[1] | string | `"http://l2-sequencer:8545"` |  |
| initContainers.4-wait-for-l2-sequencer.args[2] | string | `"--expect-status-code"` |  |
| initContainers.4-wait-for-l2-sequencer.args[3] | string | `"200"` |  |
| initContainers.4-wait-for-l2-sequencer.args[4] | string | `"--timeout"` |  |
| initContainers.4-wait-for-l2-sequencer.args[5] | string | `"0"` |  |
| initContainers.4-wait-for-l2-sequencer.image | string | `"atkrad/wait4x:latest"` |  |
| initContainers.5-wait-for-contract.command[0] | string | `"/bin/sh"` |  |
| initContainers.5-wait-for-contract.command[1] | string | `"-c"` |  |
| initContainers.5-wait-for-contract.command[2] | string | `"/wait-for-contract.sh $SCROLL_L1_RPC $L1_SCROLL_CHAIN_PROXY_ADDR"` |  |
| initContainers.5-wait-for-contract.envFrom[0].configMapRef.name | string | `"chain-monitor-env"` |  |
| initContainers.5-wait-for-contract.image | string | `"scrolltech/scroll-alpine:v0.0.1"` |  |
| initContainers.5-wait-for-contract.volumeMounts[0].mountPath | string | `"/wait-for-contract.sh"` |  |
| initContainers.5-wait-for-contract.volumeMounts[0].name | string | `"wait-for-contracts-script"` |  |
| initContainers.5-wait-for-contract.volumeMounts[0].subPath | string | `"wait-for-contract.sh"` |  |
| persistence.app_name.enabled | bool | `true` |  |
| persistence.app_name.mountPath | string | `"/app/config/"` |  |
| persistence.app_name.name | string | `"chain-monitor-config"` |  |
| persistence.app_name.type | string | `"configMap"` |  |
| persistence.wait-for-contracts-script.defaultMode | string | `"0777"` |  |
| persistence.wait-for-contracts-script.enabled | bool | `true` |  |
| persistence.wait-for-contracts-script.name | string | `"wait-for-contracts-script"` |  |
| persistence.wait-for-contracts-script.type | string | `"configMap"` |  |
| persistence.wait-for-l1-script.defaultMode | string | `"0777"` |  |
| persistence.wait-for-l1-script.enabled | bool | `true` |  |
| persistence.wait-for-l1-script.name | string | `"wait-for-l1-script"` |  |
| persistence.wait-for-l1-script.type | string | `"configMap"` |  |
| probes.liveness.<<.enabled | bool | `false` |  |
| probes.readiness.<<.enabled | bool | `false` |  |
| probes.startup.<<.enabled | bool | `false` |  |
| resources.limits.cpu | string | `"100m"` |  |
| resources.limits.memory | string | `"500Mi"` |  |
| resources.requests.cpu | string | `"50m"` |  |
| resources.requests.memory | string | `"100Mi"` |  |
| scrollConfig | string | `"{}\n"` |  |
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
