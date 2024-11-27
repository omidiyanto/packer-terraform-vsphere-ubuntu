terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = "2.10.0"
    }
  }
}

data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_host" "hosts" {
  name = var.vsphere_host
  datacenter_id	= data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "compute_cluster" {
  name = var.vsphere_compute_cluster
  datacenter_id	= data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name = var.vm_template_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

locals {
  templatevars = {
    for vm_key, vm_value in var.vms : vm_key => {
      name         = vm_value.name
      ssh_public_key = var.ssh_public_key
      ssh_username = var.ssh_username
    }
  }
}

resource "vsphere_virtual_machine" "vm" {
  for_each = var.vms
  datastore_id = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_compute_cluster.compute_cluster.resource_pool_id
  guest_id = var.vm_guest_id

  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  name = each.value.name
  num_cpus = each.value.vm_vcpu
  memory = each.value.vm_memory

  disk {
    label = var.vm_disk_label
    size = each.value.vm_disk_size
    thin_provisioned = var.vm_disk_thin
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }
  extra_config = {
    "guestinfo.metadata" = base64encode(templatefile("${path.module}/templates/metadata.yaml", local.templatevars[each.key]))
    "guestinfo.metadata.encoding" = "base64"
    "guestinfo.userdata" = base64encode(templatefile("${path.module}/templates/userdata.yaml", local.templatevars[each.key]))
    "guestinfo.userdata.encoding" = "base64"
  }
  lifecycle {
    ignore_changes = [
      annotation,
      clone[0].template_uuid,
      clone[0].customize[0].dns_server_list,
      clone[0].customize[0].network_interface[0]
    ]
  }
 }

output "vm_info" {
  value = {
    virtual_machines = [
      for vm in vsphere_virtual_machine.vm : {
        hostname = vm.name
        ip_addr  = vm.guest_ip_addresses[0]
      }
    ]
  }
}


