# Fedora DNS over TLS using systemd-resolved</br>

**Step 1 : Set-up systemd-resolved**</br>

Modify /etc/systemd/resolved.conf so that it is similar to what is shown below.</br>
Be sure to enable DNS over TLS and to configure the IP addresses of the DNS servers you want to use.</br>

- DNS: A space-separated list of IPv4 and IPv6 addresses to use as system DNS servers</br>
- Domains: These domains are used as search suffixes when resolving single-label host names, ~. stand for use the system DNS server defined with DNS= preferably for all domains.</br>
- DNSOverTLS: If true all connections to the server will be encrypted. Note that this mode requires a DNS server that supports DNS-over-TLS and has a valid certificate for it’s IP.</br>

*$ sudo nano /etc/systemd/resolved.conf*</br>

[Resolve]</br>
DNS=1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001</br>
DNSOverTLS=yes</br>
DNSSEC=yes</br>

**Step 2 : Tell NetworkManager to push info to systemd-resolved**</br>

*$ sudo nano /etc/NetworkManager/conf.d/10-dns-systemd-resolved.conf*</br>
[main]</br>
dns=systemd-resolved</br>
systemd-resolved=false</br>

The setting shown above (dns=systemd-resolved) will cause NetworkManager to push DNS information acquired from DHCP to the systemd-resolved service.</br>
This will override the DNS settings configured in Step 1. This is fine on a trusted network, but feel free to set dns=none instead to use the DNS servers configured in /etc/systemd/resolved.conf</br>

**Step 3 : start & restart services**</br>

To make the settings configured in the previous steps take effect, start and enable systemd-resolved. Then restart NetworkManager.</br>

CAUTION: This will lead to a loss of connection for a few seconds while NetworkManager is restarting.</br>

*$ sudo systemctl start systemd-resolved</br>
$ sudo systemctl enable systemd-resolved</br>
$ sudo systemctl restart NetworkManager</br>*
