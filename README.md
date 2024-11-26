# Automatically Build Ubuntu VM Template on VMware vSphere using Packer 🚀
<div align="center">
    <img src="https://img.shields.io/badge/packer-blue?style=for-the-badge&logo=packer&logoColor=white">
    <img src="https://img.shields.io/badge/vmware-green?style=for-the-badge&logo=vmware&logoColor=black">
    <img src="https://img.shields.io/badge/ubuntu-red?style=for-the-badge&logo=ubuntu&logoColor=white">
</div>

## Project Overview 📦

Creating Virtual Machines (VMs) is a common task in IT environments, but installing and configuring them one by one can be tedious and time-consuming, right? 😩 Imagine having to install a fresh OS, set up cloud-init, configure user permissions, and tweak network settings over and over again. It's not just inefficient, it’s also prone to human error. This is where **Packer** and **VMware vSphere** come to the rescue! 🛠️

In this project, we're automating the creation of an **Ubuntu VM Template** using **HashiCorp Packer**. By leveraging Packer, we can define an **immutable VM Template** that can be deployed quickly, consistently, and reliably. This VM template is perfect for spinning up new VMs on VMware vSphere, saving time and ensuring that every VM is identical from the start! 🔄💻

Once this VM template is built, you'll be able to:
- **Easily replicate the VM configuration** whenever needed.
- **Automate the VM creation process** using **Terraform**.
- **Ensure consistency** in VM deployment across your environments.

Let’s dive into the details of how to get started with this awesome automation tool! 🎉

## Pre-defined configurations 📂
- cloud-init username: "<b>ubuntu</b>"
- cloud-init password: "<b>ubuntu</b>"
- default ubuntu version: "jammy / 22.04"

## Pre-requisites  🛠️
- Prepare Ubuntu ISO image, you can download/choose from this site:
    ```
    https://releases.ubuntu.com/
    ```
- (<b>Recommended for faster build</b>) download the ISO first and saved it on your datastore. Lastly define the <b>ISO OBJECTS</b> and <b>ISO PATH</b> on file <b>variables.auto.pkrvars.hcl</b>. You can choose freely ubuntu version you likely the most, just customize the configurations.
    ```
    ##################################################################################
    # ISO OBJECTS
    ##################################################################################

    iso_file                    = "ubuntu-22.04.5-live-server-amd64.iso"
    iso_checksum                = "10f19c5b2b8d6db711582e0e27f5116296c34fe4b313ba45f9b201a5007056cb"
    iso_checksum_type           = "sha256"
    iso_url                     = "https://releases.ubuntu.com/jammy/ubuntu-22.04.5-live-server-amd64.iso"

    ##################################################################################
    # ISO PATH
    ##################################################################################

    iso_path                    = "ISO"
    ```

    For example, you can store the downloaded ISO on your datastore like this:
    <img src="https://github.com/user-attachments/assets/1ea972e6-5050-4e2c-aba2-2d217fee9437"></img>
    
    From this example:
    - <b>vcenter_datastore</b> is <b>Local-1</b> 
    - <b>iso_path</b> is <b>ISO</b>

- If you want directly download the ISO without storing it on your datastore, you only have to change uncomment the <b>iso_url</b> on <b>ubuntu.pkr.hcl</b> file. Also fill the iso_url on <b>variables.auto.pkrvars.hcl</b> file. For example it should be like this: <br>
    on ubuntu.pkr.hcl:
    ```
    iso_url = var.iso_url
    //iso_paths = ["[${ var.vcenter_datastore }] /${ var.iso_path }/${ var.iso_file }"]
    ```
    on variables.auto.pkrvars.hcl:
    ```
    iso_url                     = "https://releases.ubuntu.com/jammy/ubuntu-22.04.5-live-server-amd64.iso"
    ```
## Step-by-Step Guide 📝
1. Clone this repository and open the project folder
    ```bash
    git clone https://github.com/omidiyanto/packer-vsphere-ubuntu.git
    cd packer-vsphere-ubuntu
    ```
2. Fill required variables.auto.pkrvars.hcl value following provided example
    ```bash
    mv variables.auto.pkrvars.hcl.example variables.auto.pkrvars.hcl
    vim variables.auto.pkrvars.hcl
    ```
3. Configure cloud-init configurations if you want it
    ```bash
    vim http/user-data
    ```

    The given hashed password for cloud-init user can be get from this steps:
    ```bash
    apt install whois -y
    mkpasswd -m sha-512 --rounds=4096
    ```
4. Configure the packer file if you want to, just configure <b>ubuntu.pkr.hcl</b> file
5. Initialize packer 
    ```bash
    packer init .
    ```
6. Start build ISO VM Template using Packer
    ```bash
    packer build .
    ```

    or

    ```bash
    packer build -force -var-file variables.auto.pkrvars.hcl ubuntu.pkr.hcl
    ```

7. DONE, here is the result:
    <img src="https://github.com/user-attachments/assets/f24a068a-5573-43c0-bb3f-67ebe6c2ac11"></img>

## What's Next? 🚀
After building the VM Template, you can:
1. **Manually Create VMs**: You can create VMs by simply cloning the VM Template in VMware vSphere.
2. **Automate VM Creation with Terraform**: Use **Terraform** to automatically create and manage VMs from the template as part of an **Infrastructure as Code** (IaC) setup.


## Troubleshooting ⚠️
If you encounter this error:
```
could not find a supported CD ISO creation command (the supported commands are: xorriso, mkisofs, hdiutil, oscdimg)
```

Here's how to resolve it:
1. Linux user --> Simply install one of the supported tools:
2. Windows user:
    - Download ADK setup from this link: "https://github.com/omidiyanto/packer-vsphere-ubuntu/releases/download/adksetup/adksetup.exe"
    - Open the adksetup.exe, unchecked all components except <b>Deployment Tools</b>, which will install <b>oscdimg</b>
    - Add this path to System Environment Variables
      ```
      C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg
      ```

## Conclusion 🎯
By following this guide, you'll be able to efficiently automate the creation of Ubuntu VM Templates on VMware vSphere using Packer. This not only saves you time but ensures that every VM is deployed with the same configuration, making management much easier. Whether you need to spin up one VM or thousands, this template makes it a breeze! 🌟

Happy automating! 😄