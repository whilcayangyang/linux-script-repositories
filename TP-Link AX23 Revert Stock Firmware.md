# TP-Link AX23: Revert to Stock Firmware

Step-by-step instructions for restoring TP-Link AX23 router to stock firmware.

## Table of Contents

- [Reference Downloads](#reference-downloads)
- [Update Package Lists](#update-package-lists)
- [Install Kernel Module](#install-kernel-module)
- [Load Kernel Module](#load-kernel-module)
- [Create Version File](#create-version-file)
- [Write Version Info to MTD](#write-version-info-to-mtd)
- [Warning](#warning)

---

## Reference Downloads

- [TP-Link Support: Firmware 1.1.0 Build](https://www.tp-link.com/br/support/download/archer-ax23/v1.20/#Firmware)
- [Direct Download: Archer AX23(US)_1.2_230725.zip](https://static.tp-link.com/upload/firmware/2023/202312/20231208/Archer%20AX23(US)_1.2_230725.zip)

## Update Package Lists

```bash
opkg update
```

## Install Kernel Module

```bash
opkg install kmod-mtd-rw
```

## Load Kernel Module

```bash
insmod mtd-rw.ko i_want_a_brick=1
```

## Create Version File

```bash
echo "1.1.0 Build" > /tmp/vers.ion
```

## Write Version Info to MTD

```bash
dd if=/tmp/vers.ion of=/dev/mtd6 seek=198673 count=11 bs=1 conv=notrunc
```

## Warning

> **Caution:**  
> These commands modify the firmware and may brick your device if used incorrectly. Proceed at your own risk.