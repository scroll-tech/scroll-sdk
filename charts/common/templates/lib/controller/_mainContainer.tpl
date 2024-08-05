{{- /* The main container included in the controller */ -}}
{{- define "scroll.common.lib.controller.mainContainer" -}}
- name: {{ include "scroll.common.lib.chart.names.fullname" . }}
  image: {{ include "scroll.common.lib.container.image" . }}
  imagePullPolicy: {{ .Values.image.pullPolicy }}
  {{- with .Values.command }}
  command:
    {{- if kindIs "string" . }}
    - {{ . | quote }}
    {{- else }}
      {{ toYaml . | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- with .Values.args }}
  args:
    {{- if kindIs "string" . }}
    - {{ . | quote }}
    {{- else }}
    {{ toYaml . | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- with .Values.securityContext }}
  securityContext:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.lifecycle }}
  lifecycle:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.termination.messagePath }}
  terminationMessagePath: {{ . }}
  {{- end }}
  {{- with .Values.termination.messagePolicy }}
  terminationMessagePolicy: {{ . }}
  {{- end }}

  {{- with .Values.env }}
  env:
    {{- get (fromYaml (include "scroll.common.lib.container.envVars" $)) "env" | toYaml | nindent 4 -}}
  {{- end }}
  {{- with .Values.envFrom }}
  envFrom:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with (include "scroll.common.lib.container.ports" . | trim) }}
  ports:
    {{- nindent 4 . }}
  {{- end }}
  {{- with (include "scroll.common.lib.container.volumeMounts" . | trim) }}
  volumeMounts:
    {{- nindent 4 . }}
  {{- end }}
  {{- include "scroll.common.lib.container.probes" . | trim | nindent 2 }}
  {{- with .Values.resources }}
  resources:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end -}}
