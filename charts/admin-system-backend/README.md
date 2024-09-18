# admin-system-backend

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

admin-system-backend helm charts

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| scroll-tech | <weichi@scroll.io> |  |

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
| command[2] | string | `"scroll-admin-system --config /app/config/admin-system-backend-config.json --genesis /app/genesis/genesis.json --http.port ${HTTP_PORT} --metrics --metrics.port ${METRICS_PORT}"` |  |
| configMaps.add-user.data."add-user.sh" | string | `"#!/bin/bash\necho \"Adding users...\"\npsql $SCROLL_ADMIN_AUTH_DB_CONFIG_DSN -c \"INSERT INTO users (username, role) VALUES ('admin', 1);\"\npsql $SCROLL_ADMIN_AUTH_DB_CONFIG_DSN -c \"INSERT INTO users (username, role) VALUES ('normal', 3);\"\necho \"Users added.\"\n"` |  |
| configMaps.add-user.enabled | bool | `true` |  |
| configMaps.model-conf.data."model.conf" | string | `"[request_definition]\nr = sub, obj, act\n[policy_definition]\np = sub, obj, act\n[role_definition]\ng = _, _\n[policy_effect]\ne = some(where (p.eft == allow))\n[matchers]\nm = g(r.sub, p.sub) && regexMatch(r.obj, p.obj) && regexMatch(r.act, p.act)\n"` |  |
| configMaps.model-conf.enabled | bool | `true` |  |
| configMaps.policy-csv.data."policy.csv" | string | `"p, undefined, ^\\/api\\/v1\\/login$, POST\np, undefined, ^\\/api\\/v1\\/otp\\/.*$, (GET)|(POST)\np, read, ^\\/api\\/v1\\/(chunk|batch|bundle|provertask|l2_block|prover|job)\\/.*$, GET\np, read, ^\\/api\\/v1\\/(chunk|batch|bundle|provertask|l2_block|prover)\\/search$, POST\np, readwrite, ^\\/api\\/v1\\/(chunk|batch|bundle|l2_block)\\/.*$, (POST)|(DELETE)\np, readwrite, ^\\/api\\/v1\\/provertask\\/(update|delete)$, (POST)|(DELETE)\np, admin, ^\\/api\\/v1\\/provertask\\/reassign$, POST\np, admin, ^\\/api\\/v1\\/(policy|user|prover_block|partner)\\/.*$,(GET)|(POST)|(DELETE)\np, admin, ^\\/api\\/v1\\/job\\/.*$, POST\ng, read, undefined\ng, readwrite, read\ng, admin, readwrite\n"` |  |
| configMaps.policy-csv.enabled | bool | `true` |  |
| controller.replicas | int | `1` |  |
| controller.strategy | string | `"Recreate"` |  |
| controller.type | string | `"deployment"` |  |
| envFrom[0].configMapRef.name | string | `"admin-system-backend-env"` |  |
| env[0].name | string | `"HTTP_PORT"` |  |
| env[0].value | string | `"8080"` |  |
| env[1].name | string | `"METRICS_PORT"` |  |
| env[1].value | string | `"8090"` |  |
| env[2].name | string | `"GIN_MODE"` |  |
| env[2].value | string | `"release"` |  |
| env[3].name | string | `"ENV"` |  |
| env[3].value | string | `"fake"` |  |
| env[4].name | string | `"CHAIN_ID"` |  |
| env[4].value | string | `"123456"` |  |
| global.fullnameOverride | string | `"admin-system-backend"` |  |
| global.nameOverride | string | `"admin-system-backend"` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"scrolltech/scroll-admin-system"` |  |
| image.tag | string | `"v0.1.2"` |  |
| initContainers.1-check-postgres-connection.args[0] | string | `"postgresql"` |  |
| initContainers.1-check-postgres-connection.args[1] | string | `"$(SCROLL_ADMIN_AUTH_DB_CONFIG_DSN)"` |  |
| initContainers.1-check-postgres-connection.args[2] | string | `"--timeout"` |  |
| initContainers.1-check-postgres-connection.args[3] | string | `"0"` |  |
| initContainers.1-check-postgres-connection.envFrom[0].configMapRef.name | string | `"admin-system-backend-env"` |  |
| initContainers.1-check-postgres-connection.image | string | `"atkrad/wait4x:latest"` |  |
| initContainers.2-migrate-db.command[0] | string | `"/bin/sh"` |  |
| initContainers.2-migrate-db.command[1] | string | `"-c"` |  |
| initContainers.2-migrate-db.command[2] | string | `"db_cli migrate --config /app/config/admin-system-backend-config.json"` |  |
| initContainers.2-migrate-db.envFrom[0].configMapRef.name | string | `"admin-system-backend-env"` |  |
| initContainers.2-migrate-db.image | string | `"scrolltech/scroll-admin-system:v0.1.2"` |  |
| initContainers.2-migrate-db.volumeMounts[0].mountPath | string | `"/app/config/"` |  |
| initContainers.2-migrate-db.volumeMounts[0].name | string | `"admin-system-backend"` |  |
| initContainers.3-add-user.command[0] | string | `"bash"` |  |
| initContainers.3-add-user.command[1] | string | `"-c"` |  |
| initContainers.3-add-user.command[2] | string | `"/add-user.sh"` |  |
| initContainers.3-add-user.envFrom[0].configMapRef.name | string | `"admin-system-backend-env"` |  |
| initContainers.3-add-user.image | string | `"postgres:latest"` |  |
| initContainers.3-add-user.volumeMounts[0].mountPath | string | `"/add-user.sh"` |  |
| initContainers.3-add-user.volumeMounts[0].name | string | `"add-user"` |  |
| initContainers.3-add-user.volumeMounts[0].subPath | string | `"add-user.sh"` |  |
| persistence.add-user.defaultMode | string | `"0777"` |  |
| persistence.add-user.enabled | bool | `true` |  |
| persistence.add-user.mountPath | string | `"/app/conf/add-user.sh"` |  |
| persistence.add-user.name | string | `"admin-system-backend-add-user"` |  |
| persistence.add-user.subPath | string | `"add-user.sh"` |  |
| persistence.add-user.type | string | `"configMap"` |  |
| persistence.app_name.enabled | bool | `true` |  |
| persistence.app_name.mountPath | string | `"/app/config/"` |  |
| persistence.app_name.name | string | `"admin-system-backend-config"` |  |
| persistence.app_name.type | string | `"configMap"` |  |
| persistence.genesis.enabled | bool | `true` |  |
| persistence.genesis.mountPath | string | `"/app/genesis/"` |  |
| persistence.genesis.name | string | `"genesis-config"` |  |
| persistence.genesis.type | string | `"configMap"` |  |
| persistence.model-conf.enabled | bool | `true` |  |
| persistence.model-conf.mountPath | string | `"/app/conf/model.conf"` |  |
| persistence.model-conf.name | string | `"admin-system-backend-model-conf"` |  |
| persistence.model-conf.subPath | string | `"model.conf"` |  |
| persistence.model-conf.type | string | `"configMap"` |  |
| persistence.policy-csv.enabled | bool | `true` |  |
| persistence.policy-csv.mountPath | string | `"/app/conf/policy.csv"` |  |
| persistence.policy-csv.name | string | `"admin-system-backend-policy-csv"` |  |
| persistence.policy-csv.subPath | string | `"policy.csv"` |  |
| persistence.policy-csv.type | string | `"configMap"` |  |
| probes.liveness.enabled | bool | `false` |  |
| probes.readiness.enabled | bool | `false` |  |
| probes.startup.enabled | bool | `false` |  |
| resources.limits.cpu | string | `"100m"` |  |
| resources.limits.memory | string | `"200Mi"` |  |
| resources.requests.cpu | string | `"50m"` |  |
| resources.requests.memory | string | `"50Mi"` |  |
| service.main.enabled | bool | `true` |  |
| service.main.ports.http.enabled | bool | `true` |  |
| service.main.ports.http.port | int | `8080` |  |
| service.main.ports.http.primary | bool | `true` |  |
| service.main.ports.http.protocol | string | `"HTTP"` |  |
| service.main.ports.metrics.enabled | bool | `true` |  |
| service.main.ports.metrics.port | int | `8090` |  |
| service.main.ports.metrics.targetPort | int | `8090` |  |
| service.main.primary | bool | `true` |  |
| serviceMonitor.main.enabled | bool | `true` |  |
| serviceMonitor.main.endpoints[0].interval | string | `"1m"` |  |
| serviceMonitor.main.endpoints[0].port | string | `"http"` |  |
| serviceMonitor.main.endpoints[0].scrapeTimeout | string | `"10s"` |  |
| serviceMonitor.main.labels.release | string | `"scroll-stack"` |  |
| serviceMonitor.main.serviceName | string | `"{{ include \"scroll.common.lib.chart.names.fullname\" $ }}"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
