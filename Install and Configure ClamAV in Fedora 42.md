# Install and Configure ClamAV in Fedora 42

## 1. Install ClamAV Packages

```bash
sudo dnf install -y clamav clamav-freshclam clamd
```

## 2. Enable Automatic ClamAV Database Update

```bash
sudo systemctl enable --now clamav-freshclam.service
```

## 3. Edit ClamAV Scan Configuration

```bash
sudo vim /etc/clamd.d/scan.conf
```

Uncomment the following lines in `scan.conf`:
- `LocalSocket`
- `LocalSocketGroup`
- `LocalSocketMode`
- `FixStaleSocket`

## 4. Enable On-access Scan Settings

Add these lines to `scan.conf`:

```
OnAccessIncludePath /home/user/Downloads
OnAccessIncludePath /home/user/Documents
OnAccessExcludeRootUID yes
OnAccessExcludeUname clamscan
OnAccessPrevention yes
```

## 5. Create Quarantine Folder

```bash
sudo mkdir -p /var/quarantine/clamav
sudo chown -R clamscan:clamscan /var/quarantine/clamav
sudo chmod -R 0700 /var/quarantine/clamav
```

## 6. Mount Quarantine Folder as tmpfs

Add the following line to `/etc/fstab`:

```
tmpfs /var/quarantine/clamav tmpfs defaults,noexec,nosuid,nodev 0 0
```

## 7. Configure ClamAV On-access Service

Add the following line to `/usr/lib/systemd/system/clamav-clamonacc.service`:

```
ExecStart=/usr/sbin/clamonacc --fdpass -F --config-file=/etc/clamd.d/scan.conf --move=/var/quarantine/clamav
```

## 8. Enable ClamAV Services

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now clamd@scan.service clamav-clamonacc.service
```

## 9. Allow ClamAV in SELinux

```bash
sudo setsebool -P antivirus_can_scan_system 1
```

## 10. Manual Scanning Example

```bash
sudo clamdscan --fdpass --allmatch /home/user/Documents
```
