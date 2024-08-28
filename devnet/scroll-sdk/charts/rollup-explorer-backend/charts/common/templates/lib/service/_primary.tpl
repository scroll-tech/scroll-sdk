{{/*
Return the primary service object
*/}}
{{- define "scroll.common.lib.service.primary" -}}
  {{- $enabledServices := (include "scroll.common.lib.service.enabledServices" $ | fromYaml ) }}

  {{- $result := "" -}}
  {{- range $name, $service := $enabledServices -}}
    {{- if and (hasKey $service "primary") $service.primary -}}
      {{- $result = $name -}}
    {{- end -}}
  {{- end -}}

  {{- if not $result -}}
    {{- $result = keys $enabledServices | first -}}
  {{- end -}}
  {{- $result -}}
{{- end -}}
