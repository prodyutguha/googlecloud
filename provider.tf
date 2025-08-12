terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "google" {
  region      = var.region
  zone        = var.zone
  credentials = file("${path.module}/gcp-key.json")
  project     = jsondecode(file("${path.module}/gcp-key.json")).project_id
}