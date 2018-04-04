# freebsd-autoinst


Builds FreeBSD-11.1-RELEASE-bhyve64-autoinst.iso with ssh enabled, no password, my pubkey,  a single serial TTY, auto UFS root disk, DHCP on vtnet0, and a hostname determined by the mac address of vtnet0


I saw some traffic on this so i'll explain myself...

just some files to be cloned to a dedicated vm for building my freebsd autoinstaller.

enables single-button building of fresh VMs using vm-bhyve rather than having to clone/image-provision

installerconfig expects to be inside a bhyve vm ... it looks for vtnet0..
  - the hostname is set to the last six of the mac address so vm can be reached thanks to ddns
  - ttys are stripped down to save a tiny bit of ram
  - forces a pkg and freebsd update

rc.local is here because the stock installer requires a user to hit a key to choose serial TTY type.  I hardcoded a value..

patch_iso is the actual magic.  it rips open a stock iso, injects my files, zips it back up, and cleans up after itself
