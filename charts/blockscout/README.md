# blockscout

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

blockscout scroll helm charts

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| scroll-tech | <sebastien@scroll.io> |  |

## Requirements

Kubernetes: `>=1.22.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://blockscout.github.io/helm-charts | blockscout-stack | 1.6.8 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | external-secrets-lib | 0.0.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| blockscout-stack.blockscout.env.BLOCK_TRANSFORMER | string | `"clique"` |  |
| blockscout-stack.blockscout.env.CHAIN_TYPE | string | `"scroll"` |  |
| blockscout-stack.blockscout.env.ECTO_USE_SSL | bool | `false` |  |
| blockscout-stack.blockscout.env.ETHEREUM_JSONRPC_HTTP_INSECURE | bool | `true` |  |
| blockscout-stack.blockscout.env.ETHEREUM_JSONRPC_HTTP_URL | string | `"http://l2-rpc:8545"` |  |
| blockscout-stack.blockscout.env.ETHEREUM_JSONRPC_TRACE_URL | string | `"http://l2-rpc:8545"` |  |
| blockscout-stack.blockscout.env.ETHEREUM_JSONRPC_VARIANT | string | `"geth"` |  |
| blockscout-stack.blockscout.env.ETHEREUM_JSONRPC_WS_URL | string | `"ws://l2-rpc:8546"` |  |
| blockscout-stack.blockscout.env.INDEXER_DISABLE_PENDING_TRANSACTIONS_FETCHER | bool | `true` |  |
| blockscout-stack.blockscout.env.INDEXER_SCROLL_L1_ETH_GET_LOGS_RANGE_SIZE | int | `500` |  |
| blockscout-stack.blockscout.env.INDEXER_SCROLL_L2_ETH_GET_LOGS_RANGE_SIZE | int | `500` |  |
| blockscout-stack.blockscout.env.INDEXER_SCROLL_L2_MESSENGER_START_BLOCK | int | `0` |  |
| blockscout-stack.blockscout.env.SCROLL_L2_CURIE_UPGRADE_BLOCK | int | `0` |  |
| blockscout-stack.blockscout.envFrom[0].configMapRef.name | string | `"blockscout-env"` |  |
| blockscout-stack.blockscout.image.pullPolicy | string | `"IfNotPresent"` |  |
| blockscout-stack.blockscout.image.repository | string | `"blockscout/blockscout-scroll"` |  |
| blockscout-stack.blockscout.image.tag | string | `"6.9.0-alpha.1"` |  |
| blockscout-stack.blockscout.ingress.annotations."nginx.ingress.kubernetes.io/cors-allow-headers" | string | `"updated-gas-oracle, Content-Type, Authorization"` |  |
| blockscout-stack.blockscout.ingress.annotations."nginx.ingress.kubernetes.io/cors-allow-methods" | string | `"GET, POST, OPTIONS"` |  |
| blockscout-stack.blockscout.ingress.annotations."nginx.ingress.kubernetes.io/cors-allow-origin" | string | `"http://blockscout.scrollsdk"` |  |
| blockscout-stack.blockscout.ingress.annotations."nginx.ingress.kubernetes.io/cors-max-age" | string | `"86400"` |  |
| blockscout-stack.blockscout.ingress.annotations."nginx.ingress.kubernetes.io/enable-cors" | string | `"true"` |  |
| blockscout-stack.blockscout.ingress.className | string | `"nginx"` |  |
| blockscout-stack.blockscout.ingress.enabled | bool | `true` |  |
| blockscout-stack.blockscout.ingress.hostname | string | `"blockscout-backend.scrollsdk"` |  |
| blockscout-stack.frontend.env.FAVICON_MASTER_URL | string | `"https://raw.githubusercontent.com/blockscout/frontend-configs/main/configs/favicons/scroll_180x180.png"` |  |
| blockscout-stack.frontend.env.NEXT_PUBLIC_AD_BANNER_PROVIDER | string | `"none"` |  |
| blockscout-stack.frontend.env.NEXT_PUBLIC_AD_TEXT_PROVIDER | string | `"none"` |  |
| blockscout-stack.frontend.env.NEXT_PUBLIC_API_HOST | string | `"blockscout-backend.scrollsdk"` |  |
| blockscout-stack.frontend.env.NEXT_PUBLIC_API_PROTOCOL | string | `"http"` |  |
| blockscout-stack.frontend.env.NEXT_PUBLIC_API_WEBSOCKET_PROTOCOL | string | `"ws"` |  |
| blockscout-stack.frontend.env.NEXT_PUBLIC_APP_PROTOCOL | string | `"http"` |  |
| blockscout-stack.frontend.env.NEXT_PUBLIC_HOMEPAGE_CHARTS | string | `"[\"daily_txs\"]"` |  |
| blockscout-stack.frontend.env.NEXT_PUBLIC_HOMEPAGE_HERO_BANNER_CONFIG | string | `"{'background':['rgba(255, 238, 218, 1)'],'text_color':['rgba(25, 6, 2, 1)']}"` |  |
| blockscout-stack.frontend.env.NEXT_PUBLIC_HOMEPAGE_STATS | string | `"[\"total_blocks\", \"average_block_time\", \"total_txs\", \"wallet_addresses\", \"gas_tracker\"]"` |  |
| blockscout-stack.frontend.env.NEXT_PUBLIC_NETWORK_ICON | string | `"https://raw.githubusercontent.com/blockscout/frontend-configs/main/configs/network-icons/scroll.svg"` |  |
| blockscout-stack.frontend.env.NEXT_PUBLIC_NETWORK_ICON_DARK | string | `"https://raw.githubusercontent.com/blockscout/frontend-configs/main/configs/network-icons/scroll-dark.svg"` |  |
| blockscout-stack.frontend.env.NEXT_PUBLIC_NETWORK_LOGO | string | `"https://raw.githubusercontent.com/blockscout/frontend-configs/main/configs/network-logos/scroll.svg"` |  |
| blockscout-stack.frontend.env.NEXT_PUBLIC_NETWORK_LOGO_DARK | string | `"https://raw.githubusercontent.com/blockscout/frontend-configs/main/configs/network-logos/scroll-dark.svg"` |  |
| blockscout-stack.frontend.env.NEXT_PUBLIC_OG_IMAGE_URL | string | `"https://raw.githubusercontent.com/blockscout/frontend-configs/main/configs/og-images/scroll-sepolia.png"` |  |
| blockscout-stack.frontend.image.tag | string | `"v1.35.2"` |  |
| blockscout-stack.frontend.ingress.annotations."nginx.ingress.kubernetes.io/cors-allow-headers" | string | `"updated-gas-oracle, Content-Type, Authorization"` |  |
| blockscout-stack.frontend.ingress.annotations."nginx.ingress.kubernetes.io/cors-allow-methods" | string | `"GET, POST, OPTIONS"` |  |
| blockscout-stack.frontend.ingress.annotations."nginx.ingress.kubernetes.io/cors-allow-origin" | string | `"http://blockscout.scrollsdk"` |  |
| blockscout-stack.frontend.ingress.annotations."nginx.ingress.kubernetes.io/cors-max-age" | string | `"86400"` |  |
| blockscout-stack.frontend.ingress.annotations."nginx.ingress.kubernetes.io/enable-cors" | string | `"true"` |  |
| blockscout-stack.frontend.ingress.className | string | `"nginx"` |  |
| blockscout-stack.frontend.ingress.enabled | bool | `true` |  |
| blockscout-stack.frontend.ingress.hostname | string | `"blockscout.scrollsdk"` |  |
| blockscout-stack.fullnameOverride | string | `"blockscout"` |  |
| blockscout-stack.imagePullSecrets[0].name | string | `"docker-secret"` |  |
| blockscout-stack.nameOverride | string | `"blockscout"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
