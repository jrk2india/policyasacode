terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.45"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance" "demo_vm" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.boot_image
      size  = var.boot_disk_size
      type  = "pd-balanced"
    }
  }

  network_interface {
    network = "default"
  }

  labels = {
    environment = var.environment
    managed_by  = "terraform"
    purpose     = "atlantis-demo"
    user        = "Kyndryl"
  }
}