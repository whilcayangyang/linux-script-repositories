# Debian GNOME Desktop Post-Install Guide

A step-by-step guide for configuring and optimizing a fresh Debian GNOME Desktop installation.

## Table of Contents

- [Remove Unwanted Packages](#remove-unwanted-packages)
- [Enable Non-Free Repository](#enable-non-free-repository)
- [Install Essential System Apps](#install-essential-system-apps)
- [Configure Firewall](#configure-firewall)
- [Logitech Device Support](#logitech-device-support)
- [Flatpak & GNOME Software](#flatpak--gnome-software)
- [Install Flatpak Apps](#install-flatpak-apps)
- [KVM/QEMU Virtualization (Optional)](#kvmqemu-virtualization-optional)
- [Install adw-gtk3 Theme](#install-adw-gtk3-theme)
- [Firefox GNOME Theme](#firefox-gnome-theme)
- [OhMyZsh & Plugins](#ohmyzsh--plugins)
- [Laptop Battery Optimization](#laptop-battery-optimization)
- [Lid Switch Behavior](#lid-switch-behavior)

---

## Remove Unwanted Packages

```bash
sudo apt autoremove -y gnome-terminal libreoffice-core libreoffice-common
```

## Enable 'contrib non-free' Repository

```bash
sudo sed -i '/non-free-firmware/ {
  /contrib non-free/! s/non-free-firmware/& contrib non-free/
}' /etc/apt/sources.list
sudo apt update
```

## Install Essential System Apps

```bash
sudo apt install -y gnome-shell-extension-system-monitor \
  gnome-shell-extension-freon \
  lm-sensors \
  gnome-shell-extension-appindicator \
  gnome-shell-extension-dashtodock \
  gnome-shell-extension-manager \
  papirus-icon-theme \
  ttf-mscorefonts-installer \
  libavcodec-extra \
  gnome-console \
  ufw \
  curl \
  git
```

## Configure Firewall

```bash
sudo ufw enable
sudo ufw reload
```

## Logitech Device Support

```bash
sudo apt install -y solaar
```

## Flatpak & GNOME Software

```bash
sudo apt install -y flatpak gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
gsettings set org.gnome.software packaging-format-preference "['flatpak', 'deb']"
```

## Install Flatpak Apps

```bash
flatpak install -y flathub \
  com.brave.Browser \
  com.mikrotik.WinBox \
  org.gtk.Gtk3theme.adw-gtk3 \
  org.gtk.Gtk3theme.adw-gtk3-dark \
  org.gimp.GIMP \
  org.libreoffice.LibreOffice \
  com.discordapp.Discord \
  com.slack.Slack \
  com.jgraph.drawio.desktop \
  it.mijorus.gearlever \
  org.videolan.VLC \
  org.kde.kdenlive \
  org.libreoffice.LibreOffice
```

## KVM/QEMU Virtualization (Optional)

> Uncomment to enable virtualization.

```bash
# sudo apt install -y qemu-kvm libvirt-daemon libvirt-clients bridge-utils virt-manager
# sudo systemctl enable --now libvirtd
# sudo virsh net-autostart default
```

## Install adw-gtk3 Theme

```bash
cd /usr/share/themes
sudo wget https://github.com/lassekongo83/adw-gtk3/releases/download/v6.4/adw-gtk3v6.4.tar.xz
sudo tar -xvf adw-gtk3v6.4.tar.xz
sudo chown -R --reference Default adw-gtk3*
sudo rm -f adw-gtk3v6.4.tar.xz
```

## Firefox GNOME Theme

```bash
curl -s -o- https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh | bash
```

## OhMyZsh & Plugins

```bash
sudo apt install -y zsh fonts-powerline zsh-autosuggestions zsh-syntax-highlighting git fastfetch
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sed -i '/source $ZSH\/oh-my-zsh.sh/ a\source \/usr\/share\/zsh-autosuggestions\/zsh-autosuggestions.zsh' ~/.zshrc
sed -i '/source $ZSH\/oh-my-zsh.sh/ a\source \/usr\/share\/zsh-syntax-highlighting\/zsh-syntax-highlighting.zsh' ~/.zshrc
sed -i 's/plugins=(git)/plugins=(docker terraform debian systemd)/' ~/.zshrc
sed -i '$a\fastfetch' ~/.zshrc
```

## Laptop Battery Optimization

```bash
sudo apt install -y tlp tlp-rdw
sudo systemctl enable --now tlp.service
sudo systemctl mask systemd-rfkill.service
sudo systemctl mask systemd-rfkill.socket
sudo systemctl mask power-profiles-daemon.service
```

### TLP Settings

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
sed -i 's/#PLATFORM_PROFILE_ON_BAT=low-power/PLATFORM_PROFILE_ON_BAT=low-power/' /etc/tlp.conf
sed -i 's/#START_CHARGE_THRESH_BAT0=75/START_CHARGE_THRESH_BAT0=0/' /etc/tlp.conf
sed -i 's/#STOP_CHARGE_THRESH_BAT0=80/STOP_CHARGE_THRESH_BAT0=1/' /etc/tlp.conf
sed -i 's/#RESTORE_DEVICE_STATE_ON_STARTUP=0/RESTORE_DEVICE_STATE_ON_STARTUP=1/' /etc/tlp.conf
```

## Lid Switch Behavior

```bash
sed -i 's/#HandleLidSwitch=suspend/HandleLidSwitch=suspend/' /etc/systemd/logind.conf
sed -i 's/#HandleLidSwitchExternalPower=suspend/HandleLidSwitchExternalPower=suspend/' /etc/systemd/logind.conf
```
