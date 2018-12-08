#!/bin/sh

mkdir lite -p
cp *lite.img lite/
rm *lite.img

sha256sum *.img > $(basename *.img).sha256
md5sum *.img > $(basename *.img).md5
sha512sum *.img > $(basename *.img).sha512

zip letstrust-raspbian-image.zip *raspbian-stretch.img *.sha256 *.md5 *.sha512

sha256sum *.zip > $(basename *.zip .zip).sha256
md5sum *.zip > $(basename *.zip .zip).md5
sha512sum *.zip > $(basename *.zip .zip).sha512

cd lite/

sha256sum *.img > $(basename *.img).sha256
md5sum *.img > $(basename *.img).md5
sha512sum *.img > $(basename *.img).sha512

zip letstrust-raspbian-lite-image.zip *.img *.sha256 *.md5 *.sha512

sha256sum *.zip > $(basename *.zip .zip).sha256
md5sum *.zip > $(basename *.zip .zip).md5
sha512sum *.zip > $(basename *.zip .zip).sha512

echo "delete the image and the source zip" >> logfile.txt
date >> logfile.txt

cd ..

sudo mv letstrust-raspbian-image.* lite/

rename lite new_image

sudo mkdir new_image -p

cd lite/

sudo mv letstrust* ../new_image



