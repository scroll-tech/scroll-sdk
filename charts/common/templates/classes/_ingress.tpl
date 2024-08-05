{{/*
This template serves as a blueprint for all Ingress objects that are created
within the common library.
*/}}
{{- define "scroll.common.class.ingress" -}}
  {{- $fullName := include "scroll.common.lib.chart.names.fullname" . -}}
  {{- $ingressName := $fullName -}}
  {{- $values := .Values.ingress -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.ingress -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}

  {{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
    {{- $ingressName = printf "%v-%v" $ingressName $values.nameOverride -}}
  {{- end -}}

  {{- $primaryService := get .Values.service (include "scroll.common.lib.service.primary" .) -}}
  {{- $defaultServiceName := $fullName -}}
  {{- if and (hasKey $primaryService "nameOverride") $primaryService.nameOverride -}}
    {{- $defaultServiceName = printf "%v-%v" $defaultServiceName $primaryService.nameOverride -}}
  {{- end -}}
  {{- $defaultServicePort := get $primaryService.ports (include "scroll.common.lib.service.primaryPort" (dict "values" $primaryService)) -}}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ $ingressName }}
  {{- with (merge ($values.labels | default dict) (include "scroll.common.lib.metadata.allLabels" $ | fromYaml)) }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with (merge ($values.annotations | default dict) (include "scroll.common.lib.metadata.globalAnnotations" $ | fromYaml)) }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  {{- if $values.ingressClassName }}
  ingressClassName: {{ $values.ingressClassName }}
  {{- end }}
  {{- if $values.tls }}
  tls:
    {{- range $values.tls }}
    - hosts:
        {{- range .hosts }}
        - {{ tpl . $ | quote }}
        {{- end }}
      {{- $secretName := tpl (default "" .secretName) $ }}
      {{- if $secretName }}
      secretName: {{ $secretName | quote}}
      {{- end }}
    {{- end }}
  {{- end }}
  rules:
  {{- range $values.hosts }}
    - host: {{ tpl .host $ | quote }}
      http:
        paths:
          {{- range .paths }}
          {{- $service := $defaultServiceName -}}
          {{- $port := $defaultServicePort.port -}}
          {{- if .service -}}
            {{- $service = default $service .service.name -}}
            {{- $port = default $port .service.port -}}
          {{- end }}
          - path: {{ tpl .path $ | quote }}
            pathType: {{ default "Prefix" .pathType }}
            backend:
              service:
                name: {{ $service }}
                port:
                  number: {{ $port }}
          {{- end }}
  {{- end }}
{{- end }}
