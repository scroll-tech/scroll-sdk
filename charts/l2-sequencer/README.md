# l2-sequencer

![Version: 0.0.7](https://img.shields.io/badge/Version-0.0.7-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

l2-sequencer helm charts

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
| command[2] | string | `"mkdir -p /l2geth/data/keystore && mkdir -p /l2geth/data/geth && echo ${L2GETH_PASSWORD} > /l2geth/password && echo ${L2GETH_KEYSTORE}  > /l2geth/data/keystore/keystore.json && echo ${L2GETH_NODEKEY} > /l2geth/data/geth/nodekey && geth --datadir \"/l2geth/data\" init /l2geth/genesis/genesis.json && geth --datadir \"/l2geth/data\" --port \"$L2GETH_P2P_PORT\" --nodiscover --syncmode full --networkid \"$CHAIN_ID\" --http --http.port \"$L2GETH_RPC_HTTP_PORT\" --http.addr \"0.0.0.0\" --http.vhosts=\"*\" --http.corsdomain \"*\" --http.api \"eth,scroll,net,web3,debug\" --pprof --pprof.addr \"0.0.0.0\" --pprof.port 6060 --ws --ws.port \"$L2GETH_RPC_WS_PORT\" --ws.addr \"0.0.0.0\" --ws.api \"eth,scroll,net,web3,debug\" --unlock \"$L2GETH_SIGNER_ADDRESS\" --password \"/l2geth/password\" --allow-insecure-unlock --mine $CCC_FLAG --gcmode archive --cache.noprefetch --verbosity ${VERBOSITY} --txpool.globalqueue 4096 --txpool.globalslots 40960 --txpool.pricelimit \"$L2GETH_MIN_GAS_PRICE\" $LOCALS_FLAG --miner.gasprice \"$L2GETH_MIN_GAS_PRICE\" --rpc.gascap 0 --gpo.ignoreprice \"$L2GETH_MIN_GAS_PRICE\" --gpo.percentile 20 --gpo.blocks 100 --l1.endpoint \"$L2GETH_L1_ENDPOINT\" --l1.confirmations \"$L2GETH_L1_WATCHER_CONFIRMATIONS\" --l1.sync.startblock \"$L2GETH_L1_CONTRACT_DEPLOYMENT_BLOCK\" --rollup.verify --metrics --metrics.expensive $L2GETH_EXTRA_PARAMS"` |  |
| configMaps.config.data."config.toml" | string | `"[Node.P2P] StaticNodes = \"[]\"\n"` |  |
| configMaps.config.enabled | bool | `true` |  |
| controller.replicas | int | `1` |  |
| controller.strategy | string | `"RollingUpdate"` |  |
| controller.type | string | `"statefulset"` |  |
| defaultProbes.custom | bool | `true` |  |
| defaultProbes.enabled | bool | `true` |  |
| defaultProbes.spec.httpGet.path | string | `"/"` |  |
| defaultProbes.spec.httpGet.port | int | `8545` |  |
| envFrom[0].configMapRef.name | string | `"l2-sequencer-env"` |  |
| env[0].name | string | `"L2GETH_ROLE"` |  |
| env[0].value | string | `"signer"` |  |
| env[10].name | string | `"VERBOSITY"` |  |
| env[10].value | string | `"3"` |  |
| env[1].name | string | `"L2GETH_PEER_LIST"` |  |
| env[1].value[0] | string | `""` |  |
| env[2].name | string | `"L2GETH_L1_WATCHER_CONFIRMATIONS"` |  |
| env[2].value | string | `"0x6"` |  |
| env[3].name | string | `"L2GETH_LOCALS"` |  |
| env[3].value | string | `""` |  |
| env[4].name | string | `"L2GETH_ENABLE_CCC"` |  |
| env[4].value | string | `"true"` |  |
| env[5].name | string | `"L2GETH_MINER_GASLIMIT"` |  |
| env[5].value | string | `"10000000"` |  |
| env[6].name | string | `"L2GETH_RPC_HTTP_PORT"` |  |
| env[6].value | int | `8545` |  |
| env[7].name | string | `"L2GETH_RPC_WS_PORT"` |  |
| env[7].value | int | `8546` |  |
| env[8].name | string | `"L2GETH_P2P_PORT"` |  |
| env[8].value | string | `"30303"` |  |
| env[9].name | string | `"L2GETH_MIN_GAS_PRICE"` |  |
| env[9].value | string | `"1000000"` |  |
| global.fullnameOverride | string | `"l2-sequencer"` |  |
| global.nameOverride | string | `"l2-sequencer"` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"scrolltech/l2geth"` |  |
| image.tag | string | `"scroll-v5.6.0"` |  |
| initContainers.wait-for-l1.command[0] | string | `"/bin/sh"` |  |
| initContainers.wait-for-l1.command[1] | string | `"-c"` |  |
| initContainers.wait-for-l1.command[2] | string | `"/wait-for-l1.sh $L2GETH_L1_ENDPOINT"` |  |
| initContainers.wait-for-l1.envFrom[0].configMapRef.name | string | `"l2-sequencer-env"` |  |
| initContainers.wait-for-l1.image | string | `"scrolltech/scroll-alpine:v0.0.1"` |  |
| initContainers.wait-for-l1.volumeMounts[0].mountPath | string | `"/wait-for-l1.sh"` |  |
| initContainers.wait-for-l1.volumeMounts[0].name | string | `"wait-for-l1-script"` |  |
| initContainers.wait-for-l1.volumeMounts[0].subPath | string | `"wait-for-l1.sh"` |  |
| persistence.data.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/l2geth/data/"` |  |
| persistence.data.name | string | `"l2geth-data"` |  |
| persistence.data.size | string | `"10Gi"` |  |
| persistence.data.type | string | `"pvc"` |  |
| persistence.env.enabled | bool | `true` |  |
| persistence.env.name | string | `"l2-sequencer-env"` |  |
| persistence.env.type | string | `"configMap"` |  |
| persistence.genesis.enabled | bool | `true` |  |
| persistence.genesis.mountPath | string | `"/l2geth/genesis/genesis.json"` |  |
| persistence.genesis.name | string | `"genesis-config"` |  |
| persistence.genesis.subPath | string | `"genesis.json"` |  |
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
| resources.limits.cpu | string | `"100m"` |  |
| resources.limits.memory | string | `"8Gi"` |  |
| resources.requests.cpu | string | `"50m"` |  |
| resources.requests.memory | string | `"150Mi"` |  |
| service.main.enabled | bool | `true` |  |
| service.main.ports.http.enabled | bool | `true` |  |
| service.main.ports.http.port | int | `8545` |  |
| service.main.ports.http.targetPort | int | `8545` |  |
| service.main.ports.metrics.enabled | bool | `true` |  |
| service.main.ports.metrics.port | int | `6060` |  |
| service.main.ports.metrics.targetPort | int | `6060` |  |
| service.main.ports.p2p.enabled | bool | `true` |  |
| service.main.ports.p2p.port | int | `30303` |  |
| service.main.ports.p2p.targetPort | int | `30303` |  |
| service.main.ports.ws.enabled | bool | `true` |  |
| service.main.ports.ws.port | int | `8546` |  |
| service.main.ports.ws.targetPort | int | `8546` |  |
| serviceMonitor.main.enabled | bool | `true` |  |
| serviceMonitor.main.endpoints[0].interval | string | `"1m"` |  |
| serviceMonitor.main.endpoints[0].path | string | `"/debug/metrics/prometheus"` |  |
| serviceMonitor.main.endpoints[0].port | string | `"metrics"` |  |
| serviceMonitor.main.endpoints[0].scrapeTimeout | string | `"10s"` |  |
| serviceMonitor.main.labels.release | string | `"scroll-sdk"` |  |
| serviceMonitor.main.serviceName | string | `"{{ include \"scroll.common.lib.chart.names.fullname\" $ }}"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
