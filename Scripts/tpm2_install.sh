#!/bin/bash

echo "dependencies for all tpm2 related software"
sudo apt -y update
sudo apt -y install doxygen libglib2.0-dev libdbus-1-dev automake libtool pkg-config gcc libssl-dev libcurl4-gnutls-dev autoconf-archive libcmocka0 libcmocka-dev net-tools build-essential git g++ m4 libgcrypt20-dev uthash-dev pandoc libusb-1.0-0-dev libjson-c-dev

echo "clone, compile and install the latest tpm2-tss version"
git clone https://github.com/tpm2-software/tpm2-tss.git
cd tpm2-tss
git checkout 4.1.3
./bootstrap
./configure --with-udevrulesdir=/etc/udev/rules.d --with-udevrulesprefix=70-
make -j4
sudo make install
sudo useradd --system --user-group tss
sudo udevadm control --reload-rules && sudo udevadm trigger
sudo ldconfig
cd ..

echo "clone, compile and install the latest tpm2-abrmd version"
git clone https://github.com/tpm2-software/tpm2-abrmd.git
cd tpm2-abrmd
git checkout 3.0.0
./bootstrap
./configure --with-dbuspolicydir=/etc/dbus-1/system.d --with-systemdsystemunitdir=/lib/systemd/system --with-systemdpresetdir=/lib/systemd/system-preset --datarootdir=/usr/share
make -j4
sudo make install

sudo ldconfig
sudo pkill -HUP dbus-daemon
sudo systemctl daemon-reload
sudo systemctl enable tpm2-abrmd.service
sudo systemctl start tpm2-abrmd.service

echo "dbus test"
dbus-send --system --dest=org.freedesktop.DBus --type=method_call --print-reply /org/freedesktop/DBus org.freedesktop.DBus.ListNames

cd ..

echo "clone, compile and install the latest tpm2-tools version"
git clone https://github.com/tpm2-software/tpm2-tools.git
cd tpm2-tools
git checkout 5.7
./bootstrap
./configure
make -j4
sudo make install
