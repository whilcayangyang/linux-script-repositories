# GNS3 Installation Guide for Arch-Based Linux

Instructions for installing GNS3 and dependencies on Arch-based distributions.

## Table of Contents

- [Install Required Packages](#install-required-packages)
- [Add User to Groups](#add-user-to-groups)
- [Enable Systemd Services](#enable-systemd-services)

---

## Install Required Packages

```bash
yay -S gns3-server gns3-gui dynamips ubridge qemu docker wireshark-qt vpcs libvirt gperftools tigervnc
```

## Add User to Groups

Replace `username` with your actual username.

```bash
sudo usermod -aG docker,wireshark,kvm,libvirt username
```

## Enable Systemd Services

```bash
sudo systemctl enable --now docker
sudo systemctl enable --now libvirtd
sudo virsh net-autostart default
```
