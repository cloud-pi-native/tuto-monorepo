{{/*
Expand the name of the chart.
*/}}
{{- define "template.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "template.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Create the name of the service account to use
*/}}
{{- define "template.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "template.name" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "template.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}


{{/*
Common labels
*/}}
{{- define "template.labels" -}}
helm.sh/chart: {{ include "template.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{/*
Selector labels
*/}}
{{- define "template.client.selectorLabels" -}}
app.kubernetes.io/name: {{ include "template.name" . }}-client
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "template.server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "template.name" . }}-server
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Create container environment variables from configmap
*/}}
{{- define "template.env" -}}
{{ range $key, $val := .env }}
{{ $key }}: {{ $val | quote }}
{{- end }}
{{- end }}


{{/*
Create container environment variables from secret
*/}}
{{- define "template.secret" -}}
{{ range $key, $val := .secrets }}
{{ $key }}: {{ $val | b64enc | quote }}
{{- end }}
{{- end }}
