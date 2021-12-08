{{/*
Deployment name
*/}}
{{- define "quarkus-microservice.name" -}}
{{-   if .Values.nameOverride -}}
{{-     .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{-   else -}}
{{-     .Release.Name | trunc 63 | trimSuffix "-" -}}
{{-   end -}}
{{- end -}}

{{/*
Deployment instance name
*/}}
{{- define "quarkus-microservice.instance" -}}
{{-   if .Values.nameOverride -}}
{{-     .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{-   else -}}
{{-     printf "%s-%s" .Release.Name .Values.instance | trunc 63 | trimSuffix "-" -}}
{{-   end -}}
{{- end -}}

{{/*
Create a fully qualified host name.
*/}}
{{- define "quarkus-microservice.route-host" -}}
{{-   if .Values.hostnameOverride }}
{{-     .Values.hostnameOverride | trunc 63 | trimSuffix "-" }}
{{-   else }}
{{-     printf "%s-%s.apps.%s" .Release.Name .Values.instance .Values.clusterIngressDomain }}
{{-   end }}
{{- end }}

{{/*
Define a container image reference
*/}}
{{- define "quarkus-microservice.image" -}}
{{-   .Values.image | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "quarkus-microservice.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "quarkus-microservice.labels" -}}
helm.sh/chart: {{ include "quarkus-microservice.chart" . }}
{{ include "quarkus-microservice.selectorLabels" . }}
{{- if .Values.mvnVersion }}
app.kubernetes.io/version: {{ .Values.mvnVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "quarkus-microservice.selectorLabels" -}}
app.kubernetes.io/name: {{ include "quarkus-microservice.name" . }}
app.kubernetes.io/instance: {{ .Values.instance }}
{{- end }}
