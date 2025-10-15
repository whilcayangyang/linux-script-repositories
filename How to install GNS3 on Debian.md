# GNS3 Installation Guide for Debian

Step-by-step instructions for installing GNS3 and dependencies on Debian.

## Table of Contents

- [Install Docker CE](#install-docker-ce)
- [Install GNS3-GUI Dependencies](#install-gns3-gui-dependencies)
- [Install GNS3-Server Dependencies](#install-gns3-server-dependencies)
- [Install Ubridge](#install-ubridge)
- [Install GNS3 via pipx](#install-gns3-via-pipx)
- [Create GNS3 App Shortcut](#create-gns3-app-shortcut)
- [Add User to Groups](#add-user-to-groups)

---

## Install Docker CE

```bash
sudo apt install -y ca-certificates curl git
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## Install GNS3-GUI Dependencies

```bash
sudo apt install -y python3 python3-pip pipx python3-pyqt5 python3-pyqt5.qtwebsockets python3-pyqt5.qtsvg software-properties-common ca-certificates curl gnupg2 wireshark tigervnc-viewer
```

## Install GNS3-Server Dependencies

```bash
sudo apt install -y qemu-kvm qemu-utils libvirt-clients libvirt-daemon-system virtinst dynamips busybox-static
sudo systemctl enable --now libvirtd
sudo virsh net-autostart default
```

## Install Ubridge

```bash
sudo apt install -y libpcap-dev
git clone https://github.com/GNS3/ubridge.git /tmp/ubridge
cd /tmp/ubridge
make
sudo make install
```

## Install GNS3 via pipx

```bash
pipx ensurepath
pipx install gns3-server
pipx install gns3-gui
pipx inject gns3-gui gns3-server PyQt5
```

## Create GNS3 App Shortcut

```bash
sudo curl -o /usr/share/applications/gns3.desktop https://raw.githubusercontent.com/GNS3/gns3-gui/master/resources/linux/applications/gns3.desktop
sudo curl -o /usr/share/mime/packages/gns3-gui.xml https://raw.githubusercontent.com/GNS3/gns3-gui/master/resources/linux/gns3-gui.xml
sudo curl -o /usr/share/icons/hicolor/16x16/apps/gns3.png https://raw.githubusercontent.com/GNS3/gns3-gui/master/resources/linux/icons/hicolor/16x16/apps/gns3.png
sudo curl -o /usr/share/icons/hicolor/32x32/apps/gns3.png https://raw.githubusercontent.com/GNS3/gns3-gui/master/resources/linux/icons/hicolor/32x32/apps/gns3.png
sudo curl -o /usr/share/icons/hicolor/48x48/apps/gns3.png https://raw.githubusercontent.com/GNS3/gns3-gui/master/resources/linux/icons/hicolor/48x48/apps/gns3.png
sudo curl -o /usr/share/icons/hicolor/48x48/mimetypes/application-x-gns3.png https://raw.githubusercontent.com/GNS3/gns3-gui/master/resources/linux/icons/hicolor/48x48/mimetypes/application-x-gns3.png
sudo curl -o /usr/share/icons/hicolor/48x48/mimetypes/application-x-gns3appliance.png https://raw.githubusercontent.com/GNS3/gns3-gui/master/resources/linux/icons/hicolor/48x48/mimetypes/application-x-gns3appliance.png
sudo curl -o /usr/share/icons/hicolor/48x48/mimetypes/application-x-gns3project.png https://raw.githubusercontent.com/GNS3/gns3-gui/master/resources/linux/icons/hicolor/48x48/mimetypes/application-x-gns3project.png
sudo curl -o /usr/share/icons/hicolor/scalable/apps/gns3.svg https://raw.githubusercontent.com/GNS3/gns3-gui/master/resources/linux/icons/hicolor/scalable/apps/gns3.svg
sudo curl -o /usr/share/icons/hicolor/scalable/apps/application-x-gns3.svg https://raw.githubusercontent.com/GNS3/gns3-gui/master/resources/linux/icons/hicolor/scalable/mimetypes/application-x-gns3.svg
sudo curl -o /usr/share/icons/hicolor/scalable/apps/application-x-gns3appliance.svg https://raw.githubusercontent.com/GNS3/gns3-gui/master/resources/linux/icons/hicolor/scalable/mimetypes/application-x-gns3appliance.svg
sudo curl -o /usr/share/icons/hicolor/scalable/apps/application-x-gns3project.svg https://raw.githubusercontent.com/GNS3/gns3-gui/master/resources/linux/icons/hicolor/scalable/mimetypes/application-x-gns3project.svg
sudo update-icon-caches /usr/share/icons/*
```

## Add User to Groups

Replace `$user` with your username.

```bash
sudo usermod -aG docker,wireshark,kvm,libvirt $user
```
