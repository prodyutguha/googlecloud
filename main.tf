
# -------------------------
# Create Data Disk
# -------------------------
resource "google_compute_disk" "data_disk" {
  name  = "windows-data-disk"
  type  = "pd-ssd"   # or pd-balanced / pd-standard
  zone  = "us-central1-a"
  size  = 50        # Size in GB
}

# -------------------------
# Create Windows VM
# -------------------------
resource "google_compute_instance" "windows_vm" {
  name         = "windows-server"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "projects/windows-cloud/global/images/family/windows-2022"
      size  = 50
      type  = "pd-balanced"
    }
  }

  # Attach the extra data disk
  attached_disk {
    source = google_compute_disk.data_disk.id
  }

  network_interface {
    network = "default"
    access_config {} # Gives external IP for RDP
  }

  metadata = {
    windows-startup-script-cmd = "winrm quickconfig -q"
  }

  service_account {
    email  = "terraform@maximal-furnace-458310-u2.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}