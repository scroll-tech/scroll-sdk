# rollup-node

![Version: 0.0.9](https://img.shields.io/badge/Version-0.0.9-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

rollup-node helm charts

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
| command[2] | string | `"rollup_relayer --config /app/conf/rollup-config.json --genesis /app/genesis/genesis.json --import-genesis --metrics --metrics.addr 0.0.0.0 --metrics.port ${METRICS_PORT} --log.debug --verbosity 3"` |  |
| configMaps.migrate-db.data."migrate-db.json" | string | `"{\n    \"driver_name\": \"postgres\",\n    \"dsn\": \"\"\n}\n"` |  |
| configMaps.migrate-db.enabled | bool | `true` |  |
| controller.replicas | int | `1` |  |
| controller.strategy | string | `"Recreate"` |  |
| controller.type | string | `"deployment"` |  |
| envFrom[0].configMapRef.name | string | `"rollup-node-env"` |  |
| env[0].name | string | `"METRICS_PORT"` |  |
| env[0].value | int | `8090` |  |
| global.fullnameOverride | string | `"rollup-node"` |  |
| global.nameOverride | string | `"rollup-node"` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"scrolltech/rollup-relayer"` |  |
| image.tag | string | `"v4.4.60"` |  |
| initContainers.1-check-postgres-connection.args[0] | string | `"postgresql"` |  |
| initContainers.1-check-postgres-connection.args[1] | string | `"$(SCROLL_ROLLUP_DB_CONFIG_DSN)"` |  |
| initContainers.1-check-postgres-connection.args[2] | string | `"--timeout"` |  |
| initContainers.1-check-postgres-connection.args[3] | string | `"0"` |  |
| initContainers.1-check-postgres-connection.envFrom[0].configMapRef.name | string | `"rollup-node-env"` |  |
| initContainers.1-check-postgres-connection.image | string | `"atkrad/wait4x:latest"` |  |
| initContainers.2-migrate-db.command[0] | string | `"/bin/sh"` |  |
| initContainers.2-migrate-db.command[1] | string | `"-c"` |  |
| initContainers.2-migrate-db.command[2] | string | `"db_cli migrate --config /config/migrate-db.json"` |  |
| initContainers.2-migrate-db.envFrom[0].configMapRef.name | string | `"rollup-node-env"` |  |
| initContainers.2-migrate-db.image | string | `"scrolltech/rollup-db-cli:v4.4.60"` |  |
| initContainers.2-migrate-db.volumeMounts[0].mountPath | string | `"/config/migrate-db.json"` |  |
| initContainers.2-migrate-db.volumeMounts[0].name | string | `"migrate-db"` |  |
| initContainers.2-migrate-db.volumeMounts[0].subPath | string | `"migrate-db.json"` |  |
| initContainers.3-wait-for-l1.command[0] | string | `"/bin/sh"` |  |
| initContainers.3-wait-for-l1.command[1] | string | `"-c"` |  |
| initContainers.3-wait-for-l1.command[2] | string | `"/wait-for-l1.sh $L1_RPC_ENDPOINT"` |  |
| initContainers.3-wait-for-l1.envFrom[0].configMapRef.name | string | `"rollup-node-env"` |  |
| initContainers.3-wait-for-l1.image | string | `"scrolltech/scroll-alpine:v0.0.1"` |  |
| initContainers.3-wait-for-l1.volumeMounts[0].mountPath | string | `"/wait-for-l1.sh"` |  |
| initContainers.3-wait-for-l1.volumeMounts[0].name | string | `"wait-for-l1-script"` |  |
| initContainers.3-wait-for-l1.volumeMounts[0].subPath | string | `"wait-for-l1.sh"` |  |
| initContainers.4-wait-for-contract.command[0] | string | `"/bin/sh"` |  |
| initContainers.4-wait-for-contract.command[1] | string | `"-c"` |  |
| initContainers.4-wait-for-contract.command[2] | string | `"/wait-for-contract.sh $L1_RPC_ENDPOINT $L1_SCROLL_CHAIN_PROXY_ADDR"` |  |
| initContainers.4-wait-for-contract.envFrom[0].configMapRef.name | string | `"rollup-node-env"` |  |
| initContainers.4-wait-for-contract.image | string | `"scrolltech/scroll-alpine:v0.0.1"` |  |
| initContainers.4-wait-for-contract.volumeMounts[0].mountPath | string | `"/wait-for-contract.sh"` |  |
| initContainers.4-wait-for-contract.volumeMounts[0].name | string | `"wait-for-contracts-script"` |  |
| initContainers.4-wait-for-contract.volumeMounts[0].subPath | string | `"wait-for-contract.sh"` |  |
| persistence.app_name.enabled | bool | `true` |  |
| persistence.app_name.mountPath | string | `"/app/conf/"` |  |
| persistence.app_name.name | string | `"rollup-config"` |  |
| persistence.app_name.type | string | `"configMap"` |  |
| persistence.genesis.enabled | bool | `true` |  |
| persistence.genesis.mountPath | string | `"/app/genesis/"` |  |
| persistence.genesis.name | string | `"genesis-config"` |  |
| persistence.genesis.type | string | `"configMap"` |  |
| persistence.migrate-db.defaultMode | string | `"0777"` |  |
| persistence.migrate-db.enabled | bool | `true` |  |
| persistence.migrate-db.mountPath | string | `"/config/migrate-db.json"` |  |
| persistence.migrate-db.name | string | `"rollup-node-migrate-db"` |  |
| persistence.migrate-db.type | string | `"configMap"` |  |
| persistence.wait-for-contracts-script.defaultMode | string | `"0777"` |  |
| persistence.wait-for-contracts-script.enabled | string | `"yes"` |  |
| persistence.wait-for-contracts-script.name | string | `"wait-for-contracts-script"` |  |
| persistence.wait-for-contracts-script.type | string | `"configMap"` |  |
| persistence.wait-for-l1-script.defaultMode | string | `"0777"` |  |
| persistence.wait-for-l1-script.enabled | bool | `true` |  |
| persistence.wait-for-l1-script.name | string | `"wait-for-l1-script"` |  |
| persistence.wait-for-l1-script.type | string | `"configMap"` |  |
| probes.liveness.enabled | bool | `false` |  |
| probes.readiness.enabled | bool | `false` |  |
| probes.startup.enabled | bool | `false` |  |
| resources.limits.cpu | string | `"100m"` |  |
| resources.limits.memory | string | `"200Mi"` |  |
| resources.requests.cpu | string | `"50m"` |  |
| resources.requests.memory | string | `"50Mi"` |  |
| service.main.enabled | bool | `true` |  |
| service.main.ports.http.enabled | bool | `true` |  |
| service.main.ports.http.port | int | `8090` |  |
| serviceMonitor.main.enabled | bool | `true` |  |
| serviceMonitor.main.endpoints[0].interval | string | `"1m"` |  |
| serviceMonitor.main.endpoints[0].port | string | `"http"` |  |
| serviceMonitor.main.endpoints[0].scrapeTimeout | string | `"10s"` |  |
| serviceMonitor.main.labels.release | string | `"scroll-sdk"` |  |
| serviceMonitor.main.serviceName | string | `"{{ include \"scroll.common.lib.chart.names.fullname\" $ }}"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
