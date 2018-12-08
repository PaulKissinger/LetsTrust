#!/bin/sh

echo "clean all folders, unmont the image and the tmpfs" >> ../../logfile.txt
date >> logfile.txt

sudo umount mnt0/fat32
sudo umount mnt0/ext4
sudo umount mnt1/fat32
sudo umount mnt1/ext4

sudo umount tmp/
sudo losetup -D

sudo rm tmp/ -r -d
sudo rm mnt0/ -r -d
sudo rm mnt1/ -r -d
sudo rm lite/ -r -d
sudo rm *img* -r -d


echo "finished

" >> logfile.txt


