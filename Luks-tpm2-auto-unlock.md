# LUKS TPM2 Auto-Unlock on Fedora

Automate LUKS disk decryption at boot using TPM2, equivalent to BitLocker's auto-unlock behavior. Passphrase remains as fallback — TPM2 is added as an additional unlock slot.

---

## Prerequisites

| Requirement | Check |
|-------------|-------|
| TPM2 chip | `ls /dev/tpm*` → `/dev/tpm0` and `/dev/tpmrm0` |
| LUKS2 | `sudo cryptsetup luksDump /dev/nvmeXnXpX \| grep Version` → `Version: 2` |
| Secure Boot | `mokutil --sb-state` → `SecureBoot enabled` |
| Fedora 35+ | `systemd-cryptenroll` built-in |

---

## Setup

### 1. Identify the LUKS partition

```bash
lsblk -f | grep crypto_LUKS
```

Note the device path (e.g., `/dev/nvme0n1p3`) and UUID.

### 2. Enroll TPM2 key

```bash
sudo systemd-cryptenroll --wipe-slot tpm2 \
  --tpm2-device auto \
  --tpm2-pcrs "0+1+2+4+7" \
  /dev/nvme0n1p3
```

Enter your LUKS passphrase when prompted. This adds a new key slot — the existing passphrase slot is untouched.

### 3. Update `/etc/crypttab`

Add `tpm2-device=auto` to the options field:

```
luks-<uuid>  UUID=<uuid>  none  discard,tpm2-device=auto
```

### 4. Regenerate initramfs and reboot

```bash
sudo dracut -fv --regenerate-all
sudo reboot
```

---

## PCR Reference

PCRs (Platform Configuration Registers) are TPM2 registers that measure specific parts of the boot chain. The TPM seals the LUKS key against the state of selected PCRs at enrollment time.

| PCR | Measures |
|-----|----------|
| 0 | UEFI firmware |
| 1 | UEFI firmware config + hardware (RAM, CPU, devices) |
| 2 | Option ROMs (expansion cards) |
| 4 | Boot manager / bootloader |
| 7 | Secure Boot policy and certificates |
| 9 | initramfs (excludes from default set — see below) |

### PCR selection: `0+1+2+4+7`

This set mirrors BitLocker behavior:

**Triggers re-prompt (passphrase required):**
- Firmware update
- Hardware swap (RAM, NVMe, PCIe cards)
- Bootloader change
- Secure Boot certificate changes

**Does NOT trigger re-prompt:**
- Kernel updates
- initramfs regeneration (`dnf update`)

> Adding PCR 9 would protect against initramfs tampering but requires re-enrollment after every kernel update. Not recommended unless the machine is high-security or rarely updated.

---

## Behavior on Re-prompt

If PCR state doesn't match (e.g., after a firmware update), the system falls back to the passphrase **for that boot only**. Auto-unlock resumes on subsequent boots once PCR values stabilize.

If hardware/firmware changes are permanent, re-enroll against the new state:

```bash
sudo systemd-cryptenroll --wipe-slot tpm2 \
  --tpm2-device auto \
  --tpm2-pcrs "0+1+2+4+7" \
  /dev/nvme0n1p3
```

---

## Verification

Check enrolled slots after setup:

```bash
sudo cryptsetup luksDump /dev/nvme0n1p3 | grep -A5 Tokens
```

Expect to see a `systemd-tpm2` token alongside the existing passphrase slot.

---

## Removal

To remove TPM2 enrollment and revert to passphrase-only:

```bash
sudo systemd-cryptenroll --wipe-slot tpm2 /dev/nvme0n1p3
```

Then remove `tpm2-device=auto` from `/etc/crypttab` and regenerate initramfs.
