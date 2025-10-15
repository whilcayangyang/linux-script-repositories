# EndeavourOS Post-Install Guide

Comprehensive steps for configuring EndeavourOS after installation.

## Table of Contents

- [Update Mirror List](#update-mirror-list)
- [Install KDE Packages](#install-kde-packages)
- [Install GNOME Packages](#install-gnome-packages)
- [Screen Record Bug Fix](#screen-record-bug-fix)
- [KDE Plasma Error Fix](#kde-plasma-error-fix)
- [Firewall Setup](#firewall-setup)
- [System Backup & Restore](#system-backup--restore)
- [Laptop Utilities](#laptop-utilities)
- [SSD Optimization](#ssd-optimization)
- [Package Maintenance](#package-maintenance)

---

## Update Mirror List

Edit country codes as needed.

```bash
sudo reflector --protocol https --latest 10 --sort rate -c CN,HK,TW,SG --save /etc/pacman.d/mirrorlist --verbose
```

## Install KDE Packages

```bash
sudo pacman -S yakuake gimp libreoffice ktorrent simplescreenrecorder sweeper partitionmanager plasma-systemmonitor ksysguard ufw plasma-firewall neofetch kcalc htop kwallet --noconfirm
yay -S brave-bin zoom viber ttf-ms-fonts sublime-text-4 plasma5-applets-thermal-monitor-git --noconfirm
```

## Install GNOME Packages

```bash
sudo pacman -S cheese gnome-weather geary pitivi gparted gimp libreoffice gnome-system-monitor neofetch htop gnome-clocks gnome-calendar transmission-gtk bleachbit rhythmbox simple-scan --noconfirm
yay -S brave-bin zoom viber ttf-ms-fonts sublime-text-4 gnome-shell-extension-dash-to-dock gnome-shell-extension-system-monitor-git --noconfirm
```

## Screen Record Bug Fix

```bash
sudo pacman -Rns xf86-video-intel
```

## KDE Plasma Error Fix

```bash
rm -rf ~/.cache/*plasma*
killall plasmashell
kstart5 plasmashell
```

## Firewall Setup

```bash
sudo ufw enable
sudo systemctl enable --now ufw
```

## System Backup & Restore

```bash
yay -S grub-btrfs timeshift timeshift-autosnap --noconfirm
sudo systemctl enable --now grub-btrfs
```

## Laptop Utilities

```bash
sudo pacman -S bluedevil --noconfirm
yay -S tlp tlp-rdw auto-cpufreq --noconfirm
sudo systemctl enable --now tlp
sudo systemctl enable --now auto-cpufreq
sudo systemctl enable --now bluetooth
```

## SSD Optimization

```bash
sudo systemctl enable --now fstrim
```

## Package Maintenance

```bash
yay -Sc --noconfirm
sudo pacman -Sc --noconfirm
sudo pacman -Qtdq | sudo pacman -Rns - --noconfirm
```
