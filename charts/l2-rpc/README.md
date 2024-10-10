# l2-rpc

![Version: 0.0.13](https://img.shields.io/badge/Version-0.0.13-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

l2-rpc helm chart

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
| command[0] | string | `"bash"` |  |
| command[1] | string | `"-c"` |  |
| command[2] | string | `"geth --datadir \"/l2geth/data\" init /l2geth/genesis/genesis.json && echo \"[Node.P2P] StaticNodes = $L2GETH_PEER_LIST\" > \"/l2geth/config.toml\" && geth --datadir \"/l2geth/data\" --port \"$L2GETH_P2P_PORT\" --nodiscover --syncmode full --networkid \"$CHAIN_ID\" --config \"/l2geth/config.toml\" --http --http.port \"$L2GETH_RPC_HTTP_PORT\" --http.addr \"0.0.0.0\" --http.vhosts=\"*\" --http.corsdomain '*' --http.api \"eth,scroll,net,web3,debug\" --pprof --pprof.addr \"0.0.0.0\" --pprof.port 6060 --ws --ws.port \"$L2GETH_RPC_WS_PORT\" --ws.addr \"0.0.0.0\" --ws.api \"eth,scroll,net,web3,debug\" $L2GETH_CCC_FLAG --ccc.numworkers \"$L2GETH_CCC_NUMWORKERS\" $METRICS_FLAGS --gcmode archive --cache.noprefetch --verbosity 3 --txpool.globalqueue 4096 --txpool.globalslots 40960 --txpool.pricelimit \"$L2GETH_MIN_GAS_PRICE\" $LOCALS_FLAG --miner.gasprice \"$L2GETH_MIN_GAS_PRICE\" --rpc.gascap 0 --gpo.ignoreprice \"$L2GETH_MIN_GAS_PRICE\" --gpo.percentile 20 --gpo.blocks 100 --l1.endpoint \"$L2GETH_L1_ENDPOINT\" --l1.confirmations \"$L2GETH_L1_WATCHER_CONFIRMATIONS\" --l1.sync.startblock \"$L2GETH_L1_CONTRACT_DEPLOYMENT_BLOCK\" --rollup.verify --metrics --metrics.expensive $L2GETH_EXTRA_PARAMS"` |  |
| controller.replicas | int | `1` |  |
| controller.strategy | string | `"RollingUpdate"` |  |
| controller.type | string | `"statefulset"` |  |
| defaultProbes.custom | bool | `true` |  |
| defaultProbes.enabled | bool | `true` |  |
| defaultProbes.spec.httpGet.path | string | `"/"` |  |
| defaultProbes.spec.httpGet.port | int | `8545` |  |
| envFrom[0].configMapRef.name | string | `"l2-rpc-env"` |  |
| env[0].name | string | `"L2GETH_NODEKEY"` |  |
| env[0].value | string | `""` |  |
| env[1].name | string | `"L2GETH_L1_WATCHER_CONFIRMATIONS"` |  |
| env[1].value | string | `"0x6"` |  |
| env[2].name | string | `"L2GETH_RPC_HTTP_PORT"` |  |
| env[2].value | int | `8545` |  |
| env[3].name | string | `"L2GETH_RPC_WS_PORT"` |  |
| env[3].value | int | `8546` |  |
| env[4].name | string | `"L2GETH_P2P_PORT"` |  |
| env[4].value | int | `30303` |  |
| env[5].name | string | `"L2GETH_CCC_FLAG"` |  |
| env[5].value | string | `"--ccc"` |  |
| env[6].name | string | `"L2GETH_MAX_PEERS"` |  |
| env[6].value | int | `500` |  |
| env[7].name | string | `"VERBOSITY"` |  |
| env[7].value | int | `3` |  |
| env[8].name | string | `"L2GETH_MIN_GAS_PRICE"` |  |
| env[8].value | string | `"1000000"` |  |
| env[9].name | string | `"L2GETH_EXTRA_PARAMS"` |  |
| env[9].value | string | `""` |  |
| global.fullnameOverride | string | `"l2-rpc"` |  |
| global.nameOverride | string | `"l2-rpc"` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"scrolltech/l2geth"` |  |
| image.tag | string | `"scroll-v5.7.21"` |  |
| ingress.main.annotations | object | `{}` |  |
| ingress.main.enabled | bool | `true` |  |
| ingress.main.hosts[0].host | string | `"l2-rpc.scrollsdk"` |  |
| ingress.main.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.main.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.main.ingressClassName | string | `"nginx"` |  |
| ingress.main.labels | object | `{}` |  |
| ingress.main.primary | bool | `true` |  |
| ingress.websocket.enabled | bool | `true` |  |
| ingress.websocket.hosts[0].host | string | `"l2-rpc-ws.scrollsdk"` |  |
| ingress.websocket.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.websocket.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.websocket.hosts[0].paths[0].service.port | int | `8546` |  |
| ingress.websocket.ingressClassName | string | `"nginx"` |  |
| initContainers.1-wait-for-l1.command[0] | string | `"/bin/sh"` |  |
| initContainers.1-wait-for-l1.command[1] | string | `"-c"` |  |
| initContainers.1-wait-for-l1.command[2] | string | `"/wait-for-l1.sh $L2GETH_L1_ENDPOINT"` |  |
| initContainers.1-wait-for-l1.envFrom[0].configMapRef.name | string | `"l2-rpc-env"` |  |
| initContainers.1-wait-for-l1.image | string | `"scrolltech/scroll-alpine:v0.0.1"` |  |
| initContainers.1-wait-for-l1.volumeMounts[0].mountPath | string | `"/wait-for-l1.sh"` |  |
| initContainers.1-wait-for-l1.volumeMounts[0].name | string | `"wait-for-l1-script"` |  |
| initContainers.1-wait-for-l1.volumeMounts[0].subPath | string | `"wait-for-l1.sh"` |  |
| persistence.env.enabled | bool | `true` |  |
| persistence.env.mountPath | string | `"/config/"` |  |
| persistence.env.name | string | `"l2-rpc-env"` |  |
| persistence.env.type | string | `"configMap"` |  |
| persistence.genesis.enabled | bool | `true` |  |
| persistence.genesis.mountPath | string | `"/l2geth/genesis/"` |  |
| persistence.genesis.name | string | `"genesis-config"` |  |
| persistence.genesis.type | string | `"configMap"` |  |
| persistence.wait-for-l1-script.defaultMode | string | `"0777"` |  |
| persistence.wait-for-l1-script.enabled | bool | `true` |  |
| persistence.wait-for-l1-script.name | string | `"wait-for-l1-script"` |  |
| persistence.wait-for-l1-script.type | string | `"configMap"` |  |
| probes.liveness.<<.custom | bool | `true` |  |
| probes.liveness.<<.enabled | bool | `true` |  |
| probes.liveness.<<.spec.httpGet.path | string | `"/"` |  |
| probes.liveness.<<.spec.httpGet.port | int | `8545` |  |
| probes.readiness.<<.custom | bool | `true` |  |
| probes.readiness.<<.enabled | bool | `true` |  |
| probes.readiness.<<.spec.httpGet.path | string | `"/"` |  |
| probes.readiness.<<.spec.httpGet.port | int | `8545` |  |
| probes.startup.<<.custom | bool | `true` |  |
| probes.startup.<<.enabled | bool | `true` |  |
| probes.startup.<<.spec.httpGet.path | string | `"/"` |  |
| probes.startup.<<.spec.httpGet.port | int | `8545` |  |
| service.main.enabled | bool | `true` |  |
| service.main.ports.http.enabled | bool | `true` |  |
| service.main.ports.http.port | int | `8545` |  |
| service.main.ports.metrics.enabled | bool | `true` |  |
| service.main.ports.metrics.port | int | `6060` |  |
| service.main.ports.metrics.targetPort | int | `6060` |  |
| service.main.ports.ws.enabled | bool | `true` |  |
| service.main.ports.ws.port | int | `8546` |  |
| serviceMonitor.main.enabled | bool | `true` |  |
| serviceMonitor.main.endpoints[0].interval | string | `"1m"` |  |
| serviceMonitor.main.endpoints[0].path | string | `"/debug/metrics/prometheus"` |  |
| serviceMonitor.main.endpoints[0].port | string | `"metrics"` |  |
| serviceMonitor.main.endpoints[0].scrapeTimeout | string | `"10s"` |  |
| serviceMonitor.main.labels.release | string | `"scroll-sdk"` |  |
| serviceMonitor.main.serviceName | string | `"{{ include \"scroll.common.lib.chart.names.fullname\" $ }}"` |  |
| volumeClaimTemplates[0].accessMode | string | `"ReadWriteOnce"` |  |
| volumeClaimTemplates[0].mountPath | string | `"/l2geth/data"` |  |
| volumeClaimTemplates[0].name | string | `"data"` |  |
| volumeClaimTemplates[0].size | string | `"100Gi"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
