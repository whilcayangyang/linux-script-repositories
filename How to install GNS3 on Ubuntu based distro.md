# How to install GNS3 on Ubuntu based distro </br>

sudo add-apt-repository ppa:gns3/ppa
sudo apt-key export A2E3EF7B | sudo gpg --dearmour -o /usr/share/keyrings/gns3.gpg

sudo nano /etc/apt/sources.list.d/gns3-ppa-jammy.list
Insert the following parameter to the repo:

[arch=amd64 signed-by=/usr/share/keyrings/gns3.gpg]

Should be like this: deb [arch=amd64 signed-by=/usr/share/keyrings/gns3.gpg] http://ppa.launchpad.net/gns3/ppa/ubuntu jammy main

sudo apt update                                
sudo apt install gns3-gui gns3-server

sudo apt-get install ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/docker-keyring.gpg arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"|sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

Finally, add your user to the following groups:

ubridge libvirt kvm wireshark docker

sudo usermod -aG docker username
sudo usermod -aG wireshark username
sudo usermod -aG kvm username
sudo usermod -aG libvirt username
sudo usermod -aG ubridge username
