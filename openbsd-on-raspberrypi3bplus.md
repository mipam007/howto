# Raspberry Pi 3 B+ (RPI3) OpenBSD installation steps.
This guide covers the installation of OpenBSD 7.3 on Raspberry Pi 3 B+ (RPI3). Preparation was carried out on Mac OS X.
### Prerequisities:
- USB-A to USB-C adapter (For MacBook users)
- USB flash drive (intended as the system disk)
- Micro SD card (intended as the installation medium)
- PLX2303HX USB-UART converter (for serial console access, as HDMI isn't functional)
- F-F jumper wires (Reference: RS1943)
#### Download [OpenBSD ARM64 Image](https://ftp.openbsd.org/pub/OpenBSD/7.3/arm64/install73.img)
#### Copy OpenBSD image to Micro SD card.
Find your Micro SD card.
```
diskutil list
diskutil unmountDisk /dev/disk6
sudo dd if=/Users/${USER}/Downloads/install73.img of=/dev/rdisk6 bs=1m
```
#### Insert Micro SD card into RPI3.
#### Insert USB flash disk into RPI3.
#### Connect USB-UART converter to PC/Mac.
 - USB-UART GND --> RPI GND
 - USB-UART TXD --> RPI RXD 
 - USB-UART RXD --> RPI TXD
#### Connect to Serial console.
```screen /dev/tty.usbserial-1410 115200```
#### Turn on RPI3.
#### Install OpenBSD.
#### Move installation from USB flash to Micro SD card.
```sudo dd if=/dev/rdisk7 of=/dev/rdisk6 bs=1m```
### Sources:
OpenBSD installation manual on ARM64.[^1]
[^1]: https://ftp.openbsd.org/pub/OpenBSD/7.3/arm64/INSTALL.arm64

Get OpenBSD image.[^2]
[^2]: https://ftp.openbsd.org/pub/OpenBSD/7.3/arm64/install73.img

Raspberry Pi GPIO and the 40-pin Header (pinout) manual.[^3]
[^3]: https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#raspberry-pi-3-model-b

One of the possible jumper wires e-shop.[^4]
[^4]: https://www.gme.cz/v/1507928/zyj-w3-f-f-dupont-propojovaci-vodice-zasuvka-zasuvka-40-zil

One of the possible USB-UART adapter.[^5]
[^5]: https://www.gme.cz/v/1508334/prevodnik-usb-uart-s-plx2303hx

One of the possible USB-A to USB-C adapter.[^6]
[^6]: https://www.alza.cz/alzapower-usb-c-m-na-usb-a-3-0-f-d5663799.htm
