# Solution to Lab 4

by Dmitry Beresnev <d.beresnev@innopolis.university>

The tasks are done under **Linux Fedora 42**

## Task 1.1: Boot Performance

_Command:_

```bash
systemd-analyze
```

_Output:_

```bash
Startup finished in 8.131s (firmware) + 3.914s (loader) + 1.856s (kernel) + 1.475s (initrd) + 15.123s (userspace) = 30.500s
graphical.target reached after 15.078s in userspace.
```

_Command:_

```bash
systemd-analyze blame
```

_Output:_

<details style="margin-bottom: 1rem;">
  <summary>Click to expand (it is too huge)</summary>

```bash
13.474s plocate-updatedb.service
7.015s docker.service
4.038s NetworkManager-wait-online.service
2.002s sys-module-fuse.device
1.967s dev-ttyS4.device
1.967s sys-devices-pci0000:00-0000:00:1e.0-dw\x2dapb\x2duart.2-dw\x2dapb\x2duart.2:0-dw\x2dapb\x2duart.2:0.0-tty-ttyS4.device
1.961s sys-devices-platform-serial8250-serial8250:0-serial8250:0.1-tty-ttyS1.device
1.961s dev-ttyS1.device
1.961s dev-tpmrm0.device
1.960s sys-devices-LNXSYSTM:00-LNXSYBUS:00-MSFT0101:00-tpmrm-tpmrm0.device
1.960s sys-devices-platform-serial8250-serial8250:0-serial8250:0.2-tty-ttyS2.device
1.960s dev-ttyS2.device
1.960s dev-ttyS0.device
1.960s sys-devices-platform-serial8250-serial8250:0-serial8250:0.0-tty-ttyS0.device
1.958s sys-devices-platform-serial8250-serial8250:0-serial8250:0.3-tty-ttyS3.device
1.958s dev-ttyS3.device
1.934s sys-module-configfs.device
1.837s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2duuid-1c24543e\x2db492\x2d4610\x2d9744\x2d7ca770062d6a.device
1.836s dev-disk-by\x2dpartuuid-d5c08923\x2d7dbe\x2d4815\x2da569\x2d91f78e51d875.device
1.836s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0XB04439\x2dpart10.device
1.836s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0XB04439_1\x2dpart10.device
1.836s dev-disk-by\x2duuid-1c24543e\x2db492\x2d4610\x2d9744\x2d7ca770062d6a.device
1.836s dev-disk-by\x2dlabel-fedora.device
1.836s dev-disk-by\x2ddiskseq-1\x2dpart10.device
1.836s dev-nvme0n1p10.device
1.836s sys-devices-pci0000:00-0000:00:0e.0-pci10000:e0-10000:e0:06.2-10000:e1:00.0-nvme-nvme0-nvme0n1-nvme0n1p10.device
1.836s dev-disk-by\x2did-nvme\x2deui.0025384b41b45b29\x2dpart10.device
1.836s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dlabel-fedora.device
1.836s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartuuid-d5c08923\x2d7dbe\x2d4815\x2da569\x2d91f78e51d875.device
1.836s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart10.device
1.836s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartnum-10.device
1.820s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dlabel-MYASUS.device
1.820s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0XB04439\x2dpart8.device
1.820s dev-disk-by\x2dlabel-MYASUS.device
1.820s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0XB04439_1\x2dpart8.device
1.820s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart8.device
1.820s sys-devices-pci0000:00-0000:00:0e.0-pci10000:e0-10000:e0:06.2-10000:e1:00.0-nvme-nvme0-nvme0n1-nvme0n1p8.device
1.820s dev-disk-by\x2ddiskseq-1\x2dpart8.device
1.820s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartuuid-e78f1a51\x2d756d\x2d4be9\x2d8659\x2deefb3e2313e2.device
1.820s dev-disk-by\x2did-nvme\x2deui.0025384b41b45b29\x2dpart8.device
1.820s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2duuid-C229\x2d2924.device
1.820s dev-disk-by\x2duuid-C229\x2d2924.device
1.820s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartnum-8.device
1.820s dev-disk-by\x2dpartuuid-e78f1a51\x2d756d\x2d4be9\x2d8659\x2deefb3e2313e2.device
1.820s dev-nvme0n1p8.device
1.789s dev-disk-by\x2dpartuuid-c1683f82\x2ddd5b\x2d4e7f\x2daf0d\x2dcfe225cd4d69.device
1.789s dev-disk-by\x2duuid-5A0EC3470EC31B41.device
1.789s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartnum-6.device
1.789s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2duuid-5A0EC3470EC31B41.device
1.789s dev-disk-by\x2did-nvme\x2deui.0025384b41b45b29\x2dpart6.device
1.789s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dlabel-RECOVERY.device
1.789s dev-disk-by\x2dlabel-RECOVERY.device
1.789s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart6.device
1.789s dev-disk-by\x2ddiskseq-1\x2dpart6.device
1.789s dev-nvme0n1p6.device
1.789s sys-devices-pci0000:00-0000:00:0e.0-pci10000:e0-10000:e0:06.2-10000:e1:00.0-nvme-nvme0-nvme0n1-nvme0n1p6.device
1.789s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0XB04439_1\x2dpart6.device
1.789s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0XB04439\x2dpart6.device
1.789s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartuuid-c1683f82\x2ddd5b\x2d4e7f\x2daf0d\x2dcfe225cd4d69.device
1.778s dev-disk-by\x2dlabel-SYSTEM.device
1.778s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart1.device
1.778s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2duuid-62E7\x2d2085.device
1.778s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartnum-1.device
1.778s dev-disk-by\x2did-nvme\x2deui.0025384b41b45b29\x2dpart1.device
1.778s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0XB04439_1\x2dpart1.device
1.778s dev-disk-by\x2ddiskseq-1\x2dpart1.device
1.778s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartlabel-EFI\x5cx20System\x5cx20Partition.device
1.778s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0XB04439\x2dpart1.device
1.778s dev-disk-by\x2dpartuuid-7af0a691\x2d2f1a\x2d4beb\x2dade0\x2d7b91c1a4f5e8.device
1.778s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dlabel-SYSTEM.device
1.778s sys-devices-pci0000:00-0000:00:0e.0-pci10000:e0-10000:e0:06.2-10000:e1:00.0-nvme-nvme0-nvme0n1-nvme0n1p1.device
1.778s dev-disk-by\x2duuid-62E7\x2d2085.device
1.778s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartuuid-7af0a691\x2d2f1a\x2d4beb\x2dade0\x2d7b91c1a4f5e8.device
1.778s dev-disk-by\x2dpartlabel-EFI\x5cx20System\x5cx20Partition.device
1.778s dev-nvme0n1p1.device
1.776s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0XB04439_1\x2dpart7.device
1.776s dev-disk-by\x2duuid-E4C0291AC028F488.device
1.776s dev-disk-by\x2did-nvme\x2deui.0025384b41b45b29\x2dpart7.device
1.776s sys-devices-pci0000:00-0000:00:0e.0-pci10000:e0-10000:e0:06.2-10000:e1:00.0-nvme-nvme0-nvme0n1-nvme0n1p7.device
1.776s dev-disk-by\x2dlabel-RESTORE.device
1.776s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart7.device
1.776s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0XB04439\x2dpart7.device
1.776s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartuuid-2a6ed5af\x2d5f05\x2d4990\x2d9aa1\x2d6bdbffc44661.device
1.776s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2duuid-E4C0291AC028F488.device
1.776s dev-disk-by\x2dpartuuid-2a6ed5af\x2d5f05\x2d4990\x2d9aa1\x2d6bdbffc44661.device
1.776s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartnum-7.device
1.776s dev-disk-by\x2ddiskseq-1\x2dpart7.device
1.776s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dlabel-RESTORE.device
1.776s dev-nvme0n1p7.device
1.763s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0XB04439_1\x2dpart5.device
1.763s dev-disk-by\x2dlabel-Data.device
1.763s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartuuid-c8e13a88\x2d4c0b\x2d4a76\x2d8494\x2d293cce6e9bb8.device
1.763s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartnum-5.device
1.763s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dlabel-Data.device
1.763s dev-disk-by\x2ddiskseq-1\x2dpart5.device
1.763s dev-disk-by\x2dpartuuid-c8e13a88\x2d4c0b\x2d4a76\x2d8494\x2d293cce6e9bb8.device
1.763s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2duuid-01DBACF85FB86AF0.device
1.763s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart5.device
1.763s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0XB04439\x2dpart5.device
1.763s dev-nvme0n1p5.device
1.763s dev-disk-by\x2did-nvme\x2deui.0025384b41b45b29\x2dpart5.device
1.763s dev-disk-by\x2duuid-01DBACF85FB86AF0.device
1.763s sys-devices-pci0000:00-0000:00:0e.0-pci10000:e0-10000:e0:06.2-10000:e1:00.0-nvme-nvme0-nvme0n1-nvme0n1p5.device
1.741s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartlabel-Basic\x5cx20data\x5cx20partition.device
1.740s dev-disk-by\x2dpartuuid-87e7447c\x2d909d\x2d4e0a\x2da43c\x2db665961aa40c.device
1.740s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0XB04439\x2dpart2.device
1.740s dev-nvme0n1p2.device
1.740s sys-devices-pci0000:00-0000:00:0e.0-pci10000:e0-10000:e0:06.2-10000:e1:00.0-nvme-nvme0-nvme0n1-nvme0n1p2.device
1.740s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartuuid-87e7447c\x2d909d\x2d4e0a\x2da43c\x2db665961aa40c.device
1.740s dev-disk-by\x2dpartlabel-Microsoft\x5cx20reserved\x5cx20partition.device
1.740s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0XB04439_1\x2dpart2.device
1.740s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartlabel-Microsoft\x5cx20reserved\x5cx20partition.device
1.740s dev-disk-by\x2ddiskseq-1\x2dpart2.device
1.740s dev-disk-by\x2did-nvme\x2deui.0025384b41b45b29\x2dpart2.device
1.740s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart2.device
1.740s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartnum-2.device
1.736s dev-disk-by\x2dpartlabel-Basic\x5cx20data\x5cx20partition.device
1.719s dev-disk-by\x2duuid-0A94E8B394E8A305.device
1.719s dev-disk-by\x2did-nvme\x2deui.0025384b41b45b29\x2dpart3.device
1.719s dev-disk-by\x2ddiskseq-1\x2dpart3.device
1.719s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartnum-3.device
1.719s dev-disk-by\x2dlabel-OS.device
1.719s sys-devices-pci0000:00-0000:00:0e.0-pci10000:e0-10000:e0:06.2-10000:e1:00.0-nvme-nvme0-nvme0n1-nvme0n1p3.device
1.719s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dlabel-OS.device
1.719s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0XB04439_1\x2dpart3.device
1.719s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0XB04439\x2dpart3.device
1.719s dev-disk-by\x2dpartuuid-600c1753\x2d2db4\x2d4de9\x2d867a\x2dcb91294800b0.device
1.719s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartuuid-600c1753\x2d2db4\x2d4de9\x2d867a\x2dcb91294800b0.device
1.719s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart3.device
1.719s dev-nvme0n1p3.device
1.719s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2duuid-0A94E8B394E8A305.device
1.643s dev-disk-by\x2duuid-ed12663c\x2df1cf\x2d4190\x2d9805\x2d0810fad9ba48.device
1.643s dev-disk-by\x2ddiskseq-1\x2dpart4.device
1.643s dev-disk-by\x2did-nvme\x2deui.0025384b41b45b29\x2dpart4.device
1.643s dev-nvme0n1p4.device
1.643s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0XB04439_1\x2dpart4.device
1.643s dev-disk-by\x2dpartuuid-70198d54\x2d915c\x2d446a\x2dab09\x2d9842631b36ae.device
1.643s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0XB04439\x2dpart4.device
1.643s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartnum-4.device
1.643s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2duuid-ed12663c\x2df1cf\x2d4190\x2d9805\x2d0810fad9ba48.device
1.643s sys-devices-pci0000:00-0000:00:0e.0-pci10000:e0-10000:e0:06.2-10000:e1:00.0-nvme-nvme0-nvme0n1-nvme0n1p4.device
1.643s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartuuid-70198d54\x2d915c\x2d446a\x2dab09\x2d9842631b36ae.device
1.643s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart4.device
1.640s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartnum-9.device
1.640s dev-disk-by\x2ddiskseq-1\x2dpart9.device
1.640s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dlabel-boot.device
1.640s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartuuid-d70aafd4\x2df8af\x2d471a\x2db995\x2d639fe00e970f.device
1.640s sys-devices-pci0000:00-0000:00:0e.0-pci10000:e0-10000:e0:06.2-10000:e1:00.0-nvme-nvme0-nvme0n1-nvme0n1p9.device
1.640s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0XB04439\x2dpart9.device
1.640s dev-nvme0n1p9.device
1.640s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2duuid-631117e2\x2dbae3\x2d4d6a\x2d8e3a\x2d409ccd484a34.device
1.640s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart9.device
1.640s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0XB04439_1\x2dpart9.device
1.640s dev-disk-by\x2dlabel-boot.device
1.640s dev-disk-by\x2duuid-631117e2\x2dbae3\x2d4d6a\x2d8e3a\x2d409ccd484a34.device
1.640s dev-disk-by\x2dpartuuid-d70aafd4\x2df8af\x2d471a\x2db995\x2d639fe00e970f.device
1.640s dev-disk-by\x2did-nvme\x2deui.0025384b41b45b29\x2dpart9.device
1.594s dev-disk-by\x2ddiskseq-1.device
1.594s sys-devices-pci0000:00-0000:00:0e.0-pci10000:e0-10000:e0:06.2-10000:e1:00.0-nvme-nvme0-nvme0n1.device
1.594s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1.device
1.594s dev-nvme0n1.device
1.594s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0XB04439_1.device
1.594s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0XB04439.device
1.594s dev-disk-by\x2did-nvme\x2deui.0025384b41b45b29.device
1.095s NetworkManager.service
1.055s systemd-rfkill.service
1.024s systemd-backlight@leds:asus::kbd_backlight.service
670ms firewalld.service
548ms initrd-switch-root.service
465ms unbound-anchor.service
331ms user@1000.service
251ms upower.service
171ms systemd-resolved.service
168ms tuned-ppd.service
156ms abrtd.service
152ms tuned.service
137ms systemd-journal-flush.service
135ms systemd-tmpfiles-setup.service
127ms systemd-udev-trigger.service
115ms containerd.service
112ms sssd-kcm.service
 98ms ModemManager.service
 91ms systemd-tmpfiles-clean.service
 89ms udisks2.service
 82ms systemd-tmpfiles-setup-dev-early.service
 65ms iio-sensor-proxy.service
 64ms systemd-udevd.service
 63ms var-lib-nfs-rpc_pipefs.mount
 60ms chronyd.service
 59ms polkit.service
 58ms accounts-daemon.service
 56ms systemd-journald.service
 53ms dev-zram0.swap
 50ms systemd-oomd.service
 50ms lvm2-monitor.service
 48ms systemd-logind.service
 47ms avahi-daemon.service
 47ms systemd-hostnamed.service
 46ms rsyslog.service
 43ms bluetooth.service
 43ms uresourced.service
 39ms systemd-update-utmp-runlevel.service
 38ms auditd.service
 36ms systemd-binfmt.service
 35ms plymouth-switch-root.service
 34ms systemd-fsck-root.service
 34ms plymouth-read-write.service
 33ms dev-hugepages.mount
 33ms systemd-random-seed.service
 33ms dev-mqueue.mount
 32ms systemd-tmpfiles-setup-dev.service
 32ms gssproxy.service
 32ms plymouth-quit-wait.service
 32ms sys-kernel-debug.mount
 32ms sys-kernel-tracing.mount
 31ms systemd-userdbd.service
 31ms plymouth-quit.service
 30ms systemd-sysctl.service
 28ms boot.mount
 28ms systemd-fsck@dev-disk-by\x2duuid-62E7\x2d2085.service
 27ms smartd.service
 27ms user-runtime-dir@1000.service
 26ms dbus-broker.service
 25ms dracut-cmdline.service
 24ms cups.service
 24ms docker.socket
 23ms boot-efi.mount
 21ms dracut-pre-udev.service
 21ms modprobe@fuse.service
 21ms audit-rules.service
 20ms dracut-shutdown.service
 20ms switcheroo-control.service
 20ms modprobe@configfs.service
 19ms systemd-homed.service
 19ms initrd-udevadm-cleanup-db.service
 19ms bolt.service
 19ms kmod-static-nodes.service
 18ms initrd-parse-etc.service
 17ms home.mount
 17ms systemd-fsck@dev-disk-by\x2duuid-ed12663c\x2df1cf\x2d4190\x2d9805\x2d0810fad9ba48.service
 16ms rpc-statd-notify.service
 15ms plymouth-start.service
 15ms wpa_supplicant.service
 15ms systemd-zram-setup@zram0.service
 14ms rtkit-daemon.service
 13ms systemd-user-sessions.service
 13ms dracut-pre-pivot.service
 13ms systemd-udev-load-credentials.service
 10ms systemd-network-generator.service
 10ms systemd-modules-load.service
 10ms systemd-remount-fs.service
  9ms systemd-battery-check.service
  8ms initrd-cleanup.service
  8ms systemd-backlight@backlight:intel_backlight.service
  8ms proc-sys-fs-binfmt_misc.mount
  8ms systemd-update-utmp.service
  7ms systemd-vconsole-setup.service
  5ms snapd.socket
  4ms modprobe@drm.service
  4ms sys-fs-fuse-connections.mount
  3ms modprobe@dm_mod.service
  3ms systemd-sysusers.service
  3ms modprobe@efi_pstore.service
  2ms modprobe@loop.service
  2ms tmp.mount
285us systemd-homed-activate.service
```

