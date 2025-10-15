# Fedora Post-Install Script Manual

## 1. Enable RPM Fusion Repositories

```bash
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

## 2. System Upgrade

```bash
sudo dnf update -y
```

## 3. Install Basic Packages

```bash
sudo dnf install -y gnome-shell-extension-system-monitor-applet \
    gnome-shell-extension-appindicator \
    gnome-shell-extension-drive-menu \
    gnome-tweaks \
    gnome-extensions-app \
    adw-gtk3-theme \
    libreoffice-draw \
    vim \
    filezilla \
    transmission \
    steam
```

## 4. Install KVM Virtualization

```bash
sudo dnf install -y bridge-utils \
    libvirt \
    virt-install \
    virt-manager \
    qemu-kvm
sudo usermod -aG libvirt $(whoami)
sudo systemctl enable --now libvirtd
sudo dnf remove -y gnome-boxes
```

## 5. Install Docker CE

```bash
sudo dnf remove -y docker \
    docker-client \
    docker-client-latest \
    docker-common \
    docker-latest \
    docker-latest-logrotate \
    docker-logrotate \
    docker-selinux \
    docker-engine-selinux \
    docker-engine
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin
sudo systemctl enable --now docker
sudo usermod -aG docker $(whoami)
```

## 6. Enable Flatpak Flathub and Disable Fedora Flatpak

```bash
sudo flatpak remote-modify --disable fedora
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-modify --enable flathub
```

## 7. Set Flatpak as Default in GNOME Software

```bash
gsettings set org.gnome.software packaging-format-preference "['flatpak', 'rpm']"
```

## 8. Install Flatpak Packages

```bash
flatpak install -y flathub \
    org.gtk.Gtk3theme.adw-gtk3 \
    org.gtk.Gtk3theme.adw-gtk3-dark \
    org.gimp.GIMP \
    com.calibre_ebook.calibre \
    com.jgraph.drawio.desktop \
    io.gitlab.adhami3310.Impression \
    com.discordapp.Discord \
    com.slack.Slack \
    it.mijorus.gearlever
```

## 9. Install Firefox GNOME Theme

```bash
curl -s -o- https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh | bash
```

## 10. Install OhMyZsh and Plugins

```bash
sudo dnf install -y zsh \
    curl \
    git \
    fastfetch \
    powerline-fonts \
    zsh-autosuggestions \
    zsh-syntax-highlighting
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Add plugins and fastfetch to `.zshrc`:

```bash
sed -i '/source $ZSH\/oh-my-zsh.sh/ a\source \/usr\/share\/zsh-autosuggestions\/zsh-autosuggestions.zsh' ~/.zshrc
sed -i '/source $ZSH\/oh-my-zsh.sh/ a\source \/usr\/share\/zsh-syntax-highlighting\/zsh-syntax-highlighting.zsh' ~/.zshrc
sed -i 's/plugins=(git)/plugins=(docker firewalld dnf systemd sudo)/' ~/.zshrc
sed -i '$a\fastfetch' ~/.zshrc
```

## 11. Install Visual Studio Code

```bash
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
sudo dnf check-update
sudo dnf install -y code
```

## 12. Laptop Battery Optimization (if on laptop)

```bash
sudo dnf remove -y power-profiles-daemon
sudo dnf install -y tlp tlp-rdw
sudo systemctl enable --now tlp.service
sudo systemctl mask systemd-rfkill.service
sudo systemctl mask systemd-rfkill.socket
```

### Optimize TLP Settings

> **Note:** Threshold values depend on the laptop vendor. See documentation: https://linrunner.de/tlp/settings/bc-vendors.html

```bash
sed -i 's/#CPU_BOOST_ON_AC=1/CPU_BOOST_ON_AC=1/' /etc/tlp.conf
sed -i 's/#CPU_BOOST_ON_BAT=0/CPU_BOOST_ON_BAT=0/' /etc/tlp.conf
sed -i 's/#CPU_HWP_DYN_BOOST_ON_AC=1/CPU_HWP_DYN_BOOST_ON_AC=1/' /etc/tlp.conf
sed -i 's/#CPU_HWP_DYN_BOOST_ON_BAT=0/CPU_HWP_DYN_BOOST_ON_BAT=0/' /etc/tlp.conf
sed -i 's/#CPU_ENERGY_PERF_POLICY_ON_AC=balance_performance/CPU_ENERGY_PERF_POLICY_ON_AC=performance/' /etc/tlp.conf
sed -i 's/#CPU_ENERGY_PERF_POLICY_ON_BAT=balance_power/CPU_ENERGY_PERF_POLICY_ON_BAT=balance_power/' /etc/tlp.conf
sed -i 's/#CPU_SCALING_GOVERNOR_ON_AC=powersave/CPU_SCALING_GOVERNOR_ON_AC=performance/' /etc/tlp.conf
sed -i 's/#CPU_SCALING_GOVERNOR_ON_BAT=powersave/CPU_SCALING_GOVERNOR_ON_BAT=powersave/' /etc/tlp.conf
sed -i 's/#PLATFORM_PROFILE_ON_AC=performance/PLATFORM_PROFILE_ON_AC=performance/' /etc/tlp.conf
sed -i 's/#PLATFORM_PROFILE_ON_BAT=low-power/PLATFORM_PROFILE_ON_BAT=balanced/' /etc/tlp.conf
sed -i 's/#START_CHARGE_THRESH_BAT0=75/START_CHARGE_THRESH_BAT0=0/' /etc/tlp.conf
sed -i 's/#STOP_CHARGE_THRESH_BAT0=80/STOP_CHARGE_THRESH_BAT0=1/' /etc/tlp.conf
sed -i 's/#RESTORE_DEVICE_STATE_ON_STARTUP=0/RESTORE_DEVICE_STATE_ON_STARTUP=1/' /etc/tlp.conf
```

If not a laptop, nothing to do.

---