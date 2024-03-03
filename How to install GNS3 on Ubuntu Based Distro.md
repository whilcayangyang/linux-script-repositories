# How to install GNS3 on Ubuntu Based Distro </br>

**Add GNS3 repositories** <br>
- sudo add-apt-repository ppa:gns3/ppa <br>
- sudo apt-key export A2E3EF7B | sudo gpg --dearmour -o /usr/share/keyrings/gns3.gpg <br>

**Edit the following parameter to the repo:**
- sudo nano /etc/apt/sources.list.d/gns3-ppa-jammy.list

Insert **[arch=amd64 signed-by=/usr/share/keyrings/gns3.gpg]** </br>

**Should be like this:** deb [arch=amd64 signed-by=/usr/share/keyrings/gns3.gpg] http://ppa.launchpad.net/gns3/ppa/ubuntu jammy main </br>

**Install GNS Package** </br>
- sudo apt update; sudo apt install gns3-gui gns3-server -y

**Install Docker CE** <br>
- sudo apt-get update; sudo apt-get install -y ca-certificates curl gnupg </br>
- sudo install -m 0755 -d /etc/apt/keyrings </br>
- curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg </br>
- sudo chmod a+r /etc/apt/keyrings/docker.gpg </br>
- echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null </br>
- sudo apt-get update; sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin </br>

**Finally, add your user to the following groups:** <br>
ubridge libvirt kvm wireshark docker </br>

- sudo usermod -aG docker,wireshark,kvm,libvirt,ubridge username

