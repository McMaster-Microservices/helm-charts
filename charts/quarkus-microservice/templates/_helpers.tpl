{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "quarkus-microservice.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create object A name.
*/}}
{{- define "quarkus-microservice.baseline-name" -}}
{{- printf "%s-%s" .Release.Name "baseline" }}
{{- end }}

{{/*
Create object B name.
*/}}
{{- define "quarkus-microservice.canary-name" -}}
{{- printf "%s-%s" .Release.Name "canary" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "quarkus-microservice.labels" -}}
helm.sh/chart: {{ include "quarkus-microservice.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Namespace administrators
*/}}
{{- define "quarkus-microservice.admins" -}}
{{- range $a := .Values.admins }}
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: {{ $a }}
{{- end }}
{{- end }}

{{/*
Readiness probes
*/}}
{{- define "quarkus-microservice.readiness-probe" -}}
httpGet:
  path: /q/health/ready
  port: 8080
  scheme: HTTP
timeoutSeconds: 1
periodSeconds: 10
successThreshold: 1
failureThreshold: 3
{{- end }}

{{/*
Liveness probes
*/}}
{{- define "quarkus-microservice.liveness-probe" -}}
httpGet:
  path: /q/health/live
  port: 8080
  scheme: HTTP
timeoutSeconds: 1
periodSeconds: 10
successThreshold: 1
failureThreshold: 18
{{- end }}

{{/*
Default host name
*/}}
{{- define "quarkus-microservice.host-name" -}}
{{- printf "%s.apps.ocpprd01.mcmaster.ca" .Release.Name }}
{{- end }}
