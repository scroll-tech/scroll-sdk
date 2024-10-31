# scroll-sdk

![Version: 0.0.59](https://img.shields.io/badge/Version-0.0.59-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

scroll helm charts to deploy scroll sdk

**Homepage:** <https://github.com/scroll-tech/scroll-sdk>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| scroll-tech | <sebastien@scroll.io> |  |

## Requirements

Kubernetes: `>=1.22.0-0`

| Repository | Name | Version |
|------------|------|---------|
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | admin-system-backend | 0.0.2 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | admin-system-cron | 0.0.2 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | admin-system-dashboard | 0.0.2 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | balance-checker | 0.0.5 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | blockscout | 0.0.4 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | blockscout-sc-verifier | 0.0.2 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | bridge-history-api | 0.0.8 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | bridge-history-fetcher | 0.0.12 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | chain-monitor | 0.0.11 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | contracts | 0.0.16 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | coordinator-api | 0.0.9 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | coordinator-cron | 0.0.7 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | frontends | 0.0.10 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | gas-oracle | 0.0.11 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | l1-devnet | 0.0.3 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | l1-explorer | 0.0.3 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | l2-bootnode | 0.0.16 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | l2-rpc | 0.0.16 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | l2-sequencer | 0.0.15 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | rollup-explorer-backend | 0.0.4 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | rollup-node | 0.0.15 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | rpc-gateway | 0.0.2 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | scroll-common | 0.0.5 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | scroll-monitor | 0.0.6 |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 15.5.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| admin-system-backend.enabled | bool | `true` |  |
| admin-system-cron.enabled | bool | `true` |  |
| admin-system-dashboard.enabled | bool | `true` |  |
| admin-system-dashboard.ingress.main.enabled | bool | `true` |  |
| admin-system-dashboard.ingress.main.hosts[0].host | string | `"admin-system-dashboard.scrollsdk"` |  |
| admin-system-dashboard.ingress.main.hosts[0].paths[0].path | string | `"/"` |  |
| admin-system-dashboard.ingress.main.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| balance-checker.enabled | bool | `true` |  |
| blockscout-sc-verifier.enabled | bool | `false` |  |
| blockscout.enabled | bool | `true` |  |
| bridge-history-api.enabled | bool | `true` |  |
| bridge-history-api.ingress.main.annotations | object | `{}` |  |
| bridge-history-api.ingress.main.enabled | bool | `true` |  |
| bridge-history-api.ingress.main.hosts[0].host | string | `"bridge-history-api.scrollsdk"` |  |
| bridge-history-api.ingress.main.hosts[0].paths[0].path | string | `"/"` |  |
| bridge-history-api.ingress.main.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| bridge-history-api.ingress.main.ingressClassName | string | `"nginx"` |  |
| bridge-history-api.ingress.main.labels | object | `{}` |  |
| bridge-history-api.ingress.main.primary | bool | `true` |  |
| bridge-history-fetcher.enabled | bool | `true` |  |
| chain-monitor.enabled | bool | `true` |  |
| contracts.enabled | bool | `true` |  |
| coordinator-api.enabled | bool | `false` |  |
| coordinator-cron.enabled | bool | `false` |  |
| db | object | `{"bridge_history_password":"test1234","chain_monitor_password":"test1234","gas_oracle_password":"test1234","pg_host":"postgresql","pg_password":"qwerty12345","pg_port":"5432","pg_user":"postgres","rollup_node_password":"test1234","rpc_gateway_password":"test1234"}` | each services. A user with admin privilege is required. |
| frontends.enabled | bool | `true` |  |
| frontends.ingress.main.enabled | bool | `true` |  |
| frontends.ingress.main.hosts[0].host | string | `"frontends.scrollsdk"` |  |
| frontends.ingress.main.hosts[0].paths[0].path | string | `"/"` |  |
| frontends.ingress.main.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| gas-oracle.enabled | bool | `true` |  |
| l1-devnet.enabled | bool | `true` |  |
| l1-devnet.ingress.main.enabled | bool | `true` |  |
| l1-devnet.ingress.main.hosts[0].host | string | `"l1-devnet.scrollsdk"` |  |
| l1-devnet.ingress.main.hosts[0].paths[0].path | string | `"/"` |  |
| l1-devnet.ingress.main.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| l1-explorer.enabled | bool | `true` |  |
| l1-explorer.ingress.main.enabled | bool | `true` |  |
| l1-explorer.ingress.main.hosts[0].host | string | `"l1-explorer.scrollsdk"` |  |
| l1-explorer.ingress.main.hosts[0].paths[0].path | string | `"/"` |  |
| l1-explorer.ingress.main.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| l1-explorer.ingress.main.ingressClassName | string | `"nginx"` |  |
| l2-bootnode.enabled | bool | `true` |  |
| l2-rpc.enabled | bool | `true` |  |
| l2-rpc.ingress.main.enabled | bool | `true` |  |
| l2-rpc.ingress.main.hosts[0].host | string | `"l2-rpc.scrollsdk"` |  |
| l2-rpc.ingress.main.hosts[0].paths[0].path | string | `"/"` |  |
| l2-rpc.ingress.main.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| l2-rpc.ingress.main.ingressClassName | string | `"nginx"` |  |
| l2-sequencer.enabled | bool | `true` |  |
| postgresql.auth.enablePostgresUser | bool | `true` |  |
| postgresql.auth.postgresPassword | string | `"qwerty12345"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.fullnameOverride | string | `"postgresql"` |  |
| postgresql.nameOverride | string | `"postgresql"` |  |
| postgresql.primary.extendedConfiguration | string | `"max_connections = 400\n"` |  |
| postgresql.primary.livenessProbe.enabled | bool | `false` |  |
| postgresql.primary.persistentVolumeClaimRetentionPolicy.enabled | bool | `true` |  |
| postgresql.primary.persistentVolumeClaimRetentionPolicy.whenDeleted | string | `"Delete"` |  |
| postgresql.primary.persistentVolumeClaimRetentionPolicy.whenScaled | string | `"Delete"` |  |
| postgresql.primary.readinessProbe.enabled | bool | `false` |  |
| postgresql.primary.resources.limits.cpu | int | `3` |  |
| postgresql.primary.resources.limits.memory | string | `"1024Mi"` |  |
| postgresql.primary.resources.requests.cpu | int | `1` |  |
| postgresql.primary.resources.requests.memory | string | `"512Mi"` |  |
| postgresql.primary.startupProbe.enabled | bool | `false` |  |
| postgresql.tls.autoGenerated | bool | `true` |  |
| postgresql.tls.enabled | bool | `true` |  |
| postgresql.volumePermissions.enabled | bool | `true` |  |
| rollup-explorer-backend.enabled | bool | `true` |  |
| rollup-explorer-backend.ingress.main.annotations | object | `{}` |  |
| rollup-explorer-backend.ingress.main.enabled | bool | `true` |  |
| rollup-explorer-backend.ingress.main.hosts[0].host | string | `"rollup-explorer-backend.scrollsdk"` |  |
| rollup-explorer-backend.ingress.main.hosts[0].paths[0].path | string | `"/"` |  |
| rollup-explorer-backend.ingress.main.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| rollup-explorer-backend.ingress.main.ingressClassName | string | `"nginx"` |  |
| rollup-explorer-backend.ingress.main.labels | object | `{}` |  |
| rollup-explorer-backend.ingress.main.primary | bool | `true` |  |
| rollup-node.enabled | bool | `true` |  |
| rpc-gateway.enabled | bool | `false` |  |
| rpc-gateway.ingress.main.enabled | bool | `true` |  |
| rpc-gateway.ingress.main.hosts[0].host | string | `"l2-rpc-gateway.scrollsdk"` |  |
| rpc-gateway.ingress.main.hosts[0].paths[0].path | string | `"/"` |  |
| rpc-gateway.ingress.main.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| rpc-gateway.ingress.main.ingressClassName | string | `"nginx"` |  |
| scroll-common.enabled | bool | `true` |  |
| scroll-monitor.enabled | bool | `true` |  |
| scroll-monitor.grafana.enabled | bool | `true` |  |
| scroll-monitor.grafana.ingress.enabled | bool | `true` |  |
| scroll-monitor.grafana.ingress.hosts[0] | string | `"grafana.scrollsdk"` |  |
| scroll-monitor.grafana.ingress.ingressClassName | string | `"nginx"` |  |
| scroll-monitor.kube-prometheus-stack.enabled | bool | `true` |  |
| scroll-monitor.loki.enabled | bool | `true` |  |
| scroll-monitor.promtail.enabled | bool | `true` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
