provider "google" {
  #credentials = file("file name")
  #project     = "project name"
  region      = "us-central1"
  zone        = "us-central1-c"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
#       image = "debian-cloud/debian-9"
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
#     network = google_compute_network.vpc_network.self_link
     network = google_compute_network.default.name
#     network = "default"
    access_config {
    }
  }
}
resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = google_compute_network.default.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "8080", "1000-2000"]
  }

#   source_tags = ["web"]
}

resource "google_compute_network" "default" {
  name = "test-network"
}

# resource "google_compute_network" "vpc_network" {
#   name                    = "terraform-network"
#   auto_create_subnetworks = "true"
# }
