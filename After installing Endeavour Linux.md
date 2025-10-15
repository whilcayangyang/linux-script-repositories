# EndeavourOS Post-Install Manual

## 1. Update Mirror List (Edit country codes for your location)

```bash
sudo reflector --protocol https --latest 10 --sort rate -c CN,HK,TW,SG --save /etc/pacman.d/mirrorlist --verbose
```

## 2. Install KDE Packages

```bash
sudo pacman -S yakuake gimp libreoffice ktorrent simplescreenrecorder sweeper partitionmanager plasma-systemmonitor ksysguard ufw plasma-firewall neofetch kcalc htop kwallet --noconfirm
yay -S brave-bin zoom viber ttf-ms-fonts sublime-text-4 plasma5-applets-thermal-monitor-git --noconfirm
```

## 3. Install GNOME Packages

```bash
sudo pacman -S cheese gnome-weather geary pitivi gparted gimp libreoffice gnome-system-monitor neofetch htop gnome-clocks gnome-calendar transmission-gtk bleachbit rhythmbox simple-scan --noconfirm
yay -S brave-bin zoom viber ttf-ms-fonts sublime-text-4 gnome-shell-extension-dash-to-dock gnome-shell-extension-system-monitor-git --noconfirm
```

## 4. Fix Screen Record Bug

```bash
sudo pacman -Rns xf86-video-intel
```

## 5. KDE Plasma Error Fix

```bash
rm -rf ~/.cache/*plasma*
killall plasmashell
kstart5 plasmashell
```

## 6. Firewall Configuration

```bash
sudo ufw enable
sudo systemctl enable --now ufw
```

## 7. Timeshift System Backup and Restore

```bash
yay -S grub-btrfs timeshift timeshift-autosnap --noconfirm
sudo systemctl enable --now grub-btrfs
```

## 8. Laptop Utilities (if on laptop)

```bash
sudo pacman -S bluedevil --noconfirm
yay -S tlp tlp-rdw auto-cpufreq --noconfirm
sudo systemctl enable --now tlp
sudo systemctl enable --now auto-cpufreq
sudo systemctl enable --now bluetooth
```

## 9. SSD Optimization (if SSD detected)

```bash
sudo systemctl enable --now fstrim
```

## 10. Package Maintenance

```bash
yay -Sc --noconfirm
sudo pacman -Sc --noconfirm
sudo pacman -Qtdq | sudo pacman -Rns - --noconfirm
```

---
