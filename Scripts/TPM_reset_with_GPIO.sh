#!/bin/bash

# Reset the TPM without reboot
# only use for development!

raspi-gpio set 24 op
raspi-gpio set 24 dh
tpm2_getrandom 10
raspi-gpio set 24 dl
tpm2_getrandom 10
sleep 0.1
raspi-gpio set 24 dh
tpm2_getrandom 10
tpm2_startup -c
tpm2_getrandom 10
