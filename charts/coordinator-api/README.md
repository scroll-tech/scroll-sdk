# coordinator-api

![Version: 0.0.7](https://img.shields.io/badge/Version-0.0.7-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

coordinator-api helm charts

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
| command[2] | string | `"coordinator_api --config /coordinator/conf/coordinator-config.json --genesis /app/genesis/genesis.json --http --http.addr '0.0.0.0' --http.port ${HTTP_PORT} --metrics --metrics.addr '0.0.0.0' --metrics.port ${METRICS_PORT} --log.debug"` |  |
| configMaps.download-params.data."download-params.sh" | string | `"#!/bin/sh\nset -ex\napt update\napt install wget libdigest-sha-perl -y\n\nRELEASE_VERSION_HI=v0.13.1\nRELEASE_VERSION_LO=v0.12.0\n\ncase $CHAIN_ID in\n\"5343532222\") # staging network\n  echo \"staging network not supported\"\n  exit 1\n  ;;\n\"534353\") # alpha network\n  echo \"alpha network not supported\"\n  exit 1\n  ;;\nesac\n\nP_CHECKSUMS=$(wget -O- https://circuit-release.s3.us-west-2.amazonaws.com/setup/sha256sum)\n# DOWNLOAD_RESULT=$?\n# ERROR=$(echo \"$P_CHECKSUMS\" | grep \"Error\")\n\n# if [ $DOWNLOAD_RESULT -ne 0 ] || [ \"$ERROR\" != \"\" ]; then\n#   echo \"Failed to download params checksums\"\n#   echo \"$P_CHECKSUMS\"\n#   exit 1\n# fi\n\nR_CHECKSUMS_HI=$(wget -O- https://circuit-release.s3.us-west-2.amazonaws.com/release-$RELEASE_VERSION_HI/sha256sum)\n# DOWNLOAD_RESULT=$?\n# ERROR=$(echo \"$R_CHECKSUMS_HI\" | grep \"Error\")\n# if [ $DOWNLOAD_RESULT -ne 0 ] || [ \"$ERROR\" != \"\" ]; then\n#   echo \"Failed to download release checksum for $RELEASE_VERSION_HI\"\n#   echo \"$R_CHECKSUMS_HI\"\n#   exit 1\n# fi\n\nR_CHECKSUMS_LO=$(wget -O- https://circuit-release.s3.us-west-2.amazonaws.com/release-$RELEASE_VERSION_LO/sha256sum)\n# DOWNLOAD_RESULT=$?\n# ERROR=$(echo \"$R_CHECKSUMS_LO\" | grep \"Error\")\n# if [ $DOWNLOAD_RESULT -ne 0 ] || [ \"$ERROR\" != \"\" ]; then\n#   echo \"Failed to download release checksum for $RELEASE_VERSION_LO\"\n#   echo \"$R_CHECKSUMS_LO\"\n#   exit 1\n# fi\n\nPARAMS20_SHASUM=$(echo \"$P_CHECKSUMS\" | grep \"params20\" | cut -d \" \" -f 1)\nPARAMS21_SHASUM=$(echo \"$P_CHECKSUMS\" | grep \"params21\" | cut -d \" \" -f 1)\nPARAMS24_SHASUM=$(echo \"$P_CHECKSUMS\" | grep \"params24\" | cut -d \" \" -f 1)\nPARAMS25_SHASUM=$(echo \"$P_CHECKSUMS\" | grep \"params25\" | cut -d \" \" -f 1)\nPARAMS26_SHASUM=$(echo \"$P_CHECKSUMS\" | grep \"params26\" | cut -d \" \" -f 1)\n\n# assets_high\nVK_CHUNK_SHASUM_HI=$(echo \"$R_CHECKSUMS_HI\" | grep \"vk_chunk.vkey\" | cut -d \" \" -f 1)\nVK_BATCH_SHASUM_HI=$(echo \"$R_CHECKSUMS_HI\" | grep \"vk_batch.vkey\" | cut -d \" \" -f 1)\nVK_BUNDLE_SHASUM_HI=$(echo \"$R_CHECKSUMS_HI\" | grep \"vk_bundle.vkey\" | cut -d \" \" -f 1)\nVRFR_SHASUM_HI=$(echo \"$R_CHECKSUMS_HI\" | grep \"evm_verifier.bin\" | cut -d \" \" -f 1)\nCFG2_SHASUM_HI=$(echo \"$R_CHECKSUMS_HI\" | grep \"layer2.config\" | cut -d \" \" -f 1)\nCFG4_SHASUM_HI=$(echo \"$R_CHECKSUMS_HI\" | grep \"layer4.config\" | cut -d \" \" -f 1)\n\n# assets_low\nVK_CHUNK_SHASUM_LO=$(echo \"$R_CHECKSUMS_LO\" | grep \"vk_chunk.vkey\" | cut -d \" \" -f 1)\nVK_BATCH_SHASUM_LO=$(echo \"$R_CHECKSUMS_LO\" | grep \"vk_batch.vkey\" | cut -d \" \" -f 1)\nVK_BUNDLE_SHASUM_LO=$(echo \"$R_CHECKSUMS_LO\" | grep \"vk_bundle.vkey\" | cut -d \" \" -f 1)\nVRFR_SHASUM_LO=$(echo \"$R_CHECKSUMS_LO\" | grep \"evm_verifier.bin\" | cut -d \" \" -f 1)\nCFG2_SHASUM_LO=$(echo \"$R_CHECKSUMS_LO\" | grep \"layer2.config\" | cut -d \" \" -f 1)\nCFG4_SHASUM_LO=$(echo \"$R_CHECKSUMS_LO\" | grep \"layer4.config\" | cut -d \" \" -f 1)\n\ncheck_file() {\n  file=$1\n  url=$2\n  shasum=$3\n  if [ -f $file ]; then\n    SHASUM=$(shasum -a 256 $file | cut -d \" \" -f 1)\n    if [ \"$SHASUM\" != \"$shasum\" ]; then\n      echo \"Shasum mismatch: expected=$shasum, actual=$SHASUM, Removing incorrect file $file\"\n      rm $file\n      download_file $file $url $shasum\n    else\n      echo \"Shasum matched, no need to download\"\n    fi\n  else\n    download_file $file $url $shasum\n  fi\n}\n\n# download files\ndownload_file() {\n  file=$1\n  url=$2\n  shasum=$3\n  if [ ! -f $file ]; then\n    mkdir -p $(dirname $file)\n    echo \"Downloading $file...\"\n    wget --progress=dot:giga $url -O $file\n    echo \"Download completed $file\"\n    if [ $(shasum -a 256 $file | cut -d \" \" -f 1) != $shasum ];then exit 1;fi\n  fi\n}\n\n\nmain(){\n  case $1 in\n    \"params\")\n      # download params\n      # check_file \"/verifier/params/params20\" \"https://circuit-release.s3.us-west-2.amazonaws.com/setup/params20\" \"$PARAMS20_SHASUM\"\n      # check_file \"/verifier/params/params21\" \"https://circuit-release.s3.us-west-2.amazonaws.com/setup/params21\" \"$PARAMS21_SHASUM\"\n      # check_file \"/verifier/params/params24\" \"https://circuit-release.s3.us-west-2.amazonaws.com/setup/params24\" \"$PARAMS24_SHASUM\"\n      # check_file \"/verifier/params/params25\" \"https://circuit-release.s3.us-west-2.amazonaws.com/setup/params25\" \"$PARAMS25_SHASUM\"\n      check_file \"/verifier/params/params26\" \"https://circuit-release.s3.us-west-2.amazonaws.com/setup/params26\" \"$PARAMS26_SHASUM\"\n      ;;\n    \"assets\")\n      check_file \"/verifier/params/params20\" \"https://circuit-release.s3.us-west-2.amazonaws.com/setup/params20\" \"$PARAMS20_SHASUM\"\n      check_file \"/verifier/params/params21\" \"https://circuit-release.s3.us-west-2.amazonaws.com/setup/params21\" \"$PARAMS21_SHASUM\"\n      check_file \"/verifier/params/params24\" \"https://circuit-release.s3.us-west-2.amazonaws.com/setup/params24\" \"$PARAMS24_SHASUM\"\n      check_file \"/verifier/params/params25\" \"https://circuit-release.s3.us-west-2.amazonaws.com/setup/params25\" \"$PARAMS25_SHASUM\"\n\n      # download assets_hi\n      check_file \"/verifier/assets/hi/vk_chunk.vkey\" \"https://circuit-release.s3.us-west-2.amazonaws.com/release-$RELEASE_VERSION_HI/vk_chunk.vkey\" \"$VK_CHUNK_SHASUM_HI\"\n      check_file \"/verifier/assets/hi/vk_batch.vkey\" \"https://circuit-release.s3.us-west-2.amazonaws.com/release-$RELEASE_VERSION_HI/vk_batch.vkey\" \"$VK_BATCH_SHASUM_HI\"\n      check_file \"/verifier/assets/hi/vk_bundle.vkey\" \"https://circuit-release.s3.us-west-2.amazonaws.com/release-$RELEASE_VERSION_HI/vk_bundle.vkey\" \"$VK_BUNDLE_SHASUM_HI\"\n      check_file \"/verifier/assets/hi/evm_verifier.bin\" \"https://circuit-release.s3.us-west-2.amazonaws.com/release-$RELEASE_VERSION_HI/evm_verifier.bin\" \"$VRFR_SHASUM_HI\"\n      check_file \"/verifier/assets/hi/layer2.config\" \"https://circuit-release.s3.us-west-2.amazonaws.com/release-$RELEASE_VERSION_HI/layer2.config\" \"$CFG2_SHASUM_HI\"\n      check_file \"/verifier/assets/hi/layer4.config\" \"https://circuit-release.s3.us-west-2.amazonaws.com/release-$RELEASE_VERSION_HI/layer4.config\" \"$CFG4_SHASUM_HI\"\n      # download assets_low\n      check_file \"/verifier/assets/lo/vk_chunk.vkey\" \"https://circuit-release.s3.us-west-2.amazonaws.com/release-$RELEASE_VERSION_LO/vk_chunk.vkey\" \"$VK_CHUNK_SHASUM_LO\"\n      check_file \"/verifier/assets/lo/vk_batch.vkey\" \"https://circuit-release.s3.us-west-2.amazonaws.com/release-$RELEASE_VERSION_LO/vk_batch.vkey\" \"$VK_BATCH_SHASUM_LO\"\n      check_file \"/verifier/assets/lo/vk_bundle.vkey\" \"https://circuit-release.s3.us-west-2.amazonaws.com/release-$RELEASE_VERSION_LO/vk_bundle.vkey\" \"$VK_BUNDLE_SHASUM_LO\"\n      check_file \"/verifier/assets/lo/evm_verifier.bin\" \"https://circuit-release.s3.us-west-2.amazonaws.com/release-$RELEASE_VERSION_LO/evm_verifier.bin\" \"$VRFR_SHASUM_LO\"\n      check_file \"/verifier/assets/lo/layer2.config\" \"https://circuit-release.s3.us-west-2.amazonaws.com/release-$RELEASE_VERSION_LO/layer2.config\" \"$CFG2_SHASUM_LO\"\n      check_file \"/verifier/assets/lo/layer4.config\" \"https://circuit-release.s3.us-west-2.amazonaws.com/release-$RELEASE_VERSION_LO/layer4.config\" \"$CFG4_SHASUM_LO\"\n      ;;\n      *)\n        echo \"only supports params or assets\"\n        exit 1\n        ;;\n  esac\n}\n\nmain $1\nls -R /verifier/assets\n"` |  |
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
| image.tag | string | `"v4.4.59"` |  |
| ingress.main.annotations | object | `{}` |  |
| ingress.main.enabled | bool | `true` |  |
| ingress.main.hosts[0].host | string | `"coordinator-api.scrollsdk"` |  |
| ingress.main.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.main.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.main.ingressClassName | string | `"nginx"` |  |
| ingress.main.labels | object | `{}` |  |
| ingress.main.primary | bool | `true` |  |
| initContainers.assets-download.command[0] | string | `"sh"` |  |
| initContainers.assets-download.command[1] | string | `"-c"` |  |
| initContainers.assets-download.command[2] | string | `"/download-params.sh assets"` |  |
| initContainers.assets-download.image | string | `"ubuntu"` |  |
| initContainers.assets-download.volumeMounts[0].mountPath | string | `"/verifier"` |  |
| initContainers.assets-download.volumeMounts[0].name | string | `"verifier"` |  |
| initContainers.assets-download.volumeMounts[1].mountPath | string | `"/download-params.sh"` |  |
| initContainers.assets-download.volumeMounts[1].name | string | `"download-params"` |  |
| initContainers.assets-download.volumeMounts[1].subPath | string | `"download-params.sh"` |  |
| initContainers.parameter-download.command[0] | string | `"sh"` |  |
| initContainers.parameter-download.command[1] | string | `"-c"` |  |
| initContainers.parameter-download.command[2] | string | `"/download-params.sh params"` |  |
| initContainers.parameter-download.image | string | `"ubuntu"` |  |
| initContainers.parameter-download.resources.limits.cpu | string | `"2"` |  |
| initContainers.parameter-download.resources.limits.memory | string | `"8Gi"` |  |
| initContainers.parameter-download.resources.requests.cpu | string | `"1"` |  |
| initContainers.parameter-download.resources.requests.memory | string | `"2Gi"` |  |
| initContainers.parameter-download.volumeMounts[0].mountPath | string | `"/verifier"` |  |
| initContainers.parameter-download.volumeMounts[0].name | string | `"verifier"` |  |
| initContainers.parameter-download.volumeMounts[1].mountPath | string | `"/download-params.sh"` |  |
| initContainers.parameter-download.volumeMounts[1].name | string | `"download-params"` |  |
| initContainers.parameter-download.volumeMounts[1].subPath | string | `"download-params.sh"` |  |
| persistence.app_name.enabled | bool | `true` |  |
| persistence.app_name.mountPath | string | `"/coordinator/conf/"` |  |
| persistence.app_name.name | string | `"coordinator-api-config"` |  |
| persistence.app_name.type | string | `"configMap"` |  |
| persistence.download-params.defaultMode | string | `"0777"` |  |
| persistence.download-params.enabled | bool | `true` |  |
| persistence.download-params.mountPath | string | `"/download-params.sh"` |  |
| persistence.download-params.name | string | `"coordinator-api-download-params"` |  |
| persistence.download-params.type | string | `"configMap"` |  |
| persistence.genesis.enabled | bool | `true` |  |
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
| resources.limits.cpu | string | `"200m"` |  |
| resources.limits.memory | string | `"24Gi"` |  |
| resources.requests.cpu | string | `"50m"` |  |
| resources.requests.memory | string | `"20Gi"` |  |
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
| serviceMonitor.main.labels.release | string | `"scroll-sdk"` |  |
| serviceMonitor.main.serviceName | string | `"{{ include \"scroll.common.lib.chart.names.fullname\" $ }}"` |  |
| volumeClaimTemplates[0].accessMode | string | `"ReadWriteOnce"` |  |
| volumeClaimTemplates[0].mountPath | string | `"/verifier"` |  |
| volumeClaimTemplates[0].name | string | `"verifier"` |  |
| volumeClaimTemplates[0].size | string | `"100Gi"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
