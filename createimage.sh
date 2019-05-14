# master
export CURRENT=$(pwd)
export WORKDIR=$(basename -- $CURRENT)
export CHROOTDIR=centos-7.5-vault
export CHROOTHOME=/var/chroots/$CHROOTDIR
echo CURRENT is $CURRENT
echo WORKDIR is $WORKDIR
echo CHROOTHOME is $CHROOTHOME
echo CHROOTDIR is $CHROOTDIR
echo starting on master
rm -rf $CHROOTHOME
rm -f /etc/warewulf/vnfs/"$CHROOTDIR".conf
#wwmkchroot centos-7.5 $CHROOTHOME
#wwvnfs --chroot=$CHROOTHOME
#sed -i 's/^hybridpath.*/#\ &\nhybridize\ =\nhybrid\ =/' /etc/warewulf/vnfs/centos-7.5-vault.conf
#rm -f $CHROOTHOME/etc/yum.repos.d/*
#cp CentOS-Base.repo $CHROOTHOME/etc/yum.repos.d
#mv $CHROOTHOME/etc/fstab $CHROOTHOME/etc/fstab-orig
#cp fstab $CHROOTHOME/etc
#yum --installroot=$CHROOTHOME -y -q clean all
#rm -rf $CHROOTHOME/var/cache/yum
#yum --installroot=$CHROOTHOME -y -q --releasever=7.5.1804 makecache
#cp -r $STARTDIR $CHROOTHOME/root
#chroot $CHROOTHOME /root/$WORKDIR/merge2.sh $WORKDIR
#wwvnfs --chroot=$CHROOTHOME
echo done on master

