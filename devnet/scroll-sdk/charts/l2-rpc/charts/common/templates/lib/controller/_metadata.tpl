{{- define "scroll.common.lib.controller.metadata.labels" -}}
  {{-
    $labels := (
      merge
        (.Values.controller.labels | default dict)
        (include "scroll.common.lib.metadata.allLabels" $ | fromYaml)
    )
  -}}
  {{- with $labels -}}
    {{- toYaml . -}}
  {{- end -}}
{{- end -}}

{{- define "scroll.common.lib.controller.metadata.annotations" -}}
  {{-
    $annotations := (
      merge
        (.Values.controller.annotations | default dict)
        (include "scroll.common.lib.metadata.globalAnnotations" $ | fromYaml)
    )
  -}}
  {{- with $annotations -}}
    {{- toYaml . -}}
  {{- end -}}
{{- end -}}
