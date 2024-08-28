{{/*
Main entrypoint for the common library chart. It will render all underlying templates based on the provided values.
*/}}
{{- define "scroll.common.loader.all" -}}
  {{- /* Generate chart and dependency values */ -}}
  {{- include "scroll.common.loader.init" . -}}

  {{- /* Generate remaining objects */ -}}
  {{- include "scroll.common.loader.generate" . -}}
{{- end -}}
