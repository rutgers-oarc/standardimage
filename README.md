# standardimage

This repo contains the procedure to automate the creation of a warewulf compute image.

Copy restricted-access files (certs etc.) to the current directory:

rsync -av /somedir/priv/ ./

Then run install.sh, which prepares the chroot, copies files into it and complete the setup from within the chroot.

./install.sh

