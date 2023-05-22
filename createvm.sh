#!/bin/bash
export ISO="xubuntu-22.04.2-desktop-amd64.iso"
export VM="Inception-Xubuntu"

VBoxManage createvm --name ${VM} --ostype Ubuntu_64 --register

VBoxManage modifyvm ${VM} --cpus 6 --memory 8192 --vram 128

VBoxManage modifyvm ${VM} --nic1 nat --nictype1 82540EM --cableconnected1 on

VBoxManage createhd --filename ${VM}.vdi --size 500 --variant Fixed

VBoxManage storagectl ${VM} --name "SATA Controller" --add sata --controller IntelAHCI

VBoxManage storageattach ${VM} --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium ${VM}.vdi

VBoxManage storagectl ${VM} --name "IDE Controller" --add ide

VBoxManage storageattach ${VM} --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium ${ISO}

VBoxManage modifyvm ${VM} --graphicscontroller vmsvga

VBoxManage modifyvm ${VM} --boot1 disk --boot2 dvd --boot3 none --boot4 none

VBoxManage startvm Inception-Xubuntu
