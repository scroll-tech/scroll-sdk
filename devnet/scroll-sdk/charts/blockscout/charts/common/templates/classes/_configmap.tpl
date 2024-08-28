{{/*
This template serves as a blueprint for all configMap objects that are created
within the common library.
*/}}
{{- define "scroll.common.class.configmap" -}}
  {{- $fullName := include "scroll.common.lib.chart.names.fullname" . -}}
  {{- $configMapName := $fullName -}}
  {{- $values := .Values.configmap -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.configmap -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}

  {{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
    {{- $configMapName = printf "%v-%v" $configMapName $values.nameOverride -}}
  {{- end }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configMapName }}
  {{- with (merge ($values.labels | default dict) (include "scroll.common.lib.metadata.allLabels" $ | fromYaml)) }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with (merge ($values.annotations | default dict) (include "scroll.common.lib.metadata.globalAnnotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
data:
{{- with $values.data }}
  {{- tpl (toYaml .) $ | nindent 2 }}
{{- end }}
{{- end -}}
