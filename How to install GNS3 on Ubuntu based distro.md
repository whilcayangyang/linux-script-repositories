# How to install GNS3 on Ubuntu based distro </br>

**Add GNS3 repositories** <br>
sudo add-apt-repository ppa:gns3/ppa <br>
sudo apt-key export A2E3EF7B | sudo gpg --dearmour -o /usr/share/keyrings/gns3.gpg <br>

**Edit the following parameter to the repo:**
sudo nano /etc/apt/sources.list.d/gns3-ppa-jammy.list

Insert **[arch=amd64 signed-by=/usr/share/keyrings/gns3.gpg]** </br>

**Should be like this:** deb [arch=amd64 signed-by=/usr/share/keyrings/gns3.gpg] http://ppa.launchpad.net/gns3/ppa/ubuntu jammy main </br>

**Install GNS Package** </br>
sudo apt update; sudo apt install gns3-gui gns3-server -y

**Install Docker CE** <br>
sudo apt-get install ca-certificates curl gnupg lsb-release -y </br>
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-keyring.gpg </br>
echo "deb [signed-by=/usr/share/keyrings/docker-keyring.gpg arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"|sudo tee /etc/apt/sources.list.d/docker.list </br>
sudo apt update; sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y </br>

Finally, add your user to the following groups:

ubridge libvirt kvm wireshark docker

sudo usermod -aG docker username
sudo usermod -aG wireshark username
sudo usermod -aG kvm username
sudo usermod -aG libvirt username
sudo usermod -aG ubridge username