</details>

_Command:_

```bash
uptime
```

_Output:_

```bash
 00:34:34 up  9:45,  2 users,  load average: 1.12, 1.08, 1.06
```

_Command:_

```bash
w
```

_Output:_

```bash
 00:35:12 up  9:46,  2 users,  load average: 1.52, 1.18, 1.10
USER     TTY        LOGIN@   IDLE   JCPU   PCPU WHAT
dsomni   tty2      14:49    9:46m  0.12s  0.12s /usr/bin/startplasma-wayland
dsomni             14:49   23:18   0.00s  1.93s /usr/lib/systemd/systemd --user
```

**Key Observations:**

- The total boot time is **30.5 seconds** which is quite slow
- A significant portion of the boot time (**8.131s, or about 27%**) is spent in the system's firmware before the operating system even begins to load. This is possibly due to the presence of the boot menue and delay for automatic system selection and booting (I have dual boot with WIndows and Fedora on my laptop)
- The userspace initialization is the longest phase, taking **15.123 seconds**. This is possibly because of I use Fedora KDE with a massive grapohical shell
- The vast majority of the userspace boot time is consumed by just three services: `plocate-updatedb.service` (OS indexing thing), `docker.service` (just Docker service), and `NetworkManager-wait-online.service` (OS network manager).

## Task 1.2: Process Forensics

_Command:_

```bash
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
```

_Output:_

```bash
    PID    PPID CMD                         %MEM %CPU
 102157   88259 /proc/self/exe --type=utili  2.3  6.4
  94666   94665 /app/bin/Telegram            2.2  1.7
  89142   88259 /proc/self/exe --type=utili  2.0  2.6
   2879    2338 /usr/bin/plasmashell --no-r  1.8  2.0
  25082    2338 /opt/google/chrome/chrome    1.7  1.6
```

_Command:_

```bash
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
```

_Output:_

```bash
    PID    PPID CMD                         %MEM %CPU
 102140   88265 /usr/share/code/code --type  1.4 16.1
 117300   25100 /opt/google/chrome/chrome -  1.1 13.8
  88033   25100 /opt/google/chrome/chrome -  1.0  8.7
 102157   88259 /proc/self/exe --type=utili  2.3  6.3
  88297   88262 /usr/share/code/code --type  0.5  4.4
```

**Key Observations:**

- **Top Memory-Consuming Processes:**

  1. **Helper Processes (`/proc/self/exe --type=utili`)**
  2. **Telegram (`/app/bin/Telegram`):** Telegram desktop is using **2.2%** of memory
  3. **KDE Plasma Shell (`/usr/bin/plasmashell --no-r`):** The desktop environment of Fedora KDE is using **1.8%** of memory
  4. **Google Chrome (`/opt/google/chrome/chrome`):** Chrome browser is using **1.7%** of memory

