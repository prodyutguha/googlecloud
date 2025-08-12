terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  credentials = file("gcp-key.json")
  project     = var.project_id
  region      = "us-central1"
  zone        = "us-central1-a"
}

variable "project_id" {}
variable "region" {}
variable "zone" {}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "default" {
  name         = "terraform-vm"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name

    access_config {}
  }
}
