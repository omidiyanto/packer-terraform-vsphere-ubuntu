#!/bin/bash
yq --help &>/dev/null
if [[ $? -eq 0 ]];then
    echo "Checking dependencies ..... PASS"
else
    echo "Installing Dependencies"
    sudo add-apt-repository ppa:rmescandon/yq &>/dev/null
    sudo apt update &>/dev/null
    sudo apt install yq -y &>/dev/null
    echo "DONE"
fi
echo ""    
read -p "Enter Cloud-init user: " cloudinit-username
read -sp "Enter Cloud-init password: " cloudinit-password
read -p "Enter path of SSH-pubkey: " ssh-pubkey

