# _helpers.tpl executed
{{/*
Expand the name of the chart.
*/}}
{{- define "mariadb.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mariadb.fullname" -}}
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
{{- define "mariadb.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mariadb.labels" -}}
helm.sh/chart: {{ include "mariadb.chart" . }}
{{ include "mariadb.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mariadb.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mariadb.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mariadb.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mariadb.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Fetch or generate the root password
*/}}
{{- define "mariadb.rootPassword" }}
{{- if .Values.mysqld.rootPassword }}
    {{- .Values.mysqld.rootPassword }}
{{- else }}
    {{- $secretDict := (lookup "v1" "Secret" .Release.Namespace (include "mariadb.fullname" .)) | default dict }}
    {{- $secretPass := get (get $secretDict "data" | default dict) "mariadb-root-password" | b64dec }}
    {{- $secretPass | default (randAlphaNum 32) }}
{{- end }}
{{- end }}

{{/*
Fetch or generate the connection admin password
*/}}
{{- define "mariadb.connection-admin-password" }}
{{- $secretDict := (lookup "v1" "Secret" .Release.Namespace (include "mariadb.fullname" .)) | default dict }}
{{- $secretPass := get (get $secretDict "data" | default dict) "mariadb-connection-admin-password" | b64dec }}
{{- $secretPass | default (randAlphaNum 32) }}
{{- end }}