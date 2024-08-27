provider "google" {
    project = var.project_id
    region = var.region
}


//NETWORK

resource "google_compute_network" "vpc_network" {
 
  name                    =  var.networkname
  auto_create_subnetworks = false
  
}

//SUBNETWORK:
resource "google_compute_subnetwork" "subnetwork" {
  name          = var.subnetname
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
  network       = google_compute_network.vpc_network.name
  secondary_ip_range {
    range_name    = var.range_name
    ip_cidr_range=  var.ip_cidr_range1
  }
}


//FIREWALL
resource "google_compute_firewall" "gh-9564-firewall-externalssh" {
  name    = var.firewallname
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["externalssh"]
}

//VM 

resource "google_compute_address" "static" {
  name = "ipv4-address"
}
//VM

resource "google_compute_instance" "vm1" {
  name         = var.vmname
  machine_type = var.machine_type
  zone         = var.zone
  tags = ["externalssh"]

  boot_disk {
    initialize_params {
      image = var.image
      labels = {
        my_label = "value"
      }
    }
  }
 
  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.subnetwork.name
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  metadata = {
    ssh-keys = "student-04-b9d24e6ca1cb@qwiklabs.net:${file("~/.ssh/id_rsa.pub")}"
  }
provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      timeout     = "500s"
      private_key = "${file("~/.ssh/id_rsa")}"
      host = google_compute_instance.vm1.network_interface[0].access_config[0].nat_ip
    }

    inline = [
      "touch /tmp/temp.txt",
    ]
  }


  metadata_startup_script = "echo hi > /test.txt"



  
}




