#!/bin/sh

mkdir -p mnt0
mkdir -p mnt0/fat32
mkdir -p mnt0/ext4
sudo mount /dev/loop8p1 mnt0/fat32
sudo mount /dev/loop8p2 mnt0/ext4

mkdir -p mnt1
mkdir -p mnt1/fat32
mkdir -p mnt1/ext4
sudo mount /dev/loop9p1 mnt1/fat32
sudo mount /dev/loop9p2 mnt1/ext4

echo "create tmpfs" >> logfile.txt
date >> logfile.txt

mkdir -p tmp
sudo mount -t tmpfs tmpfs tmp/
cd tmp

echo "git clone tools" >> ../logfile.txt
date >> ../logfile.txt

git clone https://github.com/raspberrypi/tools
export PATH=$PATH:~/tools

echo "git clone linux" >> ../logfile.txt
date >> ../logfile.txt

git clone --depth=1 https://github.com/raspberrypi/linux


