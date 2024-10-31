# scroll-monitor

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

helm chart to deploy grafana, prometheus and loki to monitor scroll-sdk

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| scroll-tech | <sebastien@scroll.io> |  |

## Requirements

Kubernetes: `>=1.22.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://grafana.github.io/helm-charts | grafana | 8.5.0 |
| https://grafana.github.io/helm-charts | loki | 6.10.2 |
| https://grafana.github.io/helm-charts | promtail | 6.16.5 |
| https://prometheus-community.github.io/helm-charts | kube-prometheus-stack | 59.0.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| grafana.adminPassword | string | `"scroll-sdk"` |  |
| grafana.adminUser | string | `"admin"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".apiVersion | int | `1` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].disableDeletion | bool | `false` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].editable | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].folder | string | `"scroll"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].name | string | `"scroll"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].options.path | string | `"/var/lib/grafana/dashboards/scroll/"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].orgId | int | `1` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].type | string | `"file"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].disableDeletion | bool | `false` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].editable | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].folder | string | `"kubernetes"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].name | string | `"kubernetes"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].options.path | string | `"/var/lib/grafana/dashboards/kubernetes/"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].orgId | int | `1` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].type | string | `"file"` |  |
| grafana.dashboardsConfigMaps.kubernetes | string | `"grafana-kubernetes-dashboards"` |  |
| grafana.dashboardsConfigMaps.scroll | string | `"grafana-scroll-dashboards"` |  |
| grafana.datasources."datasources.yaml".apiVersion | int | `1` |  |
| grafana.datasources."datasources.yaml".datasources[0].access | string | `"proxy"` |  |
| grafana.datasources."datasources.yaml".datasources[0].isDefault | bool | `true` |  |
| grafana.datasources."datasources.yaml".datasources[0].jsonData.timeInterval | string | `"30s"` |  |
| grafana.datasources."datasources.yaml".datasources[0].name | string | `"Prometheus"` |  |
| grafana.datasources."datasources.yaml".datasources[0].type | string | `"prometheus"` |  |
| grafana.datasources."datasources.yaml".datasources[0].url | string | `"http://prometheus-prometheus:9090"` |  |
| grafana.datasources."datasources.yaml".datasources[1].access | string | `"proxy"` |  |
| grafana.datasources."datasources.yaml".datasources[1].jsonData.httpHeaderName1 | string | `"X-Scope-OrgID"` |  |
| grafana.datasources."datasources.yaml".datasources[1].name | string | `"Loki"` |  |
| grafana.datasources."datasources.yaml".datasources[1].secureJsonData.httpHeaderValue1 | string | `"1"` |  |
| grafana.datasources."datasources.yaml".datasources[1].type | string | `"loki"` |  |
| grafana.datasources."datasources.yaml".datasources[1].url | string | `"http://loki:3100"` |  |
| grafana.enabled | bool | `true` |  |
| grafana.fullnameOverride | string | `"grafana"` |  |
| grafana.ingress.enabled | bool | `true` |  |
| grafana.ingress.hosts[0] | string | `"grafana.scrollsdk"` |  |
| grafana.ingress.ingressClassName | string | `"nginx"` |  |
| grafana.nameOverride | string | `"grafana"` |  |
| kube-prometheus-stack.alertmanager.enabled | bool | `true` |  |
| kube-prometheus-stack.enabled | bool | `true` |  |
| kube-prometheus-stack.fullnameOverride | string | `"prometheus"` |  |
| kube-prometheus-stack.grafana.enabled | bool | `false` |  |
| kube-prometheus-stack.kube-state-metrics.fullnameOverride | string | `"kube-state-metrics"` |  |
| kube-prometheus-stack.kube-state-metrics.nameOverride | string | `"kube-state-metrics"` |  |
| kube-prometheus-stack.nameOverride | string | `"prometheus"` |  |
| kube-prometheus-stack.prometheus-node-exporter.fullnameOverride | string | `"node-exporter"` |  |
| kube-prometheus-stack.prometheus-node-exporter.nameOverride | string | `"node-exporter"` |  |
| kube-prometheus-stack.prometheus.enabled | bool | `true` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.alerting.alertmanagers[0].name | string | `"alertmanager-main"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.alerting.alertmanagers[0].namespace | string | `"default"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.alerting.alertmanagers[0].port | string | `"web"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.serviceMonitorSelector.matchExpressions[0].key | string | `"app.kubernetes.io/instance"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.serviceMonitorSelector.matchExpressions[0].operator | string | `"Exists"` |  |
| loki.backend.replicas | int | `0` |  |
| loki.deploymentMode | string | `"SingleBinary"` |  |
| loki.enabled | bool | `false` |  |
| loki.fullnameOverride | string | `"loki"` |  |
| loki.loki.commonConfig.replication_factor | int | `1` |  |
| loki.loki.schemaConfig.configs[0].from | string | `"2024-01-01"` |  |
| loki.loki.schemaConfig.configs[0].index.period | string | `"24h"` |  |
| loki.loki.schemaConfig.configs[0].index.prefix | string | `"loki_index_"` |  |
| loki.loki.schemaConfig.configs[0].object_store | string | `"filesystem"` |  |
| loki.loki.schemaConfig.configs[0].schema | string | `"v13"` |  |
| loki.loki.schemaConfig.configs[0].store | string | `"tsdb"` |  |
| loki.loki.storage.type | string | `"filesystem"` |  |
| loki.persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| loki.persistence.enabled | bool | `true` |  |
| loki.persistence.name | string | `"loki-pvc"` |  |
| loki.persistence.size | string | `"10Gi"` |  |
| loki.read.replicas | int | `0` |  |
| loki.singleBinary.replicas | int | `1` |  |
| loki.write.replicas | int | `0` |  |
| promtail.config.clients[0].tenant_id | int | `1` |  |
| promtail.config.clients[0].url | string | `"http://loki:3100/loki/api/v1/push"` |  |
| promtail.enabled | bool | `true` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
