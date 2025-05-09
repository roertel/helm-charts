{{/*
Expand the name of the chart.
*/}}
{{- define "mariadb-manifests.name" -}}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mariadb-manifests.fullname" -}}
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
Create chart name and version as used by the chart label.
*/}}
{{- define "mariadb-manifests.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mariadb-manifests.labels" -}}
helm.sh/chart: {{ include "mariadb-manifests.chart" . }}
{{ include "mariadb-manifests.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mariadb-manifests.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mariadb-manifests.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common Metadata
Pass in the specific Manifest values (ex: .Values.mariadb)
*/}}
{{- define "mariadb-manifests.metadata" -}}
{{- with pick . "name" "annotations" "labels" }}
{{- toYaml . }}
{{- end }}
{{- end }}

{{/*
Common Spec
Pass in the specific Manifest values (ex: .Values.mariadb)
*/}}
{{- define "mariadb-manifests.spec" -}}
{{- omit . "name" "annotations" "labels" "enabled" | toYaml }}
{{- end }}

{{/*
MariaDbSpec
*/}}
{{- define "mariadb-manifests.mariadbref" }}
{{/* Derive the MariaDbRef from the first enabled MariaDB */}}
{{- $mariadb := "" }}
{{- $default := .Values.common.name | default (include "mariadb-manifests.name" .) }}
{{- range .Values.mariadb }}
{{- if .enabled }}
{{- $mariadb = .name | default $default }}
{{- break }}
{{- end }}
{{- end }}

{{/* If no MariaDB is enabled, return an empty string */}}
{{- if eq $mariadb "" }}
{{- else }}
name: {{ $mariadb }}
{{- end }}
{{- end }}
