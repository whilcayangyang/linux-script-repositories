# ClamAV Installation & Configuration Guide for Fedora 42

Instructions for installing, configuring, and enabling ClamAV antivirus on Fedora 42.

## Table of Contents

- [Install ClamAV Packages](#install-clamav-packages)
- [Enable Automatic Database Update](#enable-automatic-database-update)
- [Edit Scan Configuration](#edit-scan-configuration)
- [Enable On-access Scan](#enable-on-access-scan)
- [Create Quarantine Folder](#create-quarantine-folder)
- [Mount Quarantine as tmpfs](#mount-quarantine-as-tmpfs)
- [Configure On-access Service](#configure-on-access-service)
- [Enable Services](#enable-services)
- [SELinux Configuration](#selinux-configuration)
- [Manual Scanning](#manual-scanning)

---

## Install ClamAV Packages

```bash
sudo dnf install -y clamav clamav-freshclam clamd
```

## Enable Automatic Database Update

```bash
sudo systemctl enable --now clamav-freshclam.service
```

## Edit Scan Configuration

```bash
sudo vim /etc/clamd.d/scan.conf
```

Uncomment these lines:
- `LocalSocket`
- `LocalSocketGroup`
- `LocalSocketMode`
- `FixStaleSocket`

## Enable On-access Scan

Add to `scan.conf`:

```
OnAccessIncludePath /home/user/Downloads
OnAccessIncludePath /home/user/Documents
OnAccessExcludeRootUID yes
OnAccessExcludeUname clamscan
OnAccessPrevention yes
```

## Create Quarantine Folder

```bash
sudo mkdir -p /var/quarantine/clamav
sudo chown -R clamscan:clamscan /var/quarantine/clamav
sudo chmod -R 0700 /var/quarantine/clamav
```

## Mount Quarantine as tmpfs

Add to `/etc/fstab`:

```
tmpfs /var/quarantine/clamav tmpfs defaults,noexec,nosuid,nodev 0 0
```

## Configure On-access Service

Add to `/usr/lib/systemd/system/clamav-clamonacc.service`:

```
ExecStart=/usr/sbin/clamonacc --fdpass -F --config-file=/etc/clamd.d/scan.conf --move=/var/quarantine/clamav
```

## Enable Services

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now clamd@scan.service clamav-clamonacc.service
```

## SELinux Configuration

```bash
sudo setsebool -P antivirus_can_scan_system 1
```

## Manual Scanning

```bash
sudo clamdscan --fdpass --allmatch /home/user/Documents
```
