# blockscout

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

blockscout helm charts

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
| command[2] | string | `"/app/bin/blockscout start"` |  |
| controller.replicas | int | `1` |  |
| controller.strategy | string | `"Recreate"` |  |
| controller.type | string | `"deployment"` |  |
| defaultProbes.custom | bool | `true` |  |
| defaultProbes.enabled | bool | `true` |  |
| defaultProbes.spec.httpGet.path | string | `"/"` |  |
| defaultProbes.spec.httpGet.port | int | `3000` |  |
| envFrom[0].configMapRef.name | string | `"blockscout-env"` |  |
| env[0].name | string | `"ECTO_USE_SSL"` |  |
| env[0].value | bool | `false` |  |
| env[10].name | string | `"LOGO"` |  |
| env[10].value | string | `"/images/logo.svg"` |  |
| env[11].name | string | `"WEBAPP_URL"` |  |
| env[11].value | string | `"https://blockscout.scroll.tech"` |  |
| env[12].name | string | `"BLOCKSCOUT_HOST"` |  |
| env[12].value | string | `"test-blockscout.scroll.io"` |  |
| env[13].name | string | `"JSON_RPC"` |  |
| env[13].value | string | `"http://l2-sequencer:8545"` |  |
| env[14].name | string | `"SUBNETWORK"` |  |
| env[14].value | string | `"Scroll Sepolia Testnet"` |  |
| env[15].name | string | `"SUPPORTED_CHAINS"` |  |
| env[15].value | string | `"[{ \"title\": \"Etherscan (Sepolia)\", \"url\": \"https://sepolia.etherscan.io\", \"test_net?\": true }, { \"title\": \"Scroll Sepolia Testnet\", \"url\": \"http://test-blockscout.scroll.io\", \"test_net?\": true }]"` |  |
| env[16].name | string | `"DISABLE_EXCHANGE_RATES"` |  |
| env[16].value | bool | `true` |  |
| env[17].name | string | `"BLOCKSCOUT_VERSION"` |  |
| env[17].value | string | `"5.2.1"` |  |
| env[18].name | string | `"FOOTER_GITHUB_LINK"` |  |
| env[18].value | string | `"https://github.com/scroll-tech/blockscout"` |  |
| env[19].name | string | `"RELEASE_LINK"` |  |
| env[19].value | string | `"https://github.com/scroll-tech"` |  |
| env[1].name | string | `"ETHEREUM_JSONRPC_HTTP_URL"` |  |
| env[1].value | string | `"http://l2-sequencer:8545"` |  |
| env[20].name | string | `"RELEASE_NODE"` |  |
| env[20].value | string | `"l2_blockscout"` |  |
| env[21].name | string | `"ETHEREUM_JSONRPC_DEBUG_TRACE_TRANSACTION_TIMEOUT"` |  |
| env[21].value | string | `"10s"` |  |
| env[22].name | string | `"INDEXER_MEMORY_LIMIT"` |  |
| env[22].value | string | `"10gb"` |  |
| env[23].name | string | `"BLOCK_TRANSFORMER"` |  |
| env[23].value | string | `"clique"` |  |
| env[24].name | string | `"MICROSERVICE_SC_VERIFIER_ENABLED"` |  |
| env[24].value | bool | `true` |  |
| env[25].name | string | `"MICROSERVICE_SC_VERIFIER_URL"` |  |
| env[25].value | string | `"http://blockscout-sc-verifier:8080"` |  |
| env[26].name | string | `"CHAIN_SPEC_PATH"` |  |
| env[26].value | string | `"/app/genesis/genesis.json"` |  |
| env[2].name | string | `"ETHEREUM_JSONRPC_TRACE_URL"` |  |
| env[2].value | string | `"http://l2-sequencer:8545"` |  |
| env[3].name | string | `"ETHEREUM_JSONRPC_VARIANT"` |  |
| env[3].value | string | `"geth"` |  |
| env[4].name | string | `"ETHEREUM_JSONRPC_WS_URL"` |  |
| env[4].value | string | `"ws://l2-sequencer:8546"` |  |
| env[5].name | string | `"INDEXER_DISABLE_PENDING_TRANSACTIONS_FETCHER"` |  |
| env[5].value | bool | `true` |  |
| env[6].name | string | `"PORT"` |  |
| env[6].value | int | `3000` |  |
| env[7].name | string | `"NETWORK"` |  |
| env[7].value[0] | string | `""` |  |
| env[8].name | string | `"COIN"` |  |
| env[8].value | string | `"ETH"` |  |
| env[9].name | string | `"COIN_NAME"` |  |
| env[9].value | string | `"ETH"` |  |
| global.fullnameOverride | string | `"blockscout"` |  |
| global.nameOverride | string | `"blockscout"` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"blockscout/blockscout"` |  |
| image.tag | string | `"6.6.0"` |  |
| ingress.main.annotations | object | `{}` |  |
| ingress.main.enabled | bool | `true` |  |
| ingress.main.hosts[0].host | string | `"blockscout.scrollsdk"` |  |
| ingress.main.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.main.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.main.ingressClassName | string | `"nginx"` |  |
| ingress.main.labels | object | `{}` |  |
| ingress.main.primary | bool | `true` |  |
| initContainers.1-wait-for-postgres.args[0] | string | `"tcp"` |  |
| initContainers.1-wait-for-postgres.args[1] | string | `"postgresql:5432"` |  |
| initContainers.1-wait-for-postgres.args[2] | string | `"--timeout"` |  |
| initContainers.1-wait-for-postgres.args[3] | string | `"0"` |  |
| initContainers.1-wait-for-postgres.image | string | `"atkrad/wait4x:latest"` |  |
| initContainers.2-migrate-db.command[0] | string | `"/bin/sh"` |  |
| initContainers.2-migrate-db.command[1] | string | `"-c"` |  |
| initContainers.2-migrate-db.command[2] | string | `"/app/bin/blockscout eval \"Elixir.Explorer.ReleaseTasks.create_and_migrate()\""` |  |
| initContainers.2-migrate-db.envFrom[0].configMapRef.name | string | `"blockscout-env"` |  |
| initContainers.2-migrate-db.image | string | `"blockscout/blockscout:6.6.0"` |  |
| initContainers.3-check-postgres-connection.args[0] | string | `"postgresql"` |  |
| initContainers.3-check-postgres-connection.args[1] | string | `"$(DATABASE_URL)"` |  |
| initContainers.3-check-postgres-connection.envFrom[0].configMapRef.name | string | `"blockscout-env"` |  |
| initContainers.3-check-postgres-connection.image | string | `"atkrad/wait4x:latest"` |  |
| persistence.env.enabled | string | `"yes"` |  |
| persistence.env.mountPath | string | `"/config/"` |  |
| persistence.env.name | string | `"blockscout-env"` |  |
| persistence.env.type | string | `"configMap"` |  |
| persistence.genesis.enabled | string | `"yes"` |  |
| persistence.genesis.mountPath | string | `"/app/genesis/"` |  |
| persistence.genesis.name | string | `"genesis-config"` |  |
| persistence.genesis.type | string | `"configMap"` |  |
| persistence.init-db.defaultMode | string | `"0777"` |  |
| persistence.init-db.enabled | string | `"yes"` |  |
| persistence.init-db.mountPath | string | `"/init-db.sh"` |  |
| persistence.init-db.name | string | `"init-db"` |  |
| persistence.init-db.type | string | `"configMap"` |  |
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
