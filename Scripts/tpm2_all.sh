#!/bin/bash

echo "dependencies for all tpm2 related software"
sudo apt -y update
sudo apt -y install doxygen libglib2.0-dev libdbus-1-dev  automake libtool pkg-config gcc libssl-dev libcurl4-gnutls-dev autoconf-archive   libcmocka0   libcmocka-dev   net-tools   build-essential   git     g++   m4     libgcrypt20-dev    uthash-dev    pandoc python-yaml

echo "tpm2-tss version 2.0.0"
git clone -b 2.0.0 https://github.com/tpm2-software/tpm2-tss.git
cd tpm2-tss
./bootstrap
./configure --with-udevrulesdir=/etc/udev/rules.d --with-udevrulesprefix=70-
make -j5
sudo make install
sudo useradd --system --user-group tss
sudo udevadm control --reload-rules && sudo udevadm trigger
sudo ldconfig
cd ..

echo "tpm2-abrmd versoin 2.0.0"
git clone -b 2.0.0 https://github.com/tpm2-software/tpm2-abrmd.git
cd tpm2-abrmd
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

echo "tpm2-tools master branch"
git clone https://github.com/tpm2-software/tpm2-tools.git
cd tpm2-tools
./bootstrap
make -j5
sudo make install

echo "clear the TPM? -> tpm2_clear -p"
tpm2_clear -p

echo "Takeownership of changeauth"
tpm2_changeauth  -o "str:owner" -e "str:endorse" -l "str:lock"

touch input_data
echo "Hello TPM2 Cryptoworld!" >> input_data

echo "File En/Decrypt"
tpm2_createprimary -a e -g sha256 -G rsa -o primary_ctx -P "str:endorse"
tpm2_create  -g sha256 -G rsa -C primary_ctx -u key_pub -r key_priv
tpm2_loadexternal -a n -u key_pub -o rsaencrypt_key_ctx
tpm2_rsaencrypt -c rsaencrypt_key_ctx -o cipher_data input_data
tpm2_load -C primary_ctx  -u key_pub -r key_priv  -n name -o rsaencrypt_key_ctx
tpm2_rsadecrypt -c rsaencrypt_key_ctx -I cipher_data -o output_data
echo input_data

echo "ECC sign"
tpm2_create  -g sha256 -G ecc -C primary_ctx -u key_pub_ecc -r key_priv_ecc
tpm2_load -C primary_ctx  -u key_pub_ecc  -r key_priv_ecc -n name_ecc -o eccsigning_key_ctx
tpm2_sign -c eccsigning_key_ctx -G sha256 -m input_data  -s signature
tpm2_verifysignature  -c eccsigning_key_ctx -G sha256 -m input_data -s signature -t ticket_data



