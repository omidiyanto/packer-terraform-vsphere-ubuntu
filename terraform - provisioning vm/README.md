# Automatically Provisioning Multiple VMs with cloud-init in VMware vSphere using Terraform

## Step-by-Step Guide 
1. Clone this repository and open the project folder
    ```bash
    git clone https://github.com/omidiyanto/packer-terraform-vsphere-ubuntu.git
    cd packer-terraform-vsphere-ubuntu/"terraform - provisioning vm"
    ```
2. Fill required value such as credentials, number of VMs, VM configurations, and VM Specs on terraform.tfvars following provided example file
    ```bash
    mv terraform.tfvars.example terraform.tfvars
    vim terraform.tfvars
    ```
3. Initialize Terraform provider
    ```bash
    terraform init
    ```
4. Make plan before start provisioning
    ```bash
    terraform plan
    ```
5. Start provisioning the defined VMs on VMware vSphere
    ```bash
    terraform apply
    ```
6. DONE, here's the result example
    <img src="https://github.com/user-attachments/assets/a16e705c-b99b-48da-a724-8892a334fae1"></img>
    <img src="https://github.com/user-attachments/assets/7cffbbc8-7cbe-4bfb-aef6-0628d554c6ec"></img>

## What's Next? 
With this IaC tools, next we can automatically provision kubernetes cluster, jenkins server, monitoring server with Prometheu-Grafana, etc. We can do this by utilizing Ansible as Configuration Management tools to automate the process.

