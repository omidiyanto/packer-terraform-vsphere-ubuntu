# Utilize Packer to Create VM Template on VMware vSphere

## Pre-defined configurations 
- cloud-init username: "<b>ubuntu</b>"
- cloud-init password: "<b>ubuntu</b>"
- default ubuntu version: "jammy / 22.04"

## Pre-requisites  
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
## Step-by-Step Guide 
1. Clone this repository and open the project folder
    ```bash
    git clone https://github.com/omidiyanto/packer-terraform-vsphere-ubuntu.git
    cd packer-terraform-vsphere-ubuntu/"packer - build vm template"
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

7. DONE, here is the result:<br>
    <img src="https://github.com/user-attachments/assets/f24a068a-5573-43c0-bb3f-67ebe6c2ac11"></img>

## What's Next? 
After building the VM Template, you can:
1. **Manually Create VMs**: You can create VMs by simply cloning the VM Template in VMware vSphere.
2. **Automate VM Creation with Terraform**: Use **Terraform** to automatically create and manage VMs from the template as part of an **Infrastructure as Code** (IaC) setup.


## Troubleshooting 
If you encounter this error:
```
could not find a supported CD ISO creation command (the supported commands are: xorriso, mkisofs, hdiutil, oscdimg)
```

Here's how to resolve it:
1. Linux user --> Simply install one of the supported tools:
2. Windows user:
    - Download ADK setup from this link: "https://github.com/omidiyanto/packer-terraform-vsphere-ubuntu/releases/download/adksetup/adksetup.exe"
    - Open the adksetup.exe, unchecked all components except <b>Deployment Tools</b>, which will install <b>oscdimg</b>
    - Add this path to System Environment Variables
      ```
      C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg
      ```