# standardimage

This repo contains the procedure to automate the creation of a warewulf compute image.

First, get a copy of restricted files:

rsync -av /home/babbott/image/priv/ priv/

Then clone repo and run install script.  That script will prepare the chroot, copy files into it and complete the setup from within the chroot.

git clone https://github.com/rutgers-oarc/standardimage
cd standardimage
./install.sh

