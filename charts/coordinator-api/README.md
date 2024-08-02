# coordinator-api

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

coordinator-api helm charts

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
| command[2] | string | `"coordinator_api --config /coordinator/conf/coordinator-config.json --genesis /app/genesis/genesis.json --http --http.addr '0.0.0.0' --http.port ${HTTP_PORT} --metrics --metrics.addr '0.0.0.0' --metrics.port ${METRICS_PORT} --log.debug"` |  |
| configMaps.download-params.data."download-params.sh" | string | `"#!/bin/sh\napt update\napt install wget libdigest-sha-perl -y\n\nP_CHECKSUMS=$(wget -O- https://circuit-release.s3.us-west-2.amazonaws.com/setup/sha256sum)\nDOWNLOAD_RESULT=$?\nERROR=$(echo \"$P_CHECKSUMS\" | grep \"Error\")\n\nif [ $DOWNLOAD_RESULT -ne 0 ] || [ \"$ERROR\" != \"\" ]; then\necho \"Failed to download params checksums\"\necho \"$P_CHECKSUMS\"\nexit 1\nfi\n\nR_CHECKSUMS=$(wget -O- https://circuit-release.s3.us-west-2.amazonaws.com/release-$RELEASE_VERSION/sha256sum)\nDOWNLOAD_RESULT=$?\nERROR=$(echo \"$R_CHECKSUMS\" | grep \"Error\")\n\nif [ $DOWNLOAD_RESULT -ne 0 ] || [ \"$ERROR\" != \"\" ]; then\necho \"Failed to download release checksum\"\necho \"$R_CHECKSUMS\"\nexit 1\nfi\n\nPARAMS20_SHASUM=$(echo \"$P_CHECKSUMS\" | grep \"params20\" | cut -d \" \" -f 1)\nPARAMS21_SHASUM=$(echo \"$P_CHECKSUMS\" | grep \"params21\" | cut -d \" \" -f 1)\nPARAMS24_SHASUM=$(echo \"$P_CHECKSUMS\" | grep \"params24\" | cut -d \" \" -f 1)\nPARAMS25_SHASUM=$(echo \"$P_CHECKSUMS\" | grep \"params25\" | cut -d \" \" -f 1)\nPARAMS26_SHASUM=$(echo \"$P_CHECKSUMS\" | grep \"params26\" | cut -d \" \" -f 1)\nCHUNK_VK_SHASUM=$(echo \"$R_CHECKSUMS\" | grep \"chunk_vk.vkey\" | cut -d \" \" -f 1)\nBATCH_VK_SHASUM=$(echo \"$R_CHECKSUMS\" | grep \"agg_vk.vkey\" | cut -d \" \" -f 1)\nVRFR_SHASUM=$(echo \"$R_CHECKSUMS\" | grep \"evm_verifier.bin\" | cut -d \" \" -f 1)\nCFG2_SHASUM=$(echo \"$R_CHECKSUMS\" | grep \"layer2.config\" | cut -d \" \" -f 1)\nCFG4_SHASUM=$(echo \"$R_CHECKSUMS\" | grep \"layer4.config\" | cut -d \" \" -f 1)\n\ncheck_shasum () {\nSHASUM=$(shasum -a 256 $1 | cut -d \" \" -f 1)\nif [ \"$SHASUM\" != \"$2\" ]; then\necho \"Shasum mismatch: expected=$2, actual=$SHASUM\"\n  return 1;\n  else\n  return 0;\n  fi\n}\n# check existing file checksums\nif [ -f /data/params/params20 ]; then\nif ! check_shasum \"/data/params/params20\" \"$PARAMS20_SHASUM\"; then\necho \"Removing incorrect file /data/params/params20\\n\"\nrm /data/params/params20\nfi\nfi\n\nif [ -f /data/params/params21 ]; then\nif ! check_shasum \"/data/params/params21\" \"$PARAMS21_SHASUM\"; then\necho \"Removing incorrect file /data/params/params21\\n\"\nrm /data/params/params21\nfi\nfi\n\nif [ -f /data/params/params24 ]; then\nif ! check_shasum \"/data/params/params24\" \"$PARAMS24_SHASUM\"; then\necho \"Removing incorrect file /data/params/params24\\n\"\nrm /data/params/params24\nfi\nfi\n\nif [ -f /data/params/params25 ]; then\nif ! check_shasum \"/data/params/params25\" \"$PARAMS25_SHASUM\"; then\necho \"Removing incorrect file /data/params/params25\\n\"\nrm /data/params/params25\nfi\nfi\n\nif [ -f /data/params/params26 ]; then\nif ! check_shasum \"/data/params/params26\" \"$PARAMS26_SHASUM\"; then\necho \"Removing incorrect file /data/params/params26\\n\"\nrm /data/params/params26\nfi\nfi\n\nif [ -f /data/assets/chunk_vk.vkey ]; then\nif ! check_shasum \"/data/assets/chunk_vk.vkey\" \"$CHUNK_VK_SHASUM\"; then\necho \"Removing incorrect file /data/assets/chunk_vk.vkey\\n\"\nrm /data/assets/chunk_vk.vkey\nfi\nfi\n\nif [ -f /data/assets/agg_vk.vkey ]; then\nif ! check_shasum \"/data/assets/agg_vk.vkey\" \"$BATCH_VK_SHASUM\"; then\necho \"Removing incorrect file /data/assets/agg_vk.vkey\\n\"\nrm /data/assets/agg_vk.vkey\nfi\nfi\n\nif [ -f /data/assets/evm_verifier.bin ]; then\nif ! check_shasum \"/data/assets/evm_verifier.bin\" \"$VRFR_SHASUM\"; then\necho \"Removing incorrect file /data/assets/evm_verifier.bin\\n\"\nrm /data/assets/evm_verifier.bin\nfi\nfi\n\nif [ -f /data/assets/layer2.config ]; then\nif ! check_shasum \"/data/assets/layer2.config\" \"$CFG2_SHASUM\"; then\necho \"Removing incorrect file /data/assets/layer2.config\\n\"\nrm /data/assets/layer2.config\nfi\nfi\n\nif [ -f /data/assets/layer4.config ]; then\nif ! check_shasum \"/data/assets/layer4.config\" \"$CFG4_SHASUM\"; then\necho \"Removing incorrect file /data/assets/layer4.config\\n\"\nrm /data/assets/layer4.config\nfi\nfi\n\n\n# download missing files\n\nif [ ! -f /data/params/params20 ]; then\nmkdir -p /data/params\necho \"Downloading /data/params/params20...\"\nwget https://circuit-release.s3.us-west-2.amazonaws.com/setup/params20 -O /data/params/params20\necho \"Download completed\\n\"\nif ! check_shasum \"/data/params/params20\" \"$PARAMS20_SHASUM\"; then exit 1; fi\nfi\n\nif [ ! -f /data/params/params21 ]; then\nmkdir -p /data/params\necho \"Downloading /data/params/params21...\"\nwget https://circuit-release.s3.us-west-2.amazonaws.com/setup/params21 -O /data/params/params21\necho \"Download completed\\n\"\nif ! check_shasum \"/data/params/params21\" \"$PARAMS21_SHASUM\"; then exit 1; fi\nfi\n\nif [ ! -f /data/params/params24 ]; then\nmkdir -p /data/params\necho \"Downloading /data/params/params24...\"\nwget https://circuit-release.s3.us-west-2.amazonaws.com/setup/params24 -O /data/params/params24\necho \"Download completed\\n\"\nif ! check_shasum \"/data/params/params24\" \"$PARAMS24_SHASUM\"; then exit 1; fi\nfi\n\nif [ ! -f /data/params/params25 ]; then\nmkdir -p /data/params\necho \"Downloading /data/params/params25...\"\nwget https://circuit-release.s3.us-west-2.amazonaws.com/setup/params25 -O /data/params/params25\necho \"Download completed\\n\"\nif ! check_shasum \"/data/params/params25\" \"$PARAMS25_SHASUM\"; then exit 1; fi\nfi\n\nif [ ! -f /data/params/params26 ]; then\nmkdir -p /data/params\necho \"Downloading /data/params/params26...\"\nwget https://circuit-release.s3.us-west-2.amazonaws.com/setup/params26 -O /data/params/params26\necho \"Download completed\\n\"\nif ! check_shasum \"/data/params/params26\" \"$PARAMS26_SHASUM\"; then exit 1; fi\nfi\n\nif [ ! -f /data/assets/chunk_vk.vkey ]; then\nmkdir -p /data/assets\necho \"Downloading /data/assets/chunk_vk.vkey...\"\nwget https://circuit-release.s3.us-west-2.amazonaws.com/release-$RELEASE_VERSION/chunk_vk.vkey -O /data/assets/chunk_vk.vkey\necho \"Download completed\\n\"\nif ! check_shasum \"/data/assets/chunk_vk.vkey\" \"$CHUNK_VK_SHASUM\"; then exit 1; fi\nfi\n\nif [ ! -f /data/assets/agg_vk.vkey ]; then\nmkdir -p /data/assets\necho \"Downloading /data/assets/agg_vk.vkey...\"\nwget https://circuit-release.s3.us-west-2.amazonaws.com/release-$RELEASE_VERSION/agg_vk.vkey -O /data/assets/agg_vk.vkey\necho \"Download completed\\n\"\nif ! check_shasum \"/data/assets/agg_vk.vkey\" \"$BATCH_VK_SHASUM\"; then exit 1; fi\nfi\n\nif [ ! -f /data/assets/evm_verifier.bin ]; then\nmkdir -p /data/assets\necho \"Downloading /data/assets/evm_verifier.bin...\"\nwget https://circuit-release.s3.us-west-2.amazonaws.com/release-$RELEASE_VERSION/evm_verifier.bin -O /data/assets/evm_verifier.bin\necho \"Download completed\\n\"\nif ! check_shasum \"/data/assets/evm_verifier.bin\" \"$VRFR_SHASUM\"; then exit 1; fi\nfi\n\nif [ ! -f /data/assets/layer2.config ]; then\nmkdir -p /data/assets\necho \"Downloading /data/assets/layer2.config...\"\nwget https://circuit-release.s3.us-west-2.amazonaws.com/release-$RELEASE_VERSION/layer2.config -O /data/assets/layer2.config\necho \"Download completed\\n\"\nif ! check_shasum \"/data/assets/layer2.config\" \"$CFG2_SHASUM\"; then exit 1; fi\nfi\n\nif [ ! -f /data/assets/layer4.config ]; then\nmkdir -p /data/assets\necho \"Downloading /data/assets/layer4.config...\"\nwget https://circuit-release.s3.us-west-2.amazonaws.com/release-$RELEASE_VERSION/layer4.config -O /data/assets/layer4.config\necho \"Download completed\\n\"\nif ! check_shasum \"/data/assets/layer4.config\" \"$CFG4_SHASUM\"; then exit 1; fi\nfi\n\nls -l /data/assets\n"` |  |
| configMaps.download-params.enabled | bool | `true` |  |
| controller.replicas | int | `1` |  |
| controller.strategy | string | `"RollingUpdate"` |  |
| controller.type | string | `"statefulset"` |  |
| defaultProbes.custom | bool | `true` |  |
| defaultProbes.enabled | bool | `false` |  |
| defaultProbes.spec.httpGet.path | string | `"/"` |  |
| defaultProbes.spec.httpGet.port | int | `8090` |  |
| env[0].name | string | `"HTTP_PORT"` |  |
| env[0].value | int | `8080` |  |
| env[1].name | string | `"METRICS_PORT"` |  |
| env[1].value | int | `8090` |  |
| env[2].name | string | `"RUST_LOG"` |  |
| env[2].value | string | `"info"` |  |
| env[3].name | string | `"SCROLL_PROVER_ASSETS_DIR"` |  |
| env[3].value | string | `"/data/assets/"` |  |
| global.fullnameOverride | string | `"coordinator-api"` |  |
| global.nameOverride | string | `"coordinator-api"` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"scrolltech/coordinator-api"` |  |
| image.tag | string | `"v4.4.26-devnet"` |  |
| ingress.main.annotations | object | `{}` |  |
| ingress.main.enabled | bool | `true` |  |
| ingress.main.hosts[0].host | string | `"coordinator-api.scrollsdk"` |  |
| ingress.main.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.main.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.main.ingressClassName | string | `"nginx"` |  |
| ingress.main.labels | object | `{}` |  |
| ingress.main.primary | bool | `true` |  |
| initContainers.parameter-download.command[0] | string | `"sh"` |  |
| initContainers.parameter-download.command[1] | string | `"-c"` |  |
| initContainers.parameter-download.command[2] | string | `"/download-params.sh "` |  |
| initContainers.parameter-download.env[0].name | string | `"RELEASE_VERSION"` |  |
| initContainers.parameter-download.env[0].value | string | `"v0.11.4"` |  |
| initContainers.parameter-download.image | string | `"ubuntu"` |  |
| initContainers.parameter-download.resources.limits.cpu | string | `"2"` |  |
| initContainers.parameter-download.resources.limits.memory | string | `"4Gi"` |  |
| initContainers.parameter-download.resources.requests.cpu | string | `"1"` |  |
| initContainers.parameter-download.resources.requests.memory | string | `"2Gi"` |  |
| initContainers.parameter-download.volumeMounts[0].mountPath | string | `"/data"` |  |
| initContainers.parameter-download.volumeMounts[0].name | string | `"verifier"` |  |
| initContainers.parameter-download.volumeMounts[1].mountPath | string | `"/download-params.sh"` |  |
| initContainers.parameter-download.volumeMounts[1].name | string | `"download-params"` |  |
| initContainers.parameter-download.volumeMounts[1].subPath | string | `"download-params.sh"` |  |
| persistence.app_name.enabled | string | `"yes"` |  |
| persistence.app_name.mountPath | string | `"/coordinator/conf/"` |  |
| persistence.app_name.name | string | `"coordinator-config"` |  |
| persistence.app_name.type | string | `"configMap"` |  |
| persistence.download-params.defaultMode | string | `"0777"` |  |
| persistence.download-params.enabled | string | `"yes"` |  |
| persistence.download-params.mountPath | string | `"/download-params.sh"` |  |
| persistence.download-params.name | string | `"coordinator-api-download-params"` |  |
| persistence.download-params.type | string | `"configMap"` |  |
| persistence.genesis.enabled | string | `"yes"` |  |
| persistence.genesis.mountPath | string | `"/app/genesis/"` |  |
| persistence.genesis.name | string | `"genesis-config"` |  |
| persistence.genesis.type | string | `"configMap"` |  |
| probes.liveness.<<.custom | bool | `true` |  |
| probes.liveness.<<.enabled | bool | `false` |  |
| probes.liveness.<<.spec.httpGet.path | string | `"/"` |  |
| probes.liveness.<<.spec.httpGet.port | int | `8090` |  |
| probes.readiness.<<.custom | bool | `true` |  |
| probes.readiness.<<.enabled | bool | `false` |  |
| probes.readiness.<<.spec.httpGet.path | string | `"/"` |  |
| probes.readiness.<<.spec.httpGet.port | int | `8090` |  |
| probes.startup.<<.custom | bool | `true` |  |
| probes.startup.<<.enabled | bool | `false` |  |
| probes.startup.<<.spec.httpGet.path | string | `"/"` |  |
| probes.startup.<<.spec.httpGet.port | int | `8090` |  |
| service.main.enabled | bool | `true` |  |
| service.main.ports.http.enabled | bool | `true` |  |
| service.main.ports.http.port | int | `80` |  |
| service.main.ports.http.targetPort | int | `8080` |  |
| service.main.ports.metrics.enabled | bool | `true` |  |
| service.main.ports.metrics.port | int | `8090` |  |
| service.main.ports.metrics.targetPort | int | `8090` |  |
| serviceMonitor.main.enabled | bool | `true` |  |
| serviceMonitor.main.endpoints[0].interval | string | `"1m"` |  |
| serviceMonitor.main.endpoints[0].port | string | `"metrics"` |  |
| serviceMonitor.main.endpoints[0].scrapeTimeout | string | `"10s"` |  |
| serviceMonitor.main.labels.release | string | `"scroll-stack"` |  |
| serviceMonitor.main.serviceName | string | `"{{ include \"scroll.common.lib.chart.names.fullname\" $ }}"` |  |
| volumeClaimTemplates[0].accessMode | string | `"ReadWriteOnce"` |  |
| volumeClaimTemplates[0].mountPath | string | `"/verifier"` |  |
| volumeClaimTemplates[0].name | string | `"verifier"` |  |
| volumeClaimTemplates[0].size | string | `"50Gi"` |  |
| volumeClaimTemplates[0].storageClass | string | `"gp2"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
