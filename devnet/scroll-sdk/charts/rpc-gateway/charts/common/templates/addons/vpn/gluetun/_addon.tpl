{{/*
Template to render gluetun addon. It will add the container to the list of additionalContainers.
*/}}
*/}}
{{- define "scroll.common.addon.gluetun" -}}
  {{/* Append the gluetun container to the sidecars */}}
  {{- $container := fromYaml (include "scroll.common.addon.gluetun.container" .) -}}
  {{- if $container -}}
    {{- $_ := set .Values.sidecars "addon-gluetun" $container -}}
  {{- end -}}
{{- end -}}
