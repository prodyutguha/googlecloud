variable "project_id" {
  description = "GCP project ID"
  type        = string
  default     = jsondecode(file("${path.module}/gcp-key.json")).project_id
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "us-central1-a"
}
