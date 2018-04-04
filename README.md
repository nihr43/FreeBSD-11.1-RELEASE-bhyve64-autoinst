freebsd-autoinst
======

Entirely self-proficient.  Clone to a fresh freebsd machine, customize the installerconfig, and run ./patch_iso.sh.

Builds FreeBSD-11.1-RELEASE-bhyve64-autoinst.iso with the following proterties

- ssh enabled
- no password
- my pubkey
- a single serial TTY
- auto UFS root disk
- DHCP on vtnet0
- hostname determined by the mac address of vtnet0.  aa:bb:cc:dd:ee:ff becomes host ddeeff


Files
------

installerconfig is the script run at install time.  currently it expects to be inside a basic bhyve VM.  could easily be modified for physical.

rc.local is here because the stock installer requires a user to hit a key to choose serial TTY type when no display is detected.  I hardcoded a value..

patch_iso.sh is the actual magic.  it rips open a stock iso, injects my files, zips it back up, and cleans up after itself
