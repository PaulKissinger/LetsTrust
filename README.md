# LetsTrust
This site collect usefull scripts, links and TPM2 related stuff.
Most relatet to the LetsTrust-TPM module for the Raspberry Pi 

# News 

With Raspbian Strecht Kernel 4.14.85 you'll get the TPM 2.0 support build in! 

Six easy steps to activate your TPM on the Rapsberry Pi:

* Step one:
  * Open a (whatever) term on your Pi.
* Step two:
run a "sudo rpi-upgrade" 
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
  