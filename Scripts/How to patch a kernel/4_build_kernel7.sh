#!/bin/sh
cd tmp
cd linux
echo "build Kernel for Raspi Zero" >> ../../logfile.txt
date >> ../../logfile.txt

git clean -f
git reset --hard

echo Raspi 2/3/Mod3

echo "build Kernel for Raspi 2/3b/3b+" >> ../../logfile.txt
date >> ../../logfile.txt
KERNEL=kernel7
sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig

echo "CONFIG_HW_RANDOM_TPM=m
CONFIG_TCG_TPM=m
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS_SPI=m
CONFIG_SECURITYFS=y
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_I2C_ATMEL=n
CONFIG_TCG_TIS_I2C_INFINEON=n
CONFIG_TCG_TIS_I2C_NUVOTON=n
CONFIG_TCG_ATMEL=n
CONFIG_TCG_VTPM_PROXY=n
CONFIG_TCG_TIS_ST33ZP24_I2C=n
CONFIG_TCG_TIS_ST33ZP24_SPI=n
CONFIG_TRUSTED_KEYS=m" >> .config

wget https://letstrust.de/uploads/letstrust-tpm-overlay.dts -O arch/arm/boot/dts/overlays/letstrust-tpm-overlay.dts
sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtbs overlays/letstrust-tpm.dtbo -j12

echo "install Kernel for Raspi 2/3b/3b+ in the image" >> ../../logfile.txt
date >> ../../logfile.txt

sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=../../mnt0/ext4 modules_install
sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=../../mnt1/ext4 modules_install
sudo cp ../../mnt0/fat32/$KERNEL.img ../../mnt0/fat32/$KERNEL-backup.img
sudo cp ../../mnt1/fat32/$KERNEL.img ../../mnt1/fat32/$KERNEL-backup.img
sudo cp arch/arm/boot/zImage ../../mnt0/fat32/$KERNEL.img
sudo cp arch/arm/boot/zImage ../../mnt1/fat32/$KERNEL.img
sudo cp arch/arm/boot/dts/*.dtb ../../mnt0/fat32/
sudo cp arch/arm/boot/dts/*.dtb ../../mnt1/fat32/
sudo cp arch/arm/boot/dts/overlays/*.dtb* ../../mnt0/fat32/overlays/
sudo cp arch/arm/boot/dts/overlays/*.dtb* ../../mnt1/fat32/overlays/
sudo cp arch/arm/boot/dts/overlays/README ../../mnt0/fat32/overlays/
sudo cp arch/arm/boot/dts/overlays/README ../../mnt1/fat32/overlays/

sudo rm ../../mnt0/ext4/lib/modules/$(grep -o -m 1 "[0-9].[0-9][0-9].[0-9][0-9]" .config)-v7+/build
sudo rm ../../mnt1/ext4/lib/modules/$(grep -o -m 1 "[0-9].[0-9][0-9].[0-9][0-9]" .config)-v7+/source

sudo rm ../../mnt1/ext4/lib/modules/$(grep -o -m 1 "[0-9].[0-9][0-9].[0-9][0-9]" .config)-v7+/build
sudo rm ../../mnt0/ext4/lib/modules/$(grep -o -m 1 "[0-9].[0-9][0-9].[0-9][0-9]" .config)-v7+/source


echo add "dtparam=spi=on dtoverlay=letstrust-tpm"
echo "activate SPI over the confic file" >> logfile.txt
date >> logfile.txt

sudo wget https://letstrust.de/uploads/config.txt -O ../../mnt0/fat32/config.txt
sudo wget https://letstrust.de/uploads/config.txt -O ../../mnt1/fat32/config.txt
