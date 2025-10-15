# TP-Link AX23 Revert to Stock Firmware Manual

## Reference

- Go to TP-Link and Download 1.1.0 Build: [TP-Link Support](https://www.tp-link.com/br/support/download/archer-ax23/v1.20/#Firmware)
- Direct Download: [Archer AX23(US)_1.2_230725.zip](https://static.tp-link.com/upload/firmware/2023/202312/20231208/Archer%20AX23(US)_1.2_230725.zip)

---

## Steps

### 1. Update package lists

```bash
opkg update
```

### 2. Install required kernel module

```bash
opkg install kmod-mtd-rw
```

### 3. Load the kernel module

```bash
insmod mtd-rw.ko i_want_a_brick=1
```

### 4. Create version file

```bash
echo "1.1.0 Build" > /tmp/vers.ion
```

### 5. Write version info to MTD

```bash
dd if=/tmp/vers.ion of=/dev/mtd6 seek=198673 count=11 bs=1 conv=notrunc
```

---

**Warning:**  
These commands modify the firmware and may brick your device if used incorrectly. Proceed at your own risk.