#!/bin/sh


if [ ! -e FreeBSD-11.1-RELEASE-amd64-disc1.iso ]
then
	pkg install -y ca_root_nss
	fetch https://download.freebsd.org/ftp/releases/amd64/amd64/ISO-IMAGES/11.1/FreeBSD-11.1-RELEASE-amd64-disc1.iso.xz
	xz -d ./FreeBSD-11.1-RELEASE-amd64-disc1.iso.xz
fi


if [ -e ./FreeBSD-11.1-RELEASE-bhyve64-autoinst.iso ]
then
	rm ./FreeBSD-11.1-RELEASE-bhyve64-autoinst.iso
fi


PATCHED_ISO_DIR=`mktemp -d`
ORIG_ISO_DIR=`mktemp -d`

## mdconfig command from some smartOS guy
mount -t cd9660 /dev/`mdconfig -f FreeBSD-11.1-RELEASE-amd64-disc1.iso` $ORIG_ISO_DIR

rsync -aq $ORIG_ISO_DIR/ $PATCHED_ISO_DIR/

# make modifications
cp ./installerconfig $PATCHED_ISO_DIR/etc/installerconfig
cp ./rc.local $PATCHED_ISO_DIR/etc/rc.local

# create the new ISO.   VOLD_ID is another copypasta from some smartOS guy
VOL_ID=$(isoinfo -d -i FreeBSD-11.1-RELEASE-amd64-disc1.iso | grep "Volume id" | awk '{print $3}')
mkisofs -J -R -no-emul-boot -V "$VOL_ID" -b boot/cdboot -o FreeBSD-11.1-RELEASE-bhyve64-autoinst.iso $PATCHED_ISO_DIR

umount $ORIG_ISO_DIR
rm -rf $ORIG_ISO_DIR
rm -rf $PATCHED_ISO_DIR
