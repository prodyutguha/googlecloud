terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.41.0"
    }
  }
}

provider "google" {
  credentials = file("gcp-key.json")
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

# Example: Create a VM
resource "google_compute_instance" "vm" {
  name         = "terraform-vm"
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    ssh-keys = "terraform:${file("~/.ssh/id_rsa.pub")}"
  }
}
