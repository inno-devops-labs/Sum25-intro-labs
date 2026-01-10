# Task 1: Operating System Analysis

## 1.1: Boot Performance

### 1.1.1: Analyze System Boot Time
```sh
systemd-analyze
```
```sh
Startup finished in 12.397s (firmware) + 6.468s (loader) + 1.264s (kernel) + 1.970s (initrd) + 7.504s (userspace) = 29.605s 
graphical.target reached after 7.474s in userspace.
```
```sh
systemd-analyze blame
```
```sh
4.295s NetworkManager-wait-online.service
2.464s sys-module-fuse.device
2.413s dev-ttyS4.device
2.413s sys-devices-pci0000:00-0000:00:1e.0-dw\x2dapb\x2duart.2-dw\x2dapb\x2duart.2:0-dw\x2dapb\x2duart.2:0.0->
2.409s sys-devices-platform-serial8250-serial8250:0-serial8250:0.0-tty-ttyS0.device
2.409s dev-ttyS0.device
2.408s sys-devices-LNXSYSTM:00-LNXSYBUS:00-MSFT0101:00-tpmrm-tpmrm0.device
2.408s dev-tpmrm0.device
2.407s sys-devices-platform-serial8250-serial8250:0-serial8250:0.1-tty-ttyS1.device
2.407s dev-ttyS1.device
2.400s dev-ttyS2.device
2.400s sys-devices-platform-serial8250-serial8250:0-serial8250:0.2-tty-ttyS2.device
2.395s sys-devices-platform-serial8250-serial8250:0-serial8250:0.3-tty-ttyS3.device
2.395s dev-ttyS3.device
2.381s sys-module-configfs.device
2.039s dev-disk-by\x2dpartlabel-Basic\x5cx20data\x5cx20partition.device
2.025s sys-devices-pci0000:00-0000:00:0e.0-pci10000:e0-10000:e0:06.2-10000:e1:00.0-nvme-nvme0-nvme0n1-nvme0n1>
2.025s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartuuid-14>
2.025s dev-disk-by\x2ddiskseq-1\x2dpart3.device
2.025s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart3.device
2.025s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartlabel-B>
2.025s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartnum-3.d>
2.025s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0X140318\x2dpart3.device
2.025s dev-disk-by\x2did-nvme\x2deui.0025384141b5646a\x2dpart3.device
2.025s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0X140318_1\x2dpart3.device
2.025s dev-disk-by\x2dpartuuid-147c35c2\x2d73b7\x2d4520\x2dbff4\x2d0dc52830b9a8.device
2.025s dev-nvme0n1p3.device
2.024s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0X140318\x2dpart2.device
2.024s dev-nvme0n1p2.device
2.024s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartuuid-42>
2.024s dev-disk-by\x2ddiskseq-1\x2dpart2.device
2.024s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart2.device
2.024s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0X140318_1\x2dpart2.device
2.024s dev-disk-by\x2dpartlabel-Microsoft\x5cx20reserved\x5cx20partition.device
2.024s dev-disk-by\x2dpartuuid-42bf6fcb\x2d9023\x2d4b92\x2daac0\x2da77d85fb483b.device
2.024s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartnum-2.d>
2.024s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartlabel-M>
2.024s dev-disk-by\x2did-nvme\x2deui.0025384141b5646a\x2dpart2.device
2.024s sys-devices-pci0000:00-0000:00:0e.0-pci10000:e0-10000:e0:06.2-10000:e1:00.0-nvme-nvme0-nvme0n1-nvme0n1>
2.024s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart6.device
2.024s dev-disk-by\x2did-nvme\x2deui.0025384141b5646a\x2dpart6.device
2.024s dev-disk-by\x2duuid-60EE\x2d773D.device
2.024s dev-disk-by\x2ddiskseq-1\x2dpart6.device
2.024s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0X140318_1\x2dpart6.device
2.024s dev-nvme0n1p6.device
2.024s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartuuid-fe>
2.024s dev-disk-by\x2dpartlabel-EFI\x5cx20System\x5cx20Partition.device
2.024s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartlabel-E>
2.024s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2duuid-60EE\x>
2.024s sys-devices-pci0000:00-0000:00:0e.0-pci10000:e0-10000:e0:06.2-10000:e1:00.0-nvme-nvme0-nvme0n1-nvme0n1>
2.024s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartnum-6.d>
2.024s dev-disk-by\x2dpartuuid-fe656474\x2d83a2\x2d4945\x2d8e0c\x2d32576115239c.device
2.024s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0X140318\x2dpart6.device
2.023s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2duuid-F003\x>
2.023s sys-devices-pci0000:00-0000:00:0e.0-pci10000:e0-10000:e0:06.2-10000:e1:00.0-nvme-nvme0-nvme0n1-nvme0n1>
2.023s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart5.device
2.023s dev-disk-by\x2ddiskseq-1\x2dpart5.device
2.023s dev-disk-by\x2dpartuuid-d029894c\x2d3741\x2d4f5a\x2da568\x2d7cb2da95b451.device
2.023s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0X140318\x2dpart5.device
2.023s dev-disk-by\x2duuid-F003\x2d713C.device
2.023s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartnum-5.d>
2.023s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartuuid-d0>
2.023s dev-disk-by\x2dlabel-MYASUS.device
2.023s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0X140318_1\x2dpart5.device
2.023s dev-disk-by\x2did-nvme\x2deui.0025384141b5646a\x2dpart5.device
2.023s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dlabel-MYASU>
2.023s dev-nvme0n1p5.device
2.015s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0X140318_1\x2dpart7.device
2.015s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2duuid-e73f75>
2.015s dev-disk-by\x2duuid-e73f75a4\x2da421\x2d40d1\x2d9282\x2d279f4f3053e3.device
2.015s dev-disk-by\x2did-nvme\x2deui.0025384141b5646a\x2dpart7.device
2.015s dev-disk-by\x2dpartuuid-bcb700a9\x2ddada\x2d49d0\x2daf5f\x2de7a6137e4be8.device
2.015s dev-disk-by\x2ddiskseq-1\x2dpart7.device
2.015s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartnum-7.d>
2.015s sys-devices-pci0000:00-0000:00:0e.0-pci10000:e0-10000:e0:06.2-10000:e1:00.0-nvme-nvme0-nvme0n1-nvme0n1>
2.015s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartuuid-bc>
2.015s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart7.device
2.015s dev-nvme0n1p7.device
2.015s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0X140318\x2dpart7.device
2.009s sys-devices-pci0000:00-0000:00:0e.0-pci10000:e0-10000:e0:06.2-10000:e1:00.0-nvme-nvme0-nvme0n1-nvme0n1>
2.009s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0X140318_1\x2dpart4.device
2.009s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dlabel-RECOV>
2.009s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartnum-4.d>
2.009s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0X140318\x2dpart4.device
2.009s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2duuid-B6F680>
2.009s dev-disk-by\x2dpartuuid-8c97b646\x2db237\x2d43b2\x2da72c\x2d368aedc4417f.device
2.009s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart4.device
2.009s dev-disk-by\x2did-nvme\x2deui.0025384141b5646a\x2dpart4.device
2.009s dev-disk-by\x2duuid-B6F6802EF67FED4D.device
2.009s dev-disk-by\x2ddiskseq-1\x2dpart4.device
2.009s dev-nvme0n1p4.device
2.009s dev-disk-by\x2dlabel-RECOVERY.device
2.009s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartuuid-8c>
2.008s dev-disk-by\x2dlabel-fedora.device
2.008s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0X140318_1\x2dpart8.device
2.008s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartnum-8.d>
2.008s sys-devices-pci0000:00-0000:00:0e.0-pci10000:e0-10000:e0:06.2-10000:e1:00.0-nvme-nvme0-nvme0n1-nvme0n1>
2.008s dev-nvme0n1p8.device
2.008s dev-disk-by\x2ddiskseq-1\x2dpart8.device
2.008s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart8.device
2.008s dev-disk-by\x2duuid-2a42d7a8\x2da0b6\x2d4ecc\x2da082\x2da44ea071bee8.device
2.008s dev-disk-by\x2did-nvme\x2deui.0025384141b5646a\x2dpart8.device
2.008s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartuuid-cb>
2.008s dev-disk-by\x2dpartuuid-cb9d6e53\x2dbbbb\x2d455e\x2d847f\x2da7cbfa4fb0e1.device
2.008s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dlabel-fedor>
2.008s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0X140318\x2dpart8.device
2.008s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2duuid-2a42d7>
2.008s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0X140318.device
2.007s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1.device
2.007s sys-devices-pci0000:00-0000:00:0e.0-pci10000:e0-10000:e0:06.2-10000:e1:00.0-nvme-nvme0-nvme0n1.device
2.007s dev-disk-by\x2did-nvme\x2deui.0025384141b5646a.device
2.007s dev-disk-by\x2ddiskseq-1.device
2.007s dev-nvme0n1.device
2.007s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0X140318_1.device
1.998s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartlabel-E>
1.998s dev-nvme0n1p1.device
1.998s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartuuid-6a>
1.998s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0X140318\x2dpart1.device
1.998s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart1.device
1.998s dev-disk-by\x2ddiskseq-1\x2dpart1.device
1.998s dev-disk-by\x2dpartlabel-EFI\x5cx20system\x5cx20partition.device
1.998s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2duuid-D24C\x>
1.998s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dlabel-SYSTE>
1.998s dev-disk-by\x2did-nvme\x2deui.0025384141b5646a\x2dpart1.device
1.998s dev-disk-by\x2did-nvme\x2dSAMSUNG_MZVL81T0HELB\x2d00BTW_S7HZNX0X140318_1\x2dpart1.device
1.998s dev-disk-by\x2dpath-pci\x2d0000:00:0e.0\x2dpci\x2d10000:e1:00.0\x2dnvme\x2d1\x2dpart-by\x2dpartnum-1.d>
1.998s sys-devices-pci0000:00-0000:00:0e.0-pci10000:e0-10000:e0:06.2-10000:e1:00.0-nvme-nvme0-nvme0n1-nvme0n1>
1.998s dev-disk-by\x2dpartuuid-6a2a5726\x2d46cb\x2d4769\x2db6df\x2d7ecf12ad618c.device
1.998s dev-disk-by\x2dlabel-SYSTEM.device
1.998s dev-disk-by\x2duuid-D24C\x2dBCA1.device
 624ms NetworkManager.service
 602ms initrd-switch-root.service
 312ms var-lib-nfs-rpc_pipefs.mount
 308ms firewalld.service
 294ms user@1000.service
 260ms upower.service
 211ms tuned.service
 189ms tuned-ppd.service
 171ms systemd-journal-flush.service
 165ms abrtd.service
 150ms udisks2.service
 127ms boot-efi.mount
 120ms systemd-tmpfiles-setup.service
 115ms systemd-udev-trigger.service
 115ms iio-sensor-proxy.service
 105ms var-lib-snapd-snap-bare-5.mount
 104ms var-lib-snapd-snap-core22-1981.mount
 103ms var-lib-snapd-snap-core22-2010.mount
 102ms var-lib-snapd-snap-core24-1006.mount
 101ms accounts-daemon.service
 100ms var-lib-snapd-snap-core24-988.mount
  99ms polkit.service
  99ms systemd-resolved.service
  99ms var-lib-snapd-snap-gnome\x2d46\x2d2404-90.mount
  98ms dev-zram0.swap
  97ms var-lib-snapd-snap-gtk\x2dcommon\x2dthemes-1535.mount
  96ms var-lib-snapd-snap-mesa\x2d2404-887.mount
  95ms systemd-vconsole-setup.service
  94ms var-lib-snapd-snap-snapd-24505.mount
  93ms var-lib-snapd-snap-snapd-24718.mount
  91ms var-lib-snapd-snap-telegram\x2ddesktop-6639.mount
  91ms packagekit.service
  89ms var-lib-snapd-snap-telegram\x2ddesktop-6691.mount
  87ms systemd-udevd.service
  86ms var-lib-snapd-snap-yandex\x2dbrowser-4.mount
  84ms systemd-journald.service
  82ms var-lib-snapd-snap-zoom\x2dclient-258.mount
  78ms ModemManager.service
  77ms systemd-tmpfiles-setup-dev-early.service
  71ms chronyd.service
  65ms systemd-logind.service
  63ms systemd-hostnamed.service
  61ms systemd-oomd.service
  53ms lvm2-monitor.service
  51ms rsyslog.service
  49ms proc-sys-fs-binfmt_misc.mount
  48ms bluetooth.service
  47ms dev-hugepages.mount
  46ms dev-mqueue.mount
  45ms sys-kernel-debug.mount
  43ms sys-kernel-tracing.mount
  43ms dracut-cmdline.service
  42ms systemd-tmpfiles-setup-dev.service
  41ms gssproxy.service
  40ms avahi-daemon.service
  39ms dev-disk-by\x2duuid-e73f75a4\x2da421\x2d40d1\x2d9282\x2d279f4f3053e3.swap
  39ms dracut-pre-udev.service
  37ms bolt.service
  35ms smartd.service
  33ms auditd.service
  32ms systemd-fsck@dev-disk-by\x2duuid-60EE\x2d773D.service
  32ms switcheroo-control.service
  31ms systemd-zram-setup@zram0.service
  30ms plymouth-quit-wait.service
  30ms plymouth-quit.service
  29ms initrd-cleanup.service
  29ms dracut-shutdown.service
  28ms systemd-homed.service
  28ms systemd-update-utmp-runlevel.service
  27ms systemd-random-seed.service
  27ms cups.service
  27ms modprobe@loop.service
  26ms dbus-broker.service
  26ms audit-rules.service
  25ms modprobe@dm_mod.service
  25ms modprobe@efi_pstore.service
  25ms rpc-statd-notify.service
  24ms uresourced.service
  24ms dracut-pre-pivot.service
  24ms plymouth-switch-root.service
  23ms rtkit-daemon.service
  23ms user-runtime-dir@1000.service
  22ms systemd-user-sessions.service
  22ms plymouth-read-write.service
  22ms systemd-userdbd.service
  21ms systemd-hibernate-resume.service
  21ms snapd.socket
  20ms wpa_supplicant.service
  19ms plymouth-start.service
  19ms kmod-static-nodes.service
  18ms modprobe@configfs.service
  18ms initrd-udevadm-cleanup-db.service
  17ms modprobe@fuse.service
  16ms systemd-backlight@leds:asus::kbd_backlight.service
  15ms modprobe@drm.service
  14ms systemd-backlight@backlight:intel_backlight.service
  14ms systemd-udev-load-credentials.service
  14ms systemd-modules-load.service
  13ms systemd-sysctl.service
  12ms initrd-parse-etc.service
  12ms systemd-fsck-root.service
  10ms systemd-rfkill.service
   9ms systemd-update-utmp.service
   9ms systemd-remount-fs.service
   9ms systemd-battery-check.service
   8ms home.mount
   7ms tmp.mount
   6ms var.mount
   5ms systemd-sysusers.service
   5ms sys-fs-fuse-connections.mount
  95us systemd-homed-activate.service
```

### 1.1.2: Check System Load:
```sh
uptime
```

```sh
 19:06:52 up 15 min,  2 users,  load average: 1.00, 0.58, 0.40
```

```sh
w
```

```sh
 19:07:11 up 16 min,  2 users,  load average: 0.78, 0.55, 0.40
USER     TTY        LOGIN@   IDLE   JCPU   PCPU WHAT
kiaver   tty2      18:51   16:10   0.11s  0.11s /usr/bin/startplasma-wayland
kiaver             18:51   13:48   0.00s  0.99s /usr/lib/systemd/systemd --user
```

### Observations
Total boot time: 29.605 seconds
- Firmware: 12.397s (41.9% of total)
- Loader: 6.468s (21.9%)
- Kernel: 1.264s (4.3%)
- Initrd: 1.970s (6.7%)
- Userspace: 7.504s (25.3%)

Graphical target reached after 7.474s in userspace

Top slowest services:
- NetworkManager-wait-online.service (4.295s)
- sys-module-fuse.device (2.464s)
- Various tty and serial device initializations (~2.4s each)
- Disk/partition related services (~2.0s each)

There is only one user `kiaver`, for which system is running for 15min. Overall load is very small.

## 1.2: Process Forensics

### 1.2.1: Identify Resource-Intensive Processes

```sh
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
```

```sh
    PID    PPID CMD                         %MEM %CPU
   2824    2328 /usr/bin/plasmashell --no-r  1.4  1.8
   4018    3983 /opt/yandex/browser/yandex_  1.3  5.9
   6595    6533 /usr/share/code/code --type  1.0  9.9
   2615    2596 /usr/bin/kwin_wayland --way  0.7  7.4
   4147    4037 /opt/yandex/browser/yandex_  0.7  0.8
```

```sh
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
```

```sh
    PID    PPID CMD                         %MEM %CPU
   6595    6533 /usr/share/code/code --type  1.0  9.7
   2615    2596 /usr/bin/kwin_wayland --way  0.7  7.4
   4018    3983 /opt/yandex/browser/yandex_  1.3  5.8
   4067    4034 /opt/yandex/browser/yandex_  0.6  4.9
   6567    6530 /usr/share/code/code --type  0.4  3.1
```

### Observations
Top Memory-Consuming Processes:
- plasmashell (1.4% memory)
- yandex_browser (1.3% memory)
- VS Code (1.0% memory)

Top CPU-Consuming Processes:
- VS Code (9.9% CPU)
- kwin_wayland (7.4% CPU)
- yandex_browser (5.9% CPU)

## 1.3: Service Dependencies

### 1.3.1: Map Service Relationships

```sh
systemctl list-dependencies
```

```sh
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
●   ├─firewalld.service
○   ├─flatpak-add-fedora-repos.service
●   ├─irqbalance.service
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
●   ├─var-lib-snapd-snap-bare-5.mount
●   ├─var-lib-snapd-snap-core22-1981.mount
●   ├─var-lib-snapd-snap-core22-2010.mount
●   ├─var-lib-snapd-snap-core24-1006.mount
●   ├─var-lib-snapd-snap-core24-988.mount
●   ├─var-lib-snapd-snap-gnome\x2d46\x2d2404-90.mount
●   ├─var-lib-snapd-snap-gtk\x2dcommon\x2dthemes-1535.mount
●   ├─var-lib-snapd-snap-mesa\x2d2404-887.mount
●   ├─var-lib-snapd-snap-snapd-24505.mount
●   ├─var-lib-snapd-snap-snapd-24718.mount
●   ├─var-lib-snapd-snap-telegram\x2ddesktop-6639.mount
●   ├─var-lib-snapd-snap-telegram\x2ddesktop-6691.mount
●   ├─var-lib-snapd-snap-yandex\x2dbrowser-4.mount
●   ├─var-lib-snapd-snap-zoom\x2dclient-258.mount
○   ├─vboxservice.service
○   ├─vmtoolsd.service
●   ├─basic.target
●   │ ├─-.mount
●   │ ├─tmp.mount
●   │ ├─var.mount
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
○   │ │ ├─fips-crypto-policy-overlay.service
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
○   │ │ ├─systemd-binfmt.service
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
●   │ │ │ ├─home.mount
●   │ │ │ ├─systemd-remount-fs.service
●   │ │ │ ├─tmp.mount
●   │ │ │ └─var.mount
●   │ │ ├─swap.target
●   │ │ │ ├─dev-disk-by\x2duuid-e73f75a4\x2da421\x2d40d1\x2d9282\x2d279f4f3053e3.swap
●   │ │ │ └─dev-zram0.swap
●   │ │ └─veritysetup.target
●   │ └─timers.target
●   │   ├─dnf-makecache.timer
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

```sh
systemctl list-dependencies multi-user.target
```

```sh
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
● ├─firewalld.service
○ ├─flatpak-add-fedora-repos.service
● ├─irqbalance.service
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
● ├─var-lib-snapd-snap-bare-5.mount
● ├─var-lib-snapd-snap-core22-1981.mount
● ├─var-lib-snapd-snap-core22-2010.mount
● ├─var-lib-snapd-snap-core24-1006.mount
● ├─var-lib-snapd-snap-core24-988.mount
● ├─var-lib-snapd-snap-gnome\x2d46\x2d2404-90.mount
● ├─var-lib-snapd-snap-gtk\x2dcommon\x2dthemes-1535.mount
● ├─var-lib-snapd-snap-mesa\x2d2404-887.mount
● ├─var-lib-snapd-snap-snapd-24505.mount
● ├─var-lib-snapd-snap-snapd-24718.mount
● ├─var-lib-snapd-snap-telegram\x2ddesktop-6639.mount
● ├─var-lib-snapd-snap-telegram\x2ddesktop-6691.mount
● ├─var-lib-snapd-snap-yandex\x2dbrowser-4.mount
● ├─var-lib-snapd-snap-zoom\x2dclient-258.mount
○ ├─vboxservice.service
○ ├─vmtoolsd.service
● ├─basic.target
● │ ├─-.mount
● │ ├─tmp.mount
● │ ├─var.mount
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
○ │ │ ├─fips-crypto-policy-overlay.service
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
○ │ │ ├─systemd-binfmt.service
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
● │ │ │ ├─home.mount
● │ │ │ ├─systemd-remount-fs.service
● │ │ │ ├─tmp.mount
● │ │ │ └─var.mount
● │ │ ├─swap.target
● │ │ │ ├─dev-disk-by\x2duuid-e73f75a4\x2da421\x2d40d1\x2d9282\x2d279f4f3053e3.swap
● │ │ │ └─dev-zram0.swap
● │ │ └─veritysetup.target
● │ └─timers.target
● │   ├─dnf-makecache.timer
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

### Observations
Default target depends on multi-user.target which then depends on basic.target

Critical services enabled:
- NetworkManager
- firewalld
- auditd
- chronyd
- systemd-logind

Many snap mounts are active (telegram, zoom, yandex-browser, etc.)

## 1.4: User Sessions

### 1.4.1: Audit Login Activity

```sh
who -a
```

```sh
           system boot  2025-06-26 18:51
kiaver   ? seat0        2025-06-26 18:51   ?          2323
kiaver   + tty2         2025-06-26 18:51 00:24        2323
```

```sh
last -n 5
```

```sh
kiaver   pts/2        :0               Thu Jun 26 18:57   still logged in
kiaver   pts/1        :0               Thu Jun 26 18:53   still logged in
kiaver   pts/0        :0               Thu Jun 26 18:51   still logged in
kiaver   tty2                          Thu Jun 26 18:51   still logged in
reboot   system boot  6.14.9-300.fc42. Thu Jun 26 18:51   still running

wtmp begins Wed May 28 05:34:46 2025
```

### Observations
System booted at 2025-06-26 18:51

Single user (kiaver) logged in:
- On tty2 at 18:51 (graphical session)
- Multiple terminal sessions (pts/0, pts/1, pts/2)

## 1.5: Memory Analysis

### 1.5.1: Inspect Memory Allocation

```sh
free -h
```

```sh
               total        used        free      shared  buff/cache   available
Mem:            30Gi       5.9Gi        21Gi       2.3Gi       5.7Gi        24Gi
Swap:           39Gi          0B        39Gi
```

```sh
cat /proc/meminfo | grep -e MemTotal -e SwapTotal -e MemAvailable
```

```sh
MemTotal:       32197680 kB
MemAvailable:   25955452 kB
SwapTotal:      41943032 kB
```

### Observations

Memory Utilization:
- Total RAM: 30GiB
- - Used: 5.9GiB (19.7%)
- - Free: 21GiB (70%)
- - Available: 24GiB (including cache)
- Swap: 39GiB completely unused

Key Findings:
- The system has lots of free memory (70% of physical RAM free)
- No swap usage indicates no memory pressure

# Task 2: Networking Analysis

## 2.1: Network Path Tracing

### 2.1.1: Traceroute Execution
```sh
traceroute github.com
```
```sh
traceroute to github.com (140.82.114.3), 30 hops max, 60 byte packets
 1  _gateway (192.168.XXX.XXX)  2.425 ms  2.374 ms  2.354 ms
 2  10.XXX.XXX.XXX (10.XXX.XXX.XXX)  5.903 ms  5.883 ms  5.864 ms
 3  10.XXX.XXX.XXX (10.XXX.XXX.XXX)  7.539 ms 10.XXX.XXX.XXX (10.XXX.XXX.XXX)  7.527 ms 10.XXX.XXX.XXX (10.16.242.58)  7.537 ms
 4  10.XXX.XXX.XXX (10.XXX.XXX.XXX)  7.401 ms 10.XXX.XXX.XXX (10.XXX.XXX.XXX)  7.469 ms  7.450 ms
 5  10.XXX.XXX.XXX (10.XXX.XXX.XXX)  7.459 ms * *
 6  188.254.80.81 (188.254.80.81)  7.384 ms 10.16.248.130 (10.16.248.130)  6.328 ms 188.170.164.32 (188.170.164.32)  20.113 ms
 7  188.170.164.32 (188.170.164.32)  20.092 ms 188.254.80.81 (188.254.80.81)  7.263 ms  7.237 ms
 8  * * *
 9  sto-b2-link.ip.twelve99.net (80.239.128.74)  60.073 ms sto-bb2-link.ip.twelve99.net (62.115.140.216)  61.948 ms *
10  kbn-bb6-link.ip.twelve99.net (62.115.139.173)  57.265 ms sto-bb2-link.ip.twelve99.net (62.115.140.216)  61.907 ms *
11  83.169.204.74 (83.169.204.74)  40.592 ms war-b3-link.ip.twelve99.net (195.12.255.204)  54.540 ms *
12  * ash-bb2-link.ip.twelve99.net (62.115.136.201)  142.059 ms  142.039 ms
13  ffm-bb2-link.ip.twelve99.net (62.115.120.20)  57.259 ms prs-bb2-link.ip.twelve99.net (62.115.122.138)  64.141 ms  64.354 ms
14  ash-bb2-link.ip.twelve99.net (62.115.140.107)  147.403 ms  147.232 ms github-ic-368832.ip.twelve99-cust.net (213.248.67.47)  130.544 ms
15  ash-bb2-link.ip.twelve99.net (62.115.140.107)  147.417 ms rest-b2-link.ip.twelve99.net (62.115.121.216)  147.004 ms *
16  * * github-ic-368832.ip.twelve99-cust.net (213.248.67.47)  141.989 ms
17  * * *
18  * * *
19  * * *
20  * * *
21  * * *
22  * * *
23  * * *
24  * * *
25  * * *
26  * * *
27  * * *
28  * * *
29  * * *
30  * * *
```

### Insights
- Path to GitHub shows 14 hops before timing out
- Initial hops traverse private networks (10.XXX.XXX.XXX and 192.168.XXX.XXX)
- Enters public infrastructure at hop 6 (188.254.80.81)
- Traverses Twelve99 backbone network (AS1299) from hop 9
- Final hops show intercontinental routing (Europe to US)

### 2.1.2: DNS Resolution Check
```sh
dig github.com
```

```sh
; <<>> DiG 9.18.36 <<>> github.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 63915
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;github.com.                    IN      A

;; ANSWER SECTION:
github.com.             28      IN      A       140.82.113.3

;; Query time: 13 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Thu Jun 26 19:42:37 MSK 2025
;; MSG SIZE  rcvd: 55
```

### Insights
DNS Query Patterns:
- GitHub resolves to 140.82.113.3 (vs 140.82.114.3 in traceroute)
- Uses local resolver (127.0.0.53) with EDNS support
- Query time: 13ms
- Single A record returned (no round-robin DNS observed)

## 2.2: Packet Capture

### 2.2.1: Capture DNS Traffic

```sh
sudo timeout 10 tcpdump -c 5 -i any 'port 53' -nn
```

```sh
tcpdump: WARNING: any: That device doesn't support promiscuous mode
(Promiscuous mode not supported on the "any" device)
dropped privs to tcpdump
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
19:45:07.730894 wlo1  Out IP 192.168.XXX.1.58747 > 192.168.XXX.XXX.53: 21365+ [1au] AAAA? www.google.ru. (42)
19:45:07.730952 wlo1  Out IP 192.168.XXX.1.55810 > 192.168.XXX.XXX.53: 714+ [1au] A? www.google.ru. (42)
19:45:07.739403 wlo1  Out IP 192.168.XXX.1.32790 > 192.168.XXX.XXX.53: 16444+ [1au] AAAA? favicon.yandex.net. (47)
19:45:07.739453 wlo1  Out IP 192.168.XXX.1.59811 > 192.168.XXX.XXX.53: 41953+ [1au] A? favicon.yandex.net. (47)
19:45:07.741905 wlo1  In  IP 192.168.XXX.XXX.53 > 192.168.XXX.1.55810: 714 1/0/1 A 216.58.207.195 (58)
5 packets captured
8 packets received by filter
0 packets dropped by kernel
```

### Insights
DNS Traffic Patterns:
- All queries use EDNS (extension mechanisms)
- Simultaneous A and AAAA queries observed (IPv4/IPv6 dual-stack)
- Local resolver at 192.168.XXX.1 handling requests

Queries for:
- www.google.ru
- favicon.yandex.net

## 2.3: Reverse DNS

### 2.3.1: Perform PTR Lookups

```sh
dig -x 8.8.4.4
```

```sh
; <<>> DiG 9.18.36 <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 19693
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.          IN      PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.   17113   IN      PTR     dns.google.

;; Query time: 10 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Thu Jun 26 19:50:49 MSK 2025
;; MSG SIZE  rcvd: 73
```

```sh
dig -x 1.1.2.2
```

```sh
; <<>> DiG 9.18.36 <<>> -x 1.1.2.2
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 39392
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;2.2.1.1.in-addr.arpa.          IN      PTR

;; AUTHORITY SECTION:
1.in-addr.arpa.         1287    IN      SOA     ns.apnic.net. read-txt-record-of-zone-first-dns-admin.apnic.net. 22228 7200 1800 604800 3600

;; Query time: 24 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Thu Jun 26 19:51:11 MSK 2025
;; MSG SIZE  rcvd: 137
```

### Insights
8.8.4.4 (Google DNS):
- Correctly resolves to "dns.google"
- TTL: 17113 seconds (~4.75 hours)
- Standard configuration for public DNS service

1.1.2.2 (No PTR):
- Returns NXDOMAIN (non-existent domain)
- SOA record points to ns.apnic.net
- Belongs to APNIC Labs research space

