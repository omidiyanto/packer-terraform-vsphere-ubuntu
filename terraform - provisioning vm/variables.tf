variable "vsphere_user" {
  type = string
}

variable "vsphere_password" {
  type = string
  sensitive = true
}

variable "vsphere_server" {
  type = string
}

variable "vsphere_datacenter" {
  type = string
}

variable "vsphere_compute_cluster" {
  type = string
}

variable "vsphere_network" {
  type = string
}

variable "vsphere_datastore" {
  type = string
}

variable "vsphere_host" {
  type = string
}

variable "vm_template_name" {
  type = string
}

variable "vm_guest_id" {
  type = string
}

variable "vm_firmware" {
  type = string
  default = "efi"
}

variable "vm_disk_label" {
  type = string
}

variable "vm_disk_thin" {
  type = bool
}

variable "ssh_username" {
  type = string
}
variable "ssh_public_key" {
  type = string
}

variable "vms" {
  type = map(any)
  description = "List of virtual machines to be deployed"
}

