# LetsTrust
This site collect usefull scripts, links and TPM2 related stuff.
Most relatet to the LetsTrust-TPM module for the Raspberry Pi 

# News 

With Raspbian Stretch Kernel 4.14.85 you'll get the TPM 2.0 support build in! 

Six easy steps to activate your TPM on the Rapsberry Pi:

* Step one:
  * Open a (whatever) term on your Pi.
* Step two:
run a "sudo rpi-update" 
* Step three:
    * open the /boot/config.txt with "sudo nano /boot/config.txt"
    * activate SPI with
       * "dtparam=spi=on"
    * and load the TPM device tree overlay with
       * "dtoverlay=tpm-slb9670"
* Step four:
  * plug your LetsTrust-TPM on the right position and reboot your Raspberry Pi
* Step fife:
  * Open a (whatever) term on your Pi and type "ls /dev/tpm0" and
/dev/tpm0 will appear in yellow letters!
* Step six:
  * Be happy about your success!


# Scripts

* tpm2_all.sh 
  * Installs the dependencies for the tpm2-tss, tpm2-abrmd and tpm2-tools [1].
  * Provide a complete clear of your TPM (line 46 out comment) 
  * Provide a RSA encrypt and RSA decrypt example.
  * Provide an ECC sign example 
 
* How to patch a kernel (folder)
  * Inlcude some scripts to patch your kernel, example for the Raspbian 

* TPM_reset_with_GPIO.sh
  * Reset the LetsTrust TPM with a pintoggle, only for development! 





  [1] https://github.com/tpm2-software  