provider "google" {
    project = "hardy-ally-478805-p4"
    region = "us-central1"
  
}


resource "google_compute_instance" "tf_vm1" {
    name = "harness-vm"
    zone = "us-central1-c"
    machine_type = "e2-medium"
    boot_disk {
      initialize_params {
        image = "ubuntu-os-cloud/ubuntu-2204-lts"
      }
    }
    network_interface {
        network = google_compute_network.tf_net1.id
        subnetwork = google_compute_subnetwork.tf-subnet2.id
      access_config {
        
      }
    }
  
}

resource "google_compute_network" "tf_net1" {
    name = "harness-net"
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "tf-subnet1" {
    name = "harness-subnet"
    network = google_compute_network.tf_net1.id
    region = "us-central1"
    ip_cidr_range = "10.0.0.0/24"
}

resource "google_compute_firewall" "tf_fir" {
    name = "allow-ssh-http"
    direction = "INGRESS"
    network = google_compute_network.tf_net1.id
    source_ranges = ["0.0.0.0/0"]
    allow {
      protocol = "tcp"  
      ports = ["22","80"]
    }
}
