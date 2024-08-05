{{/* Selector labels shared across objects */}}
{{- define "scroll.common.lib.metadata.selectorLabels" -}}
app.kubernetes.io/name: {{ include "scroll.common.lib.chart.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