- **Top CPU-Consuming Processes:**

  1. **Visual Studio Code (`/usr/share/code/code --type`):** Two VS Code process is the most CPU-intensive application which uses **16.3%** and **4.4%** of CPU
  2. **Google Chrome (`/opt/google/chrome/chrome -`):** Three Chrome processes are consuming **13.8** and **8.7%** of CPU
  3. **Helper Process (`/proc/self/exe --type=utili`)** uses **4.4%** of CPU

## Task 1.3: Service Dependencies

_Command:_

```bash
systemctl list-dependencies
```

_Output:_

<details style="margin-bottom: 1rem;">
  <summary>Click to expand (it is too huge)</summary>

```bash
default.target
● ├─accounts-daemon.service
● ├─rtkit-daemon.service
● ├─sddm.service
● ├─switcheroo-control.service
○ ├─systemd-update-utmp-runlevel.service
● ├─tuned-ppd.service
● ├─udisks2.service
● ├─upower.service
● └─multi-user.target
●   ├─abrt-journal-core.service
●   ├─abrt-oops.service
○   ├─abrt-vmcore.service
●   ├─abrt-xorg.service
●   ├─abrtd.service
●   ├─AmneziaVPN.service
●   ├─atd.service
○   ├─audit-rules.service
●   ├─auditd.service
●   ├─avahi-daemon.service
●   ├─chronyd.service
●   ├─crond.service
●   ├─cups.path
●   ├─docker.service
●   ├─firewalld.service
○   ├─flatpak-add-fedora-repos.service
○   ├─forticlient.service
●   ├─irqbalance.service
●   ├─keyd.service
○   ├─livesys-late.service
○   ├─livesys.service
●   ├─mcelog.service
○   ├─mdmonitor.service
●   ├─ModemManager.service
●   ├─NetworkManager.service
●   ├─plymouth-quit-wait.service
●   ├─plymouth-quit.service
●   ├─rsyslog.service
●   ├─smartd.service
○   ├─sssd.service
●   ├─systemd-ask-password-wall.path
●   ├─systemd-homed.service
●   ├─systemd-logind.service
●   ├─systemd-oomd.service
○   ├─systemd-update-utmp-runlevel.service
●   ├─systemd-user-sessions.service
●   ├─tuned.service
○   ├─vboxservice.service
○   ├─vmtoolsd.service
●   ├─basic.target
●   │ ├─-.mount
●   │ ├─tmp.mount
●   │ ├─paths.target
●   │ ├─slices.target
●   │ │ ├─-.slice
●   │ │ └─system.slice
●   │ ├─sockets.target
●   │ │ ├─avahi-daemon.socket
●   │ │ ├─cups.socket
●   │ │ ├─dbus.socket
●   │ │ ├─dm-event.socket
●   │ │ ├─iscsid.socket
●   │ │ ├─iscsiuio.socket
●   │ │ ├─pcscd.socket
●   │ │ ├─snapd.socket
●   │ │ ├─sshd-unix-local.socket
●   │ │ ├─sssd-kcm.socket
●   │ │ ├─systemd-bootctl.socket
●   │ │ ├─systemd-coredump.socket
●   │ │ ├─systemd-creds.socket
●   │ │ ├─systemd-hostnamed.socket
●   │ │ ├─systemd-initctl.socket
●   │ │ ├─systemd-journald-audit.socket
●   │ │ ├─systemd-journald-dev-log.socket
●   │ │ ├─systemd-journald.socket
○   │ │ ├─systemd-mountfsd.socket
○   │ │ ├─systemd-nsresourced.socket
○   │ │ ├─systemd-pcrextend.socket
○   │ │ ├─systemd-pcrlock.socket
●   │ │ ├─systemd-sysext.socket
●   │ │ ├─systemd-udevd-control.socket
●   │ │ ├─systemd-udevd-kernel.socket
●   │ │ └─systemd-userdbd.socket
●   │ ├─sysinit.target
●   │ │ ├─dev-hugepages.mount
●   │ │ ├─dev-mqueue.mount
●   │ │ ├─dracut-shutdown.service
○   │ │ ├─iscsi-onboot.service
○   │ │ ├─iscsi-starter.service
●   │ │ ├─kmod-static-nodes.service
○   │ │ ├─ldconfig.service
●   │ │ ├─lvm2-lvmpolld.socket
●   │ │ ├─lvm2-monitor.service
●   │ │ ├─plymouth-read-write.service
●   │ │ ├─plymouth-start.service
●   │ │ ├─proc-sys-fs-binfmt_misc.automount
○   │ │ ├─selinux-autorelabel-mark.service
●   │ │ ├─sys-fs-fuse-connections.mount
●   │ │ ├─sys-kernel-config.mount
●   │ │ ├─sys-kernel-debug.mount
●   │ │ ├─sys-kernel-tracing.mount
○   │ │ ├─systemd-ask-password-console.path
●   │ │ ├─systemd-binfmt.service
○   │ │ ├─systemd-boot-random-seed.service
○   │ │ ├─systemd-confext.service
○   │ │ ├─systemd-firstboot.service
○   │ │ ├─systemd-hibernate-clear.service
○   │ │ ├─systemd-hwdb-update.service
○   │ │ ├─systemd-journal-catalog-update.service
●   │ │ ├─systemd-journal-flush.service
●   │ │ ├─systemd-journald.service
○   │ │ ├─systemd-machine-id-commit.service
●   │ │ ├─systemd-modules-load.service
●   │ │ ├─systemd-network-generator.service
○   │ │ ├─systemd-pcrmachine.service
○   │ │ ├─systemd-pcrphase-sysinit.service
○   │ │ ├─systemd-pcrphase.service
○   │ │ ├─systemd-pstore.service
●   │ │ ├─systemd-random-seed.service
○   │ │ ├─systemd-repart.service
●   │ │ ├─systemd-resolved.service
●   │ │ ├─systemd-sysctl.service
○   │ │ ├─systemd-sysext.service
○   │ │ ├─systemd-sysusers.service
●   │ │ ├─systemd-tmpfiles-setup-dev-early.service
●   │ │ ├─systemd-tmpfiles-setup-dev.service
●   │ │ ├─systemd-tmpfiles-setup.service
○   │ │ ├─systemd-tpm2-setup-early.service
○   │ │ ├─systemd-tpm2-setup.service
●   │ │ ├─systemd-udev-trigger.service
●   │ │ ├─systemd-udevd.service
○   │ │ ├─systemd-update-done.service
●   │ │ ├─systemd-update-utmp.service
●   │ │ ├─cryptsetup.target
●   │ │ ├─integritysetup.target
●   │ │ ├─local-fs.target
●   │ │ │ ├─-.mount
●   │ │ │ ├─boot-efi.mount
●   │ │ │ ├─boot.mount
●   │ │ │ ├─home.mount
●   │ │ │ ├─systemd-remount-fs.service
●   │ │ │ └─tmp.mount
●   │ │ ├─swap.target
●   │ │ │ └─dev-zram0.swap
●   │ │ └─veritysetup.target
●   │ └─timers.target
●   │   ├─fstrim.timer
●   │   ├─logrotate.timer
●   │   ├─plocate-updatedb.timer
●   │   ├─raid-check.timer
●   │   ├─systemd-tmpfiles-clean.timer
●   │   └─unbound-anchor.timer
●   ├─getty.target
○   │ └─getty@tty1.service
●   ├─nfs-client.target
○   │ ├─auth-rpcgss-module.service
●   │ ├─rpc-statd-notify.service
●   │ └─remote-fs-pre.target
●   ├─remote-cryptsetup.target
●   └─remote-fs.target
●     └─nfs-client.target
○       ├─auth-rpcgss-module.service
●       ├─rpc-statd-notify.service
●       └─remote-fs-pre.target
```

</details>

_Command:_

```bash
systemctl list-dependencies multi-user.target
```

_Output:_

<details style="margin-bottom: 1rem;">
  <summary>Click to expand (it is too huge)</summary>

```bash
multi-user.target
● ├─abrt-journal-core.service
● ├─abrt-oops.service
○ ├─abrt-vmcore.service
● ├─abrt-xorg.service
● ├─abrtd.service
● ├─AmneziaVPN.service
● ├─atd.service
○ ├─audit-rules.service
● ├─auditd.service
● ├─avahi-daemon.service
● ├─chronyd.service
● ├─crond.service
● ├─cups.path
● ├─docker.service
● ├─firewalld.service
○ ├─flatpak-add-fedora-repos.service
○ ├─forticlient.service
● ├─irqbalance.service
● ├─keyd.service
○ ├─livesys-late.service
○ ├─livesys.service
● ├─mcelog.service
○ ├─mdmonitor.service
● ├─ModemManager.service
● ├─NetworkManager.service
● ├─plymouth-quit-wait.service
● ├─plymouth-quit.service
● ├─rsyslog.service
● ├─smartd.service
○ ├─sssd.service
● ├─systemd-ask-password-wall.path
● ├─systemd-homed.service
● ├─systemd-logind.service
● ├─systemd-oomd.service
○ ├─systemd-update-utmp-runlevel.service
● ├─systemd-user-sessions.service
● ├─tuned.service
○ ├─vboxservice.service
○ ├─vmtoolsd.service
● ├─basic.target
● │ ├─-.mount
● │ ├─tmp.mount
● │ ├─paths.target
● │ ├─slices.target
● │ │ ├─-.slice
● │ │ └─system.slice
● │ ├─sockets.target
● │ │ ├─avahi-daemon.socket
● │ │ ├─cups.socket
● │ │ ├─dbus.socket
● │ │ ├─dm-event.socket
● │ │ ├─iscsid.socket
● │ │ ├─iscsiuio.socket
● │ │ ├─pcscd.socket
● │ │ ├─snapd.socket
● │ │ ├─sshd-unix-local.socket
● │ │ ├─sssd-kcm.socket
● │ │ ├─systemd-bootctl.socket
● │ │ ├─systemd-coredump.socket
● │ │ ├─systemd-creds.socket
● │ │ ├─systemd-hostnamed.socket
● │ │ ├─systemd-initctl.socket
● │ │ ├─systemd-journald-audit.socket
● │ │ ├─systemd-journald-dev-log.socket
● │ │ ├─systemd-journald.socket
○ │ │ ├─systemd-mountfsd.socket
○ │ │ ├─systemd-nsresourced.socket
○ │ │ ├─systemd-pcrextend.socket
○ │ │ ├─systemd-pcrlock.socket
● │ │ ├─systemd-sysext.socket
● │ │ ├─systemd-udevd-control.socket
● │ │ ├─systemd-udevd-kernel.socket
● │ │ └─systemd-userdbd.socket
● │ ├─sysinit.target
● │ │ ├─dev-hugepages.mount
● │ │ ├─dev-mqueue.mount
● │ │ ├─dracut-shutdown.service
○ │ │ ├─iscsi-onboot.service
○ │ │ ├─iscsi-starter.service
● │ │ ├─kmod-static-nodes.service
○ │ │ ├─ldconfig.service
● │ │ ├─lvm2-lvmpolld.socket
● │ │ ├─lvm2-monitor.service
● │ │ ├─plymouth-read-write.service
● │ │ ├─plymouth-start.service
● │ │ ├─proc-sys-fs-binfmt_misc.automount
○ │ │ ├─selinux-autorelabel-mark.service
● │ │ ├─sys-fs-fuse-connections.mount
● │ │ ├─sys-kernel-config.mount
● │ │ ├─sys-kernel-debug.mount
● │ │ ├─sys-kernel-tracing.mount
○ │ │ ├─systemd-ask-password-console.path
● │ │ ├─systemd-binfmt.service
○ │ │ ├─systemd-boot-random-seed.service
○ │ │ ├─systemd-confext.service
○ │ │ ├─systemd-firstboot.service
○ │ │ ├─systemd-hibernate-clear.service
○ │ │ ├─systemd-hwdb-update.service
○ │ │ ├─systemd-journal-catalog-update.service
● │ │ ├─systemd-journal-flush.service
● │ │ ├─systemd-journald.service
○ │ │ ├─systemd-machine-id-commit.service
● │ │ ├─systemd-modules-load.service
● │ │ ├─systemd-network-generator.service
○ │ │ ├─systemd-pcrmachine.service
○ │ │ ├─systemd-pcrphase-sysinit.service
○ │ │ ├─systemd-pcrphase.service
○ │ │ ├─systemd-pstore.service
● │ │ ├─systemd-random-seed.service
○ │ │ ├─systemd-repart.service
● │ │ ├─systemd-resolved.service
● │ │ ├─systemd-sysctl.service
○ │ │ ├─systemd-sysext.service
○ │ │ ├─systemd-sysusers.service
● │ │ ├─systemd-tmpfiles-setup-dev-early.service
● │ │ ├─systemd-tmpfiles-setup-dev.service
● │ │ ├─systemd-tmpfiles-setup.service
○ │ │ ├─systemd-tpm2-setup-early.service
○ │ │ ├─systemd-tpm2-setup.service
● │ │ ├─systemd-udev-trigger.service
● │ │ ├─systemd-udevd.service
○ │ │ ├─systemd-update-done.service
● │ │ ├─systemd-update-utmp.service
● │ │ ├─cryptsetup.target
● │ │ ├─integritysetup.target
● │ │ ├─local-fs.target
● │ │ │ ├─-.mount
● │ │ │ ├─boot-efi.mount
● │ │ │ ├─boot.mount
● │ │ │ ├─home.mount
● │ │ │ ├─systemd-remount-fs.service
● │ │ │ └─tmp.mount
● │ │ ├─swap.target
● │ │ │ └─dev-zram0.swap
● │ │ └─veritysetup.target
● │ └─timers.target
● │   ├─fstrim.timer
● │   ├─logrotate.timer
● │   ├─plocate-updatedb.timer
● │   ├─raid-check.timer
● │   ├─systemd-tmpfiles-clean.timer
● │   └─unbound-anchor.timer
● ├─getty.target
○ │ └─getty@tty1.service
● ├─nfs-client.target
○ │ ├─auth-rpcgss-module.service
● │ ├─rpc-statd-notify.service
● │ └─remote-fs-pre.target
● ├─remote-cryptsetup.target
● └─remote-fs.target
●   └─nfs-client.target
○     ├─auth-rpcgss-module.service
●     ├─rpc-statd-notify.service
●     └─remote-fs-pre.target
```

