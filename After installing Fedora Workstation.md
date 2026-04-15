# Fedora Workstation Post-Install Guide

Recommended steps for configuring Fedora Workstation after installation.

## Table of Contents

- [Enable RPM Fusion Repositories](#enable-rpm-fusion-repositories)
- [System Upgrade](#system-upgrade)
- [Install Essential Packages](#install-essential-packages)
- [Flatpak Flathub](#flatpak-flathub)
- [GNOME Software Flatpak Default](#gnome-software-flatpak-default)
- [Install Flatpak Apps](#install-flatpak-apps)
- [OhMyZsh & Plugins](#ohmyzsh--plugins)
- [Visual Studio Code](#visual-studio-code)
- [Lenovo T14 — Disable Bluetooth Autostart](#lenovo-t14--disable-bluetooth-autostart)
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
sudo dnf upgrade -y
```

## Install Essential Packages

```bash
sudo dnf install -y \
  gnome-shell-extension-appindicator \
  gnome-tweaks \
  adw-gtk3-theme \
  libreoffice-draw \
  vim \
  fuse \
  fuse-libs
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
  com.mattjakeman.ExtensionManager \
  dev.deedles.Trayscale
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

## Lenovo T14 — Disable Bluetooth Autostart

Prevents Bluetooth from powering on automatically at boot. Useful on the T14 where the adapter enables itself on every startup even when not needed.

```bash
sudo sed -i 's/^AutoEnable=true/AutoEnable=false/' /etc/bluetooth/main.conf
```

Verify the change took effect:

```bash
grep AutoEnable /etc/bluetooth/main.conf
```

Restart the Bluetooth service to apply without rebooting:

```bash
sudo systemctl restart bluetooth
```

## Fix Shutdown Not Fully Powering Off

Applies to: **B460M AORUS PRO with RX6600 GPU** — sometimes does not fully power off on shutdown.

```bash
sudo grubby --update-kernel=ALL --args="reboot=pci amdgpu.runpm=0 amdgpu.aspm=0 amdgpu.sg_display=0 plymouth.enable=0 intel_iommu=on iommu=pt mem_sleep_default=deep"
```

Confirm the parameters are active after reboot:

```bash
cat /proc/cmdline
```

Parameter purpose:

- `reboot=pci`: Forces the PCI reboot method, resolving boards that hang during power-off.
- `amdgpu.runpm=0`: Disables AMD GPU runtime power management, avoiding shutdown/power-state handoff issues.
- `amdgpu.aspm=0`: Disables PCIe ASPM for the AMD GPU, reducing link power-management glitches on shutdown.
- `amdgpu.sg_display=0`: Disables scatter-gather display, which can cause hangs on some boards during power-off.
- `plymouth.enable=0`: Disables the Plymouth boot splash, removing a potential stall point during shutdown.
- `intel_iommu=on`: Enables Intel IOMMU (VT-d), required for GPU passthrough and VFIO isolation.
- `iommu=pt`: Sets IOMMU to pass-through mode, reducing overhead for devices not assigned to a VM.
- `mem_sleep_default=s2idle`: Sets default suspend to s2idle (shallow suspend), more reliable with AMD GPUs or PCIe power-management issues.

## BIOS Settings to Verify

Enter BIOS and verify:

- Disable Wake on LAN
- Disable USB Wake
- Set ErP to Enabled (if currently Disabled)
- Disable Fast Boot
