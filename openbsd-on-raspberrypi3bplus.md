# OpenBSD on Raspberry Pi 3 B+ (RPI3)
My personal guide which covers the installation of OpenBSD 7.3 on RPI3 over serial console. Disk preparation was carried out on Mac OS X.
### Prerequisities:
- USB-A to USB-C adapter (For MacBook users)
- USB flash drive (intended as the system disk)
- Micro SD card (intended as the installation medium)
- PLX2303HX USB-UART converter (for serial console access, as HDMI isn't functional)
- F-F jumper wires (Reference: RS1943)

#### USB disks and Micro SD instructions for Mac OS X
Before writing into images:
- Use `diskutil list` to identify the correct disk.
- Run `diskutil unmountDisk /dev/diskX` to unmount the disk before writing the image. Replace X with the correct disk number.

#### Update RPI3 firmware
##### Download [RaspiOS](https://downloads.raspberrypi.org/raspios_lite_arm64/images/raspios_lite_arm64-2023-05-03/2023-05-03-raspios-bullseye-arm64-lite.img.xz) and write to USB stick.
```
curl -L "https://downloads.raspberrypi.org/raspios_lite_arm64/images/raspios_lite_arm\
64-2023-05-03/2023-05-03-raspios-bullseye-arm64-lite.img.xz" | xzcat | sudo dd of=/dev\
/rdisk7 bs=1m status=progress conv=fsync
echo "enable_uart=1" >> /Volumes/bootfs/config.txt
echo "username:$(echo 'my_password' | openssl passwd -6 --stdin)" > /Volumes/bootfs/userconf.txt
touch /Volumes/bootfs/ssh
start RPI & ssh to RPI
sudo apt update -y
sudo apt full-upgrade -y
sudo reboot
sudo apt autoremove
sudo rpi-update
```
#### Copy OpenBSD image to Micro SD card.
Find your Micro SD card.
```
diskutil list
diskutil unmountDisk /dev/disk6
sudo dd if=/Users/${USER}/Downloads/install73.img of=/dev/rdisk6 bs=1m status=progress conv=fsync
```
#### Insert Micro SD card into RPI3.
#### Insert USB flash disk into RPI3.
#### Connect USB-UART converter to PC/Mac and join USB-UART with RPI via jumper wires.
 - USB-UART GND --> RPI GND
 - USB-UART TXD --> RPI RXD 
 - USB-UART RXD --> RPI TXD
#### Connect to Serial console.
```screen /dev/tty.usbserial-1410 115200```
#### Turn on RPI3.
#### Install OpenBSD.
- press (S) to access the shell
```
cd /dev && sh MAKEDEV sd1
dd if=/dev/urandom of=/dev/rsd1c bs=1m      # takes long time!
fdisk -iy sd1                               # Writes a default MBR to disk
disklabel -E sd1                            # add new partition of type RAID, quit and save
install                                     # use new disk e.g sd2 during install
```
#### Move installation from USB flash back to Micro SD card.
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
OpenBSD fdisk MBR.[^7]
[^7]: https://man.openbsd.org/fdisk#i
