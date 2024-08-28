# l1-explorer

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

l1-explorer helm charts

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| scroll-tech | <sebastien@scroll.io> |  |

## Requirements

Kubernetes: `>=1.22.0-0`

| Repository | Name | Version |
|------------|------|---------|
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | common | 1.5.1 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | external-secrets-lib | 0.0.2 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| command[0] | string | `"/bin/sh"` |  |
| command[1] | string | `"-c"` |  |
| command[2] | string | `"/app/bin/blockscout start"` |  |
| controller.replicas | int | `1` |  |
| controller.strategy | string | `"Recreate"` |  |
| controller.type | string | `"deployment"` |  |
| defaultProbes.custom | bool | `true` |  |
| defaultProbes.enabled | bool | `true` |  |
| defaultProbes.spec.httpGet.path | string | `"/"` |  |
| defaultProbes.spec.httpGet.port | int | `3000` |  |
| envFrom[0].configMapRef.name | string | `"l1-explorer-env"` |  |
| env[0].name | string | `"ECTO_USE_SSL"` |  |
| env[0].value | bool | `false` |  |
| env[10].name | string | `"SUBNETWORK"` |  |
| env[10].value | string | `"Scroll Sepolia Testnet"` |  |
| env[11].name | string | `"SUPPORTED_CHAINS"` |  |
| env[11].value | string | `"[{ \"title\": \"Scroll SDK (L1)\", \"url\": \"https://localhost:3000\", \"test_net?\": true }, { \"title\": \"Scroll SDK (L2) Testnet\", \"url\": \"http://blockscout:3000\", \"test_net?\": true }]"` |  |
| env[12].name | string | `"DISABLE_EXCHANGE_RATES"` |  |
| env[12].value | bool | `true` |  |
| env[13].name | string | `"BLOCKSCOUT_VERSION"` |  |
| env[13].value | string | `"5.2.1"` |  |
| env[14].name | string | `"FOOTER_GITHUB_LINK"` |  |
| env[14].value | string | `"https://github.com/blockscout/blockscout"` |  |
| env[15].name | string | `"ETHEREUM_JSONRPC_DEBUG_TRACE_TRANSACTION_TIMEOUT"` |  |
| env[15].value | string | `"10s"` |  |
| env[16].name | string | `"INDEXER_MEMORY_LIMIT"` |  |
| env[16].value | string | `"10gb"` |  |
| env[17].name | string | `"BLOCK_TRANSFORMER"` |  |
| env[17].value | string | `"clique"` |  |
| env[18].name | string | `"MICROSERVICE_SC_VERIFIER_ENABLED"` |  |
| env[18].value | bool | `true` |  |
| env[1].name | string | `"ETHEREUM_JSONRPC_VARIANT"` |  |
| env[1].value | string | `"geth"` |  |
| env[2].name | string | `"INDEXER_DISABLE_PENDING_TRANSACTIONS_FETCHER"` |  |
| env[2].value | bool | `true` |  |
| env[3].name | string | `"PORT"` |  |
| env[3].value | int | `3000` |  |
| env[4].name | string | `"NETWORK"` |  |
| env[4].value[0] | string | `""` |  |
| env[5].name | string | `"COIN"` |  |
| env[5].value | string | `"ETH"` |  |
| env[6].name | string | `"COIN_NAME"` |  |
| env[6].value | string | `"ETH"` |  |
| env[7].name | string | `"LOGO"` |  |
| env[7].value | string | `"/images/logo.svg"` |  |
| env[8].name | string | `"WEBAPP_URL"` |  |
| env[8].value | string | `"https://l1-explorer.scroll.tech"` |  |
| env[9].name | string | `"BLOCKSCOUT_HOST"` |  |
| env[9].value | string | `"test-l1-explorer.scroll.io"` |  |
| global.fullnameOverride | string | `"l1-explorer"` |  |
| global.nameOverride | string | `"l1-explorer"` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"blockscout/blockscout"` |  |
| image.tag | string | `"6.6.0"` |  |
| ingress.main.annotations | object | `{}` |  |
| ingress.main.enabled | bool | `true` |  |
| ingress.main.hosts[0].host | string | `"l1-explorer.scrollsdk"` |  |
| ingress.main.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.main.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.main.ingressClassName | string | `"nginx"` |  |
| ingress.main.labels | object | `{}` |  |
| ingress.main.primary | bool | `true` |  |
| initContainers.1-migrate-db.command[0] | string | `"/bin/sh"` |  |
| initContainers.1-migrate-db.command[1] | string | `"-c"` |  |
| initContainers.1-migrate-db.command[2] | string | `"/app/bin/blockscout eval \"Elixir.Explorer.ReleaseTasks.create_and_migrate()\""` |  |
| initContainers.1-migrate-db.envFrom[0].configMapRef.name | string | `"l1-explorer-env"` |  |
| initContainers.1-migrate-db.image | string | `"blockscout/blockscout:6.6.0"` |  |
| persistence.env.enabled | bool | `true` |  |
| persistence.env.mountPath | string | `"/config/"` |  |
| persistence.env.name | string | `"l1-explorer-env"` |  |
| persistence.env.type | string | `"configMap"` |  |
| probes.liveness.<<.custom | bool | `true` |  |
| probes.liveness.<<.enabled | bool | `true` |  |
| probes.liveness.<<.spec.httpGet.path | string | `"/"` |  |
| probes.liveness.<<.spec.httpGet.port | int | `3000` |  |
| probes.readiness.<<.custom | bool | `true` |  |
| probes.readiness.<<.enabled | bool | `true` |  |
| probes.readiness.<<.spec.httpGet.path | string | `"/"` |  |
| probes.readiness.<<.spec.httpGet.port | int | `3000` |  |
| probes.startup.<<.custom | bool | `true` |  |
| probes.startup.<<.enabled | bool | `true` |  |
| probes.startup.<<.spec.httpGet.path | string | `"/"` |  |
| probes.startup.<<.spec.httpGet.port | int | `3000` |  |
| service.main.enabled | bool | `true` |  |
| service.main.ports.http.enabled | bool | `true` |  |
| service.main.ports.http.port | int | `3000` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
