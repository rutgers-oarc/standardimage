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
wwmkchroot centos-7.5 $CHROOTHOME
wwvnfs --chroot=$CHROOTHOME
sed -i 's/^hybridpath.*/#\ &\nhybridize\ =\nhybrid\ =/' /etc/warewulf/vnfs/"$CHROOTDIR".conf
echo add protected files
rsync -av ../priv/ ./
rsync -av ./ $CHROOTHOME/root/$WORKDIR/
cp -r $CURRENT $CHROOTHOME/root
chroot $CHROOTHOME /root/$WORKDIR/chrootsetup.sh $WORKDIR
wwvnfs --chroot=$CHROOTHOME
echo done on master

