# gas-oracle

![Version: 0.0.2](https://img.shields.io/badge/Version-0.0.2-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

gas-oracle helm charts

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
| command[2] | string | `"gas_oracle --config /app/conf/rollup-config.json --genesis /app/genesis/genesis.json --metrics --metrics.addr 0.0.0.0 --metrics.port ${METRICS_PORT} --log.debug"` |  |
| configMaps.migrate-db.data."migrate-db.json" | string | `"{\n    \"driver_name\": \"postgres\",\n    \"dsn\": \"postgres://postgres:qwerty12345@postgresql:5432/scroll?sslmode=disable\"\n}\n"` |  |
| configMaps.migrate-db.enabled | bool | `true` |  |
| defaultProbes.custom | bool | `true` |  |
| defaultProbes.enabled | bool | `true` |  |
| defaultProbes.spec.httpGet.path | string | `"/health"` |  |
| defaultProbes.spec.httpGet.port | int | `8090` |  |
| env[0].name | string | `"METRICS_PORT"` |  |
| env[0].value | int | `8090` |  |
| global.fullnameOverride | string | `"gas-oracle"` |  |
| global.nameOverride | string | `"gas-oracle"` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"scrolltech/gas-oracle"` |  |
| image.tag | string | `"v4.4.57"` |  |
| initContainers.1-check-postgres-connection.args[0] | string | `"postgresql"` |  |
| initContainers.1-check-postgres-connection.args[1] | string | `"$(DATABASE_URL)"` |  |
| initContainers.1-check-postgres-connection.args[2] | string | `"--timeout"` |  |
| initContainers.1-check-postgres-connection.args[3] | string | `"0"` |  |
| initContainers.1-check-postgres-connection.envFrom[0].configMapRef.name | string | `"gas-oracle-env"` |  |
| initContainers.1-check-postgres-connection.image | string | `"atkrad/wait4x:latest"` |  |
| initContainers.2-migrate-db.command[0] | string | `"/bin/sh"` |  |
| initContainers.2-migrate-db.command[1] | string | `"-c"` |  |
| initContainers.2-migrate-db.command[2] | string | `"db_cli migrate --config /config/migrate-db.json"` |  |
| initContainers.2-migrate-db.image | string | `"scrolltech/rollup-db-cli"` |  |
| initContainers.2-migrate-db.volumeMounts[0].mountPath | string | `"/config/migrate-db.json"` |  |
| initContainers.2-migrate-db.volumeMounts[0].name | string | `"migrate-db"` |  |
| initContainers.2-migrate-db.volumeMounts[0].subPath | string | `"migrate-db.json"` |  |
| initContainers.3-wait-for-l1.command[0] | string | `"/bin/sh"` |  |
| initContainers.3-wait-for-l1.command[1] | string | `"-c"` |  |
| initContainers.3-wait-for-l1.command[2] | string | `"/wait-for-l1.sh $SCROLL_L1_RPC"` |  |
| initContainers.3-wait-for-l1.envFrom[0].configMapRef.name | string | `"gas-oracle-env"` |  |
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
| persistence.migrate-db.name | string | `"gas-oracle-migrate-db"` |  |
| persistence.migrate-db.type | string | `"configMap"` |  |
| persistence.wait-for-l1-script.defaultMode | string | `"0777"` |  |
| persistence.wait-for-l1-script.enabled | bool | `true` |  |
| persistence.wait-for-l1-script.name | string | `"wait-for-l1-script"` |  |
| persistence.wait-for-l1-script.type | string | `"configMap"` |  |
| podLabels.app | string | `"gas-oracle"` |  |
| podLabels.dbaccess | string | `"true"` |  |
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
