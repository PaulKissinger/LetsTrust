#!/bin/bash

# Reset the TPM without reboot
# only use for development!

pinctrl set 24 op
pinctrl set 24 dh
tpm2_getrandom 10
pinctrl set 24 dl
tpm2_getrandom 10
sleep 0.1
pinctrl set 24 dh
tpm2_getrandom 10
tpm2_startup -c
tpm2_getrandom 10
