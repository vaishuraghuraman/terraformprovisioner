variable "project_id" {
    default = "qwiklabs-gcp-03-31256b2fdd24"
}

variable "region" {
    default = "us-central1"
  
}

variable "networkname"{
    default = "mynetwork"
}

variable "firewallname"{
    default = "managementnet-allow-http-ssh-rdp-icmp"
}

variable "subnetname" {
   default = "managementsubnet-us" 
}


variable "ip_cidr_range" {
    default = "10.130.0.0/20"
}

variable range_name {
    default ="tf-test-secondary-range-update1"
}

variable "ip_cidr_range1"{
    default = "192.168.10.0/24"

}

variable "vmname"{
    default = "privatenet-us-vm"
}

variable "machine_type" {
    default = "n2-standard-2"
}

variable "zone" {
    default = "us-central1-a"
}

variable "image" {
    default = "debian-cloud/debian-11"
}

variable "user" {
default = "student-03-7d21e9b9a621@qwiklabs.net"
}
//PRIVATE KEY
/*variable "ssh_private_key" {
 description = "Path to the SSH public key file"
  type        = string

}
*/
//PUBLIC KEY




variable "ssh_public_key" {
  description = "Path to the SSH public key file"
  type        = string
}







