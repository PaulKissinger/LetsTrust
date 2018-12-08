#!/bin/sh
echo "Start" >> logfile.txt
date >> logfile.txt

sudo apt-get install -y -q gcc-arm-linux-gnueabihf
sudo apt-get install -y gddrescue git libncurses5-dev bc rhash

echo "Download the image" >> logfile.txt
date >> logfile.txt


sudo wget https://downloads.raspberrypi.org/raspbian_lite_latest
sudo wget https://downloads.raspberrypi.org/raspbian_latest

echo "Unzip the image" >> logfile.txt
date >> logfile.txt

sudo unzip raspbian_lite_latest
sudo unzip raspbian_latest

sudo rm raspbian_latest
sudo rm raspbian_lite_latest


echo "Mount the image" >> logfile.txt
date >> logfile.txt

sudo losetup /dev/loop8 -P *raspbian-stretch.img

sudo losetup /dev/loop9 -P *raspbian-stretch-lite.img


