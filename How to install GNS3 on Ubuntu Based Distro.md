# GNS3 Installation Guide for Ubuntu-Based Distros

Instructions for installing GNS3 and dependencies on Ubuntu-based distributions.

## Table of Contents

- [Add GNS3 Repository](#add-gns3-repository)
- [Edit Repository Source](#edit-repository-source)
- [Install GNS3 Packages](#install-gns3-packages)
- [Install Docker CE](#install-docker-ce)
- [Add User to Groups](#add-user-to-groups)

---

## Add GNS3 Repository

```bash
sudo add-apt-repository ppa:gns3/ppa
sudo apt-key export A2E3EF7B | sudo gpg --dearmour -o /usr/share/keyrings/gns3.gpg
```

## Edit Repository Source

```bash
sudo nano /etc/apt/sources.list.d/gns3-ppa-jammy.list
```

Change the line to:

```
deb [arch=amd64 signed-by=/usr/share/keyrings/gns3.gpg] http://ppa.launchpad.net/gns3/ppa/ubuntu jammy main
```

## Install GNS3 Packages

```bash
sudo apt update
sudo apt install gns3-gui gns3-server -y
```

## Install Docker CE

```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## Add User to Groups

Replace `username` with your actual username.

```bash
sudo usermod -aG docker,wireshark,kvm,libvirt,ubridge username
```

Add your user to these groups:  
`ubridge`, `libvirt`, `kvm`, `wireshark`, `docker`

