{{/*
Expand the name of the chart.
*/}}
{{- define "soft-serve.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" | lower }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "soft-serve.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" | lower }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride | lower }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" | lower }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" | lower }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "soft-serve.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "soft-serve.labels" -}}
helm.sh/chart: {{ include "soft-serve.chart" . }}
{{ include "soft-serve.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "soft-serve.selectorLabels" -}}
app.kubernetes.io/name: {{ include "soft-serve.name" . | lower }}
app.kubernetes.io/instance: {{ .Release.Name | lower }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "soft-serve.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "soft-serve.fullname" .) .Values.serviceAccount.name | lower }}
{{- else }}
{{- default "default" .Values.serviceAccount.name | lower }}
{{- end }}
{{- end }}
