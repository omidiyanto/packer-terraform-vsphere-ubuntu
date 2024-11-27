# Automatically Build Ubuntu VM on VMware vSphere using Packer and Terraform
<div align="center">
    <img src="https://img.shields.io/badge/packer-blue?style=for-the-badge&logo=packer&logoColor=white">
    <img src="https://img.shields.io/badge/terraform-purple?style=for-the-badge&logo=terraform&logoColor=white">
    <img src="https://img.shields.io/badge/vmware-gray?style=for-the-badge&logo=vmware&logoColor=white">
    <img src="https://img.shields.io/badge/ubuntu-red?style=for-the-badge&logo=ubuntu&logoColor=white">
</div>

## Project Overview 📦
<img src="https://github.com/user-attachments/assets/f1491817-3d6f-4c22-99db-03994f91fca1"></img><br>
Creating Virtual Machines (VMs) is a common task in IT environments, but installing and configuring them one by one can be tedious and time-consuming, right? 😩 Imagine having to install a fresh OS, set up cloud-init, configure user permissions, and tweak network settings over and over again. It's not just inefficient, it’s also prone to human error. This is where **Packer** and **Terraform** come to the rescue! 🛠️

In this project, we're automating the provisioning of multiples **Ubuntu VM** using **HashiCorp Packer** and **HashiCorp Terraform**. By leveraging Packer, we can define an **immutable VM Template** that can be deployed with **Terraform** quickly, consistently, and reliably. This VM template is perfect for spinning up new VMs on **VMware vSphere**, saving time and ensuring that every VM is identical from the start! 🔄💻

Once this VM template is built, you'll be able to:
- **Easily replicate the VM configuration** whenever needed.
- **Automate the VM creation process** using **Terraform**.
- **Ensure consistency** in VM deployment across your environments.

<br>
Let’s dive into the details of how to get started with this awesome automation tool! 🎉 <br>
<a href="https://github.com/omidiyanto/packer-terraform-vsphere-ubuntu/tree/master/packer%20-%20build%20vm%20template">1. Create VM Template with Packer</a><br>
<a href="https://github.com/omidiyanto/packer-terraform-vsphere-ubuntu/tree/master/terraform%20-%20provisioning%20vm">2. Provision VM automatically with Terraform</a><br>

## Conclusion 🎯
By following this guide, you'll be able to efficiently automate the creation of Ubuntu VM on VMware vSphere using Packer and Terraform. This not only saves you time but ensures that every VM is deployed with the same configuration, making management much easier. Whether you need to spin up one VM or thousands, this template makes it a breeze! 🌟

## Happy automating! 😄