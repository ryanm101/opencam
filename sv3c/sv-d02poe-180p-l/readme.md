# SV-D02POE-1080P-L


## Hardware access:
- Disassemble camera and there are RX/TX pins labeled
- Serial: 115200 8N1
- hold s during poweron to get bootloader access
- execute following commands from bootloader:

```
setenv bootargs 'mem=43M console=ttyAMA0,115200 root=/dev/mtdblock2 rootfstype=squashfs mtdparts=hi_sfc:256K(boot),1664K(kernel),5248K(rootfs),64K(key),960K(config) init=/bin/sh'


bootstart;upgrade;sf probe 0;sf read 0x82000000 0x00040000 0x280000;bootm 0x82000000
```

To start a telnet session execute 

- `cd /etc/init.d`
- `ulimit -s 256`
- `/bin/mount -a`
- `./S00devs`
- `./S01udev`
- `./S04tmpfs`
- `./S80network`
- `ifconfig eth0 192.168.1.5 netmask 255.255.255.0 up`
- `telnetd -p 8357 -l /bin/sh`


### For configs etc

- `sysctl -p`
- `nfspath="10.85.184.62:/home"`
- `MOD_PATH=/komod`
- `#mount tmpfs /tmpfs -t tmpfs -o size=10m`
- `mount -t jffs2 /dev/mtdblock4 /mnt/config`
- `chmod g+s,g-x /dev/mtdblock4`

### /etc/password 
Username is `root`
Password is `cat1029`

## Chips on camera PCB
- [Hi3518](https://cdn.hackaday.io/files/19356828127104/Hi3518%20DataSheet.pdf)
- [FT24C16A](https://datasheet.lcsc.com/lcsc/1811101708_FMD-Fremont-Micro-Devices-FT24C16A-ELR-T_C232875.pdf)
- [MX25L6436F](https://www.macronix.com/Lists/Datasheet/Attachments/7405/MX25L6436F,%203V,%2064Mb,%20v1.2.pdf)
- [RTL8201F](https://www.verical.com/datasheet/realtek-semiconductor-phy-rtl8201f-vb-cg-2635458.pdf)

## Open Ports

|Port|Proto|Process|
|-|-|-|
|80|tcp|http|
|554|tcp|rtsp|
