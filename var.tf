variable "project_id" {
    default = "qwiklabs-gcp-04-ab621185894d"
}

variable "region" {
    default = "us-central1"
  
}

variable "networkname"{
    default = "mynetwork"
}

variable "firewallname"{
    default = "myfirewall"
}

variable "subnetname" {
   default = "mysubnet" 
}


variable "ip_cidr_range" {
    default = "10.2.0.0/16"
}

variable range_name {
    default ="tf-test-secondary-range-update1"
}

variable "ip_cidr_range1"{
    default = "192.168.10.0/24"

}

variable "vmname"{
    default = "myvm"
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
default = "qwiklabs-gcp-04-ab621185894d"
}
//PRIVATE KEY
variable "ssh_private_key" {
default ="~/.ssh/id_rsa"
}
//PUBLIC KEY




variable "ssh_public_key" {
default ="~/.ssh/id_rsa.pub"
}







