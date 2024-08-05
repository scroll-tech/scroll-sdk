{{/*
Renders the controller object required by the chart.
*/}}
{{- define "scroll.common.render.controller" -}}
  {{- if .Values.controller.enabled -}}
    {{- if eq .Values.controller.type "deployment" -}}
      {{- include "scroll.common.class.deployment" . | nindent 0 -}}
    {{- else if eq .Values.controller.type "cronjob" -}}
      {{- include "scroll.common.class.cronjob" . | nindent 0 -}}
    {{ else if eq .Values.controller.type "daemonset" -}}
      {{- include "scroll.common.class.daemonset" . | nindent 0 -}}
    {{ else if eq .Values.controller.type "statefulset"  -}}
      {{- include "scroll.common.class.statefulset" . | nindent 0 -}}
    {{ else -}}
      {{- fail (printf "Not a valid controller.type (%s)" .Values.controller.type) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
