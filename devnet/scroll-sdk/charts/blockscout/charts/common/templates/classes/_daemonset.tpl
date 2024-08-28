{{/*
This template serves as the blueprint for the DaemonSet objects that are created
within the common library.
*/}}
{{- define "scroll.common.class.daemonset" -}}
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: {{ include "scroll.common.lib.chart.names.fullname" . }}
  {{- with include "scroll.common.lib.controller.metadata.labels" . }}
  labels: {{- . | nindent 4 }}
  {{- end }}
  {{- with include "scroll.common.lib.controller.metadata.annotations" . }}
  annotations: {{- . | nindent 4 }}
  {{- end }}
spec:
  revisionHistoryLimit: {{ .Values.controller.revisionHistoryLimit }}
  selector:
    matchLabels:
      {{- include "scroll.common.lib.metadata.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      {{- with include ("scroll.common.lib.metadata.podAnnotations") . }}
      annotations:
        {{- . | nindent 8 }}
      {{- end }}
      labels:
        {{- include "scroll.common.lib.metadata.selectorLabels" . | nindent 8 }}
        {{- with .Values.podLabels }}
        {{- toYaml . | nindent 8 }}
        {{- end }}
    spec:
      {{- include "scroll.common.lib.controller.pod" . | nindent 6 }}
{{- end }}
