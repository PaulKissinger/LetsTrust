# LetsTrust

This site collect usefull scripts, links and TPM2 related stuff.
Most relatet to the LetsTrust-TPM module for the Raspberry Pi.
The latset update of the script installs also the tcti device for the LetsTrust-TPM2Go

# News

1.1 LetsTrust-TPM
With Raspbian Stretch Kernel >= 4.14.85 you'll get the TPM 2.0 support build in!

Six easy steps to activate your TPM on the Rapsberry Pi:

* Step one:
  * Open a (whatever) term on your Pi.
* Step two:
   * run a "sudo apt update && upgrade"
* Step three:
    * open the /boot/config.txt with "sudo nano /boot/config.txt"
    * activate SPI with
       * "dtparam=spi=on"
    * and load the TPM device tree overlay with
       * "dtoverlay=tpm-slb9670"
* Step four:
  * plug your LetsTrust-TPM on the right position and reboot your Raspberry Pi
* Step fife:
  * Open a (whatever) term on your Pi and type "ls /dev/tpm" and
* /dev/tpm0 and /dev/tpmrm0 will appear in yellow letters!
* Step six:
  * Be happy about your success!

1.2 LetsTrust-TPM2Go

The tpm2_all.sh will also install everything for the LetsTrust-TPM2Go.
Futher informations could be found here:
https://github.com/PaulKissinger/LetsTrust-TPM2Go

# Scripts

* tpm2_all.sh
  * Installs the dependencies for tpm2-software [1]
  * Installs tpm2-tss (Tag: 4.1.3)
  * Installs tpm2-abrmd (Tag: 3.0.0)
  * Installs tpm2-tools (Tag: 5.7)

* How to patch a kernel (folder)
  * Inlcude some scripts to patch your kernel, example for Raspbian

* TPM_reset_with_GPIO.sh
  * Reset the LetsTrust-TPM with a pintoggle, only for development!



  [1] https://github.com/tpm2-software
