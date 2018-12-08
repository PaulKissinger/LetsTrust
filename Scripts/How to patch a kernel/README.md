# Example how to patch a Raspbian with TPM kernel driver

These six scripts shows you, how to patch an Image.
With kernel version 4.14.85 in the official Raspbian Image you'll never need this.
If you want to use an other image or another plattform you could use these script as reference. 

* 1_dependencies.sh
 * installs all dependencies
 * download and unzip the raspbian images
* 2_clone_mount.sh
 * clone all necessary repositories and mount the image in a loop device
* 3_build_kernel.sh
 * download the dto and build the new kernel for the raspberry Pi 1 and Zero
* 4_build_kernel7.sh
 * download the dto and build the new kernel7 for the raspberry Pi 2AB/3AB/3AB+
* 5_zip_checksum.sh
 * generates checksums over the image (md5, sha256 and sha512)
 * zip the image
 * generates checksums over the zip-file (md5, sha256 and sha512)
* 6_clean_all.sh
 * unmount the images
 * delete everything you don't need



I hope it is helpfully! 
