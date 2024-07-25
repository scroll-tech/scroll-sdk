# rollup-node

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

rollup-node helm charts

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| scroll-sre | <sebastien@scroll.io> |  |

## Requirements

Kubernetes: `>=1.22.0-0`

| Repository | Name | Version |
|------------|------|---------|
| file://../../../common-lib/ | common | 1.5.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| command[0] | string | `"/bin/sh"` |  |
| command[1] | string | `"-c"` |  |
| command[2] | string | `"rollup_relayer --config /app/conf/rollup-config.json --genesis /app/genesis/genesis.json --import-genesis --metrics --metrics.addr 0.0.0.0 --metrics.port ${METRICS_PORT} --log.debug --verbosity 3"` |  |
| configMaps.migrate-db.data."migrate-db.json" | string | `"{\n    \"driver_name\": \"postgres\",\n    \"dsn\": \"postgres://postgres:qwerty12345@postgresql:5432/scroll?sslmode=disable\"\n}\n"` |  |
| configMaps.migrate-db.enabled | bool | `true` |  |
| controller.replicas | int | `1` |  |
| controller.strategy | string | `"Recreate"` |  |
| controller.type | string | `"deployment"` |  |
| env[0].name | string | `"METRICS_PORT"` |  |
| env[0].value | int | `8090` |  |
| global.fullnameOverride | string | `"rollup-node"` |  |
| global.nameOverride | string | `"rollup-node"` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"scrolltech/rollup-relayer"` |  |
| image.tag | string | `"v4.4.31"` |  |
| initContainers.1-wait-for-postgres.args[0] | string | `"tcp"` |  |
| initContainers.1-wait-for-postgres.args[1] | string | `"postgresql:5432"` |  |
| initContainers.1-wait-for-postgres.args[2] | string | `"--timeout"` |  |
| initContainers.1-wait-for-postgres.args[3] | string | `"0"` |  |
| initContainers.1-wait-for-postgres.image | string | `"atkrad/wait4x:latest"` |  |
| initContainers.2-init-db.command[0] | string | `"bash"` |  |
| initContainers.2-init-db.command[1] | string | `"-c"` |  |
| initContainers.2-init-db.command[2] | string | `"./init-db.sh"` |  |
| initContainers.2-init-db.env[0].name | string | `"POSTGRES_DB"` |  |
| initContainers.2-init-db.env[0].value | string | `"scroll"` |  |
| initContainers.2-init-db.env[1].name | string | `"PG_USER"` |  |
| initContainers.2-init-db.env[1].valueFrom.secretKeyRef.key | string | `"PG_USER"` |  |
| initContainers.2-init-db.env[1].valueFrom.secretKeyRef.name | string | `"db-secrets"` |  |
| initContainers.2-init-db.env[2].name | string | `"PGPASSWORD"` |  |
| initContainers.2-init-db.env[2].valueFrom.secretKeyRef.key | string | `"PGPASSWORD"` |  |
| initContainers.2-init-db.env[2].valueFrom.secretKeyRef.name | string | `"db-secrets"` |  |
| initContainers.2-init-db.env[3].name | string | `"PG_HOST"` |  |
| initContainers.2-init-db.env[3].valueFrom.secretKeyRef.key | string | `"PG_HOST"` |  |
| initContainers.2-init-db.env[3].valueFrom.secretKeyRef.name | string | `"db-secrets"` |  |
| initContainers.2-init-db.env[4].name | string | `"PG_PORT"` |  |
| initContainers.2-init-db.env[4].valueFrom.secretKeyRef.key | string | `"PG_PORT"` |  |
| initContainers.2-init-db.env[4].valueFrom.secretKeyRef.name | string | `"db-secrets"` |  |
| initContainers.2-init-db.env[5].name | string | `"DB_USER"` |  |
| initContainers.2-init-db.env[5].value | string | `"rollup_node"` |  |
| initContainers.2-init-db.env[6].name | string | `"DB_PASSWORD"` |  |
| initContainers.2-init-db.env[6].valueFrom.secretKeyRef.key | string | `"ROLLUP_NODE_PASSWORD"` |  |
| initContainers.2-init-db.env[6].valueFrom.secretKeyRef.name | string | `"db-secrets"` |  |
| initContainers.2-init-db.image | string | `"postgres:latest"` |  |
| initContainers.2-init-db.volumeMounts[0].mountPath | string | `"/init-db.sh"` |  |
| initContainers.2-init-db.volumeMounts[0].name | string | `"init-db"` |  |
| initContainers.2-init-db.volumeMounts[0].subPath | string | `"init-db.sh"` |  |
| initContainers.3-check-postgres-connection.args[0] | string | `"postgresql"` |  |
| initContainers.3-check-postgres-connection.args[1] | string | `"$(DATABASE_URL)"` |  |
| initContainers.3-check-postgres-connection.args[2] | string | `"--timeout"` |  |
| initContainers.3-check-postgres-connection.args[3] | string | `"0"` |  |
| initContainers.3-check-postgres-connection.envFrom[0].configMapRef.name | string | `"rollup-node-env"` |  |
| initContainers.3-check-postgres-connection.image | string | `"atkrad/wait4x:latest"` |  |
| initContainers.4-migrate-db.command[0] | string | `"/bin/sh"` |  |
| initContainers.4-migrate-db.command[1] | string | `"-c"` |  |
| initContainers.4-migrate-db.command[2] | string | `"db_cli migrate --config /config/migrate-db.json"` |  |
| initContainers.4-migrate-db.image | string | `"scrolltech/rollup-db-cli"` |  |
| initContainers.4-migrate-db.volumeMounts[0].mountPath | string | `"/config/migrate-db.json"` |  |
| initContainers.4-migrate-db.volumeMounts[0].name | string | `"migrate-db"` |  |
| initContainers.4-migrate-db.volumeMounts[0].subPath | string | `"migrate-db.json"` |  |
| initContainers.5-wait-for-l1.command[0] | string | `"/bin/sh"` |  |
| initContainers.5-wait-for-l1.command[1] | string | `"-c"` |  |
| initContainers.5-wait-for-l1.command[2] | string | `"/wait-for-l1.sh $L1_RPC_ENDPOINT"` |  |
| initContainers.5-wait-for-l1.envFrom[0].configMapRef.name | string | `"rollup-node-env"` |  |
| initContainers.5-wait-for-l1.image | string | `"scrolltech/scroll-alpine:v0.0.1"` |  |
| initContainers.5-wait-for-l1.volumeMounts[0].mountPath | string | `"/wait-for-l1.sh"` |  |
| initContainers.5-wait-for-l1.volumeMounts[0].name | string | `"wait-for-l1-script"` |  |
| initContainers.5-wait-for-l1.volumeMounts[0].subPath | string | `"wait-for-l1.sh"` |  |
| initContainers.6-wait-for-l2-sequencer.args[0] | string | `"http"` |  |
| initContainers.6-wait-for-l2-sequencer.args[1] | string | `"$(L2_RPC_ENDPOINT)"` |  |
| initContainers.6-wait-for-l2-sequencer.args[2] | string | `"--expect-status-code"` |  |
| initContainers.6-wait-for-l2-sequencer.args[3] | string | `"200"` |  |
| initContainers.6-wait-for-l2-sequencer.envFrom[0].configMapRef.name | string | `"rollup-node-env"` |  |
| initContainers.6-wait-for-l2-sequencer.image | string | `"atkrad/wait4x:latest"` |  |
| persistence.app_name.enabled | string | `"yes"` |  |
| persistence.app_name.mountPath | string | `"/app/conf/"` |  |
| persistence.app_name.name | string | `"rollup-node-config"` |  |
| persistence.app_name.type | string | `"configMap"` |  |
| persistence.genesis.enabled | string | `"yes"` |  |
| persistence.genesis.mountPath | string | `"/app/genesis/"` |  |
| persistence.genesis.name | string | `"genesis-config"` |  |
| persistence.genesis.type | string | `"configMap"` |  |
| persistence.init-db.defaultMode | string | `"0777"` |  |
| persistence.init-db.enabled | string | `"yes"` |  |
| persistence.init-db.mountPath | string | `"/init-db.sh"` |  |
| persistence.init-db.name | string | `"init-db"` |  |
| persistence.init-db.type | string | `"configMap"` |  |
| persistence.migrate-db.defaultMode | string | `"0777"` |  |
| persistence.migrate-db.enabled | string | `"yes"` |  |
| persistence.migrate-db.mountPath | string | `"/config/migrate-db.json"` |  |
| persistence.migrate-db.name | string | `"rollup-node-migrate-db"` |  |
| persistence.migrate-db.type | string | `"configMap"` |  |
| persistence.wait-for-l1-script.defaultMode | string | `"0777"` |  |
| persistence.wait-for-l1-script.enabled | string | `"yes"` |  |
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
| serviceMonitor.main.labels.release | string | `"scroll-stack"` |  |
| serviceMonitor.main.serviceName | string | `"{{ include \"scroll.common.lib.chart.names.fullname\" $ }}"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
