# How to install GNS3 on Arch Based Linux</br>

**Install the following packages:**</br>
yay -S gns3-server gns3-gui dynamips ubridge qemu docker wireshark-qt vpcs libvirt-git gperftools tigervnc

**Add your username to the following groups:**</br>
sudo usermod -aG docker username</br>
sudo usermod -aG wireshark username</br>
sudo usermod -aG kvm username</br>
sudo usermod -aG libvirt username</br>

**Enable systemd services:**</br>
sudo systemctl enable --now docker</br>
sudo systemctl enable --now libvirtd</br>

**Libvirt error?**</br>
sudo pacman -S libvirt --noconfirm</br>
wget https://raw.githubusercontent.com/libvirt/libvirt/master/src/network/default.xml.in</br>
sudo virsh net-define /tmp/default.xml.in</br>
sudo virsh net-autostart default</br>
sudo virsh net-start default</br>
