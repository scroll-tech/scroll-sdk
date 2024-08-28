{{/*
Secondary entrypoint and primary loader for the common chart
*/}}
{{- define "scroll.common.loader.generate" -}}
  {{- /* Enable code-server add-on if required */ -}}
  {{- if .Values.addons.codeserver.enabled -}}
    {{- include "scroll.common.addon.codeserver" . | nindent 0 -}}
  {{- end -}}

  {{- /* Enable VPN add-on if required */ -}}
  {{- if .Values.addons.vpn.enabled -}}
    {{- include "scroll.common.addon.vpn" . | nindent 0 -}}
  {{- end -}}

  {{- /* Enable netshoot add-on if required */ -}}
  {{- if .Values.addons.netshoot.enabled -}}
    {{- include "scroll.common.addon.netshoot" . | nindent 0 -}}
  {{- end -}}

  {{- /* Build the templates */ -}}
  {{- include "scroll.common.render.pvcs" . | nindent 0 -}}
  {{- include "scroll.common.render.serviceAccount" . | nindent 0 -}}
  {{- include "scroll.common.render.controller" . | nindent 0 -}}
  {{- include "scroll.common.render.services" . | nindent 0 -}}
  {{- include "scroll.common.render.ingresses" . | nindent 0 -}}
  {{- include "scroll.common.render.serviceMonitors" . | nindent 0 -}}
  {{- include "scroll.common.render.routes" . | nindent 0 -}}
  {{- include "scroll.common.render.configmaps" . | nindent 0 -}}
  {{- include "scroll.common.render.secrets" . | nindent 0 -}}
{{- end -}}
