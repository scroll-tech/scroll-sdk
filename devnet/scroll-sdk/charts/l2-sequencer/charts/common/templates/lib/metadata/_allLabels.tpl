{{/* Common labels shared across objects */}}
{{- define "scroll.common.lib.metadata.allLabels" -}}
helm.sh/chart: {{ include "scroll.common.lib.chart.names.chart" . }}
{{ include "scroll.common.lib.metadata.selectorLabels" . }}
  {{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
  {{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "scroll.common.lib.metadata.globalLabels" . }}
{{- end -}}