</details>

**Key Observations:**

- The boot process is structured in layers. `default.target` requires `multi-user.target`, which in turn requires `basic.target`, which finally requires `sysinit.target`. This ensures that basic system initialization (like mounting filesystems) finishes before multi-user services (like `docker.service`) start\
- The `multi-user.target` pulls in many common daemons, including `docker.service`, `NetworkManager.service`, and `firewalld.service`., which means they are all started as part of the standard non-graphical boot sequence
- Many services are listed but are inactive (marked with empty circle), such as `forticlient.service` (VPN)

## Task 1.4: User Sessions

_Command:_

```bash
who -a
```

_Output:_

```bash
           system boot  2025-06-26 14:48
dsomni   ? seat0        2025-06-26 14:49   ?          2332
dsomni   + tty2         2025-06-26 14:49  old         2332
```

_Command:_

```bash
last -n 5
```

_Output:_

```bash
dsomni   pts/3        :0               Fri Jun 27 00:35 - 00:35  (00:00)
dsomni   pts/2        :0               Fri Jun 27 00:29   still logged in
dsomni   pts/2        :0               Thu Jun 26 15:57 - 17:04  (01:06)
dsomni   pts/1        :0               Thu Jun 26 15:13 - 15:57  (00:43)
dsomni   pts/0        :0               Thu Jun 26 14:49   still logged in

wtmp begins Tue Apr 15 05:35:56 2025

```

**Key Observations:**

- The system was last booted on **June 26 at 14:48**. User `dsomni` (me) logged into a graphical session at **14:49**
- User `dsomni` is currently logged in and has two active terminal sessions: `pts/0` and `pts/2`. The session on `pts/0` has been open on the initial login, while the one on `pts/2` is just a terminal where I run commands

## Task 1.5: Memory Analysis

_Command:_

```bash
free -h
```

_Output:_

```bash
               total        used        free      shared  buff/cache   available
Mem:            30Gi       9.2Gi        10Gi       2.3Gi        13Gi        21Gi
Swap:          8.0Gi          0B       8.0Gi
```

_Command:_

```bash
cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
```

_Output:_

```bash
MemTotal:       32199620 kB
MemAvailable:   22578140 kB
SwapTotal:       8388604 kB
```

**Key Observations:**

- The system has **32 GB** of physical RAM and **8 GB** of swap space
- There is low memory pressure: of the 32 GB of RAM, **22 GB** is available
- Applications are using **9.2 GB** of RAM
- OS is using **13 GB** of RAM for `buff/cache`, so there is heavy caching (which is good)
- The swap space is completely unused
