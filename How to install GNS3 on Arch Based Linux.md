# How to Install GNS3 on Arch-Based Linux

## 1. Install Required Packages

```bash
yay -S gns3-server gns3-gui dynamips ubridge qemu docker wireshark-qt vpcs libvirt gperftools tigervnc
```

## 2. Add User to Required Groups

Replace `username` with your actual username.

```bash
sudo usermod -aG docker,wireshark,kvm,libvirt username
```

## 3. Enable Systemd Services

```bash
sudo systemctl enable --now docker
sudo systemctl enable --now libvirtd
sudo virsh net-autostart default
```
