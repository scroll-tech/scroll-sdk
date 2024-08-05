{{- define "scroll.common.loader.init" -}}
  {{- /* Merge the local chart values and the common chart defaults */ -}}
  {{- include "scroll.common.values.init" . }}
{{- end -}}
