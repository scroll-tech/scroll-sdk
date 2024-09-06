# scroll-sdk

![Version: 0.0.27](https://img.shields.io/badge/Version-0.0.27-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

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
| https://grafana.github.io/helm-charts | grafana | 7.3.11 |
| https://grafana.github.io/helm-charts | loki-stack | 2.10.2 |
| https://prometheus-community.github.io/helm-charts | kube-prometheus-stack | 59.0.0 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | balance-checker | 0.0.2 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | blockscout | 0.0.3 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | blockscout-sc-verifier | 0.0.2 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | bridge-history-api | 0.0.6 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | bridge-history-fetcher | 0.0.7 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | chain-monitor | 0.0.5 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | contracts | 0.0.5 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | coordinator-api | 0.0.6 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | coordinator-cron | 0.0.6 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | frontends | 0.0.6 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | gas-oracle | 0.0.6 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | l1-devnet | 0.0.3 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | l1-explorer | 0.0.2 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | l2-bootnode | 0.0.8 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | l2-rpc | 0.0.9 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | l2-sequencer | 0.0.9 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | rollup-explorer-backend | 0.0.3 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | rollup-node | 0.0.8 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | rpc-gateway | 0.0.2 |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 15.5.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| balance-checker.enabled | bool | `false` |  |
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
| db | object | `{"bridge_history_password":"test1234","chain_monitor_password":"test1234","event_watcher_password":"test1234","gas_oracle_password":"test1234","pg_host":"postgresql","pg_password":"qwerty12345","pg_port":"5432","pg_user":"postgres","rollup_node_password":"test1234","rpc_gateway_password":"test1234"}` | each services. A user with admin privilege is required. |
| frontends.enabled | bool | `true` |  |
| frontends.ingress.main.enabled | bool | `true` |  |
| frontends.ingress.main.hosts[0].host | string | `"frontends.scrollsdk"` |  |
| frontends.ingress.main.hosts[0].paths[0].path | string | `"/"` |  |
| frontends.ingress.main.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| gas-oracle.enabled | bool | `true` |  |
| grafana.adminPassword | string | `"scroll-sdk"` |  |
| grafana.adminUser | string | `"admin"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".apiVersion | int | `1` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].disableDeletion | bool | `false` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].editable | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].folder | string | `"scroll"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].name | string | `"default"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].options.path | string | `"/var/lib/grafana/dashboards/default/"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].orgId | int | `1` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].type | string | `"file"` |  |
| grafana.dashboardsConfigMaps.default | string | `"grafana-dashboards"` |  |
| grafana.datasources."datasources.yaml".apiVersion | int | `1` |  |
| grafana.datasources."datasources.yaml".datasources[0].access | string | `"proxy"` |  |
| grafana.datasources."datasources.yaml".datasources[0].isDefault | bool | `true` |  |
| grafana.datasources."datasources.yaml".datasources[0].jsonData.timeInterval | string | `"30s"` |  |
| grafana.datasources."datasources.yaml".datasources[0].name | string | `"Prometheus"` |  |
| grafana.datasources."datasources.yaml".datasources[0].type | string | `"prometheus"` |  |
| grafana.datasources."datasources.yaml".datasources[0].url | string | `"http://prometheus-prometheus:9090"` |  |
| grafana.datasources."datasources.yaml".datasources[1].access | string | `"proxy"` |  |
| grafana.datasources."datasources.yaml".datasources[1].jsonData.httpHeaderName1 | string | `"X-Scope-OrgID"` |  |
| grafana.datasources."datasources.yaml".datasources[1].jsonData.secureJsonData.httpHeaderValue1 | string | `"1"` |  |
| grafana.datasources."datasources.yaml".datasources[1].name | string | `"Loki"` |  |
| grafana.datasources."datasources.yaml".datasources[1].type | string | `"loki"` |  |
| grafana.datasources."datasources.yaml".datasources[1].url | string | `"http://loki:3100"` |  |
| grafana.enabled | bool | `true` |  |
| grafana.fullnameOverride | string | `"grafana"` |  |
| grafana.ingress.enabled | bool | `true` |  |
| grafana.ingress.hosts[0] | string | `"grafana.scrollsdk"` |  |
| grafana.nameOverride | string | `"grafana"` |  |
| kube-prometheus-stack.alertmanager.enabled | bool | `false` |  |
| kube-prometheus-stack.enabled | bool | `true` |  |
| kube-prometheus-stack.fullnameOverride | string | `"prometheus"` |  |
| kube-prometheus-stack.grafana.enabled | bool | `false` |  |
| kube-prometheus-stack.kube-state-metrics.fullnameOverride | string | `"kube-state-metrics"` |  |
| kube-prometheus-stack.kube-state-metrics.nameOverride | string | `"kube-state-metrics"` |  |
| kube-prometheus-stack.nameOverride | string | `"prometheus"` |  |
| kube-prometheus-stack.prometheus-node-exporter.fullnameOverride | string | `"node-exporter"` |  |
| kube-prometheus-stack.prometheus-node-exporter.nameOverride | string | `"node-exporter"` |  |
| kube-prometheus-stack.prometheus.enabled | bool | `true` |  |
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
| loki-stack.enabled | bool | `true` |  |
| loki-stack.loki.fullnameOverride | string | `"loki"` |  |
| loki-stack.loki.nameOverride | string | `"loki"` |  |
| loki-stack.promtail.config.clients[0].url | string | `"http://loki:3100/loki/api/v1/push"` |  |
| loki-stack.promtail.enabled | bool | `true` |  |
| loki-stack.promtail.fullnameOverride | string | `"promtail"` |  |
| loki-stack.promtail.nameOverride | string | `"promtail"` |  |
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

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
