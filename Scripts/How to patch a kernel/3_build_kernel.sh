#!/bin/sh
cd tmp
cd linux

echo "build Kernel for Raspi Zero" >> ../../logfile.txt
date >> ../../logfile.txt

echo Raspi 0/0W/1/Mod1
echo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcmrpi_defconfig
KERNEL=kernel
sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcmrpi_defconfig

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

sudo wget https://letstrust.de/uploads/letstrust-tpm-overlay.dts -O arch/arm/boot/dts/overlays/letstrust-tpm-overlay.dts
sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtbs overlays/letstrust-tpm.dtbo -j12

echo "install Kernel for Raspi Zero in the image" >> ../../logfile.txt
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

echo ../../mnt0/ext4/lib/modules/$(grep -o -m 1 "[0-9].[0-9][0-9].[0-9][0-9]" .config)+/build >> ../../logfile.txt

sudo rm ../../mnt0/ext4/lib/modules/$(grep -o -m 1 "[0-9].[0-9][0-9].[0-9][0-9]" .config)+/build
sudo rm ../../mnt1/ext4/lib/modules/$(grep -o -m 1 "[0-9].[0-9][0-9].[0-9][0-9]" .config)+/source

sudo rm ../../mnt1/ext4/lib/modules/$(grep -o -m 1 "[0-9].[0-9][0-9].[0-9][0-9]" .config)+/build
sudo rm ../../mnt0/ext4/lib/modules/$(grep -o -m 1 "[0-9].[0-9][0-9].[0-9][0-9]" .config)+/source


