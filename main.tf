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

// KEY GENERATION:
resource "tls_private_key" "ssh" {
  algorithm   = "RSA"

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

  metadata ={
   //ssh-keys = "${var.user}:${file("${var.ssh_public_key}")}"
   sshKeys = "${var.user}:${tls_private_key.ssh.public_key_openssh}"
}
/*
provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "${var.user}"
      timeout     = "500s"
      private_key = "${file("${var.ssh_private_key}")}"
      host = google_compute_instance.vm1.network_interface[0].access_config[0].nat_ip
    }

    inline = [
      "touch /tmp/temp.txt",
    ]
    
  }
*/

  metadata_startup_script = "echo hi > /test.txt"



  
}


resource "local_file" "local_ssh_key" {
  content = tls_private_key.ssh.private_key_pem
  filename = "${path.root}/ssh-keys/ssh_key"
}

resource "local_file" "local_ssh_key_pub"{
   content = tls_private_key.ssh.public_key_openssh
  filename = "${path.root}/ssh-keys/ssh_key.pub"
}



