#!/bin/bash

# Reset the TPM without reboot
# only use for development!

gpio mode 5 out 
gpio write 5 1
tpm2_getrandom 10
gpio write 5 0
tpm2_getrandom 10
sleep 1
gpio write 5 1
tpm2_getrandom 10
tpm2_startup -c
tpm2_getrandom 10
