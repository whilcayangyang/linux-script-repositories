# How to install GNS3 on Arch Based Linux</br>

**Install the following packages:**</br>
yay -S gns3-server gns3-gui dynamips ubridge qemu docker wireshark-qt vpcs libvirt-git --noconfirm

**Add your username to the following groups:**</br>
sudo usermod -aG docker username
sudo usermod -aG wireshark username
sudo usermod -aG kvm username
sudo usermod -aG libvirt username

**Enable systemd services:**</br>
sudo systemctl enable --now docker
sudo systemctl enable --now libvirtd
sudo systemctl enable --now gns3-server@username
