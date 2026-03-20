# Fedora Workstation Post-Install Guide

Recommended steps for configuring Fedora Workstation after installation.

## Table of Contents

- [Enable RPM Fusion Repositories](#enable-rpm-fusion-repositories)
- [System Upgrade](#system-upgrade)
- [Install Essential Packages](#install-essential-packages)
- [KVM Virtualization](#kvm-virtualization)
- [Docker CE](#docker-ce)
- [Flatpak Flathub](#flatpak-flathub)
- [GNOME Software Flatpak Default](#gnome-software-flatpak-default)
- [Install Flatpak Apps](#install-flatpak-apps)
- [Firefox GNOME Theme](#firefox-gnome-theme)
- [OhMyZsh & Plugins](#ohmyzsh--plugins)
- [Visual Studio Code](#visual-studio-code)
- [Laptop Battery Optimization](#laptop-battery-optimization)
- [TLP Settings](#tlp-settings)
- [Fix Shutdown Not Fully Powering Off](#fix-shutdown-not-fully-powering-off)
- [BIOS Settings to Verify](#bios-settings-to-verify)

---

## Enable RPM Fusion Repositories (Optional)

```bash
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

## System Upgrade

```bash
sudo dnf update -y
```

## Install Essential Packages

```bash
sudo dnf install -y gnome-shell-extension-system-monitor-applet \
  gnome-shell-extension-appindicator \
  gnome-shell-extension-dash-to-dock \
  gnome-tweaks \
  gnome-extensions-app \
  adw-gtk3-theme \
  libreoffice-draw \
  vim \
  fuse \
  fuse-libs
```

## KVM Virtualization

```bash
sudo dnf install -y bridge-utils libvirt virt-install virt-manager qemu-kvm
sudo usermod -aG libvirt $(whoami)
sudo systemctl enable --now libvirtd
sudo dnf remove -y gnome-boxes
```

## Docker CE

```bash
sudo dnf remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker
sudo usermod -aG docker $(whoami)
```

## Flatpak Flathub

```bash
sudo flatpak remote-modify --disable fedora
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-modify --enable flathub
```

## GNOME Software Flatpak Default

```bash
gsettings set org.gnome.software packaging-format-preference "['flatpak', 'rpm']"
```

## Install Flatpak Apps

```bash
flatpak install -y flathub \
  com.brave.Browser \
  com.mikrotik.WinBox \
  org.gtk.Gtk3theme.adw-gtk3 \
  org.gtk.Gtk3theme.adw-gtk3-dark \
  org.gimp.GIMP \
  com.discordapp.Discord \
  com.slack.Slack \
  com.jgraph.drawio.desktop \
  it.mijorus.gearlever \
  org.videolan.VLC \
  org.kde.kdenlive \
  it.mijorus.gearlever
```

## Firefox GNOME Theme

```bash
curl -s -o- https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh | bash
```

## OhMyZsh & Plugins

```bash
sudo dnf install -y zsh curl git fastfetch powerline-fonts zsh-autosuggestions zsh-syntax-highlighting
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sed -i '/source $ZSH\/oh-my-zsh.sh/ a\source \/usr\/share\/zsh-autosuggestions\/zsh-autosuggestions.zsh' ~/.zshrc
sed -i '/source $ZSH\/oh-my-zsh.sh/ a\source \/usr\/share\/zsh-syntax-highlighting\/zsh-syntax-highlighting.zsh' ~/.zshrc
sed -i 's/plugins=(git)/plugins=(docker terraform debian systemd)/' ~/.zshrc
sed -i '$a\fastfetch' ~/.zshrc
```

## Visual Studio Code

```bash
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
sudo dnf check-update
sudo dnf install -y code jetbrains-mono-fonts-all
```

## Fix Shutdown Not Fully Powering Off

If your motherboard (B460M AORUS PRO) sometimes does not fully power off on shutdown, add the required kernel parameters with `grubby`.

```bash
sudo grubby --update-kernel=ALL --args="reboot=pci amdgpu.runpm=0 amdgpu.aspm=0"
```

Check the currently running kernel command line:

```bash
sudo cat /proc/cmdline
```

`grubby --update-kernel=ALL` appends the parameters to every installed kernel entry, so future boots keep the same settings.

Parameter purpose:

- `reboot=pci`: Forces the PCI reboot method, which can resolve boards that hang during power-off.
- `amdgpu.runpm=0`: Disables AMD GPU runtime power management, avoiding shutdown/power-state handoff issues.
- `amdgpu.aspm=0`: Disables PCIe ASPM for the AMD GPU, reducing link power-management glitches on shutdown.

`cat /proc/cmdline` shows the command line for the kernel that is running right now. If you run it before rebooting, the new parameters may not appear yet. Reboot first, then run it again to confirm that `reboot=pci`, `amdgpu.runpm=0`, and `amdgpu.aspm=0` are active.

## BIOS Settings to Verify

Enter BIOS and verify:

- Disable Wake on LAN
- Disable USB Wake
- Set ErP to Enabled (if currently Disabled)
- Disable Fast Boot
