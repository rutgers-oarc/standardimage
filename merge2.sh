# master
export STARTDIR=`pwd`
export CHROOTHOME=/var/chroots/centos-7.5-vault/
echo STARTDIR is $STARTDIR
echo CHROOTHOME is $CHROOTHOME
WORKDIR="$(basename -- $STARTDIR)"
echo WORKDIR is $WORKDIR
echo starting on master
rm -rf $CHROOTHOME
rm -f /etc/warewulf/vnfs/centos-7.5-vault.conf
wwmkchroot centos-7.5 $CHROOTHOME
wwvnfs --chroot=$CHROOTHOME
sed -i 's/^hybridpath.*/#\ &\nhybridize\ =\nhybrid\ =/' /etc/warewulf/vnfs/centos-7.5-vault.conf
rm -f $CHROOTHOME/etc/yum.repos.d/*
cp CentOS-Base.repo $CHROOTHOME/etc/yum.repos.d
mv $CHROOTHOME/etc/fstab $CHROOTHOME/etc/fstab-orig
cp fstab $CHROOTHOME/etc
yum --installroot=$CHROOTHOME -y -q clean all
rm -rf $CHROOTHOME/var/cache/yum
yum --installroot=$CHROOTHOME -y -q --releasever=7.5.1804 makecache
cp -r $STARTDIR $CHROOTHOME/root
chroot $CHROOTHOME /root/$WORKDIR/merge2.sh $WORKDIR
wwvnfs --chroot=$CHROOTHOME
echo done on master
[root@munin ~]# cat /home/babbott/bill2/merge2.sh 
echo running install in chroot
export WORKDIR=/root/$1
yum -y -q clean all
rm -rf /var/cache/yum
yum -y -q makecache
yum -y -q update
yum -y -q install kernel kernel-devel kernel-headers
yum -y -q groups install core
yum -y -q groups install base
yum -y -q groups install infiniband
yum -y -q groups install performance
yum -y -q groups install hardware-monitoring
yum -y -q groups install development
yum -y -q groups install platform-devel
yum -y -q groups install debugging
yum -y -q groups install perl-runtime
yum -y -q groups install x11
yum -y -q install epel-release
yum -y -q install http://build.openhpc.community/OpenHPC:/1.3/CentOS_7/x86_64/ohpc-release-1.3-1.el7.x86_64.rpm
yum -y -q clean all
yum -y -q update
yum -y -q groups install xfce
yum -y -q install fio iperf3 telnet hwloc emacs php-cli net-snmp net-snmp-utils
yum -y -q install fftw fftw-devel numpy netcdf gnuplot
yum -y -q install agg autofs bonnie++ bzip2-devel cmake
yum -y -q install collectl dos2unix firefox glibc-static hddtemp hdparm
yum -y -q install infiniband-diags-devel iptraf-ng zsh lldpd mutt msr-tools
yum -y -q install scipy sqlite-devel sysfsutils
yum -y -q install whois xorg-x11-apps xterm zlib-static
yum -y -q install edac-utils eigen3-devel gdisk GraphicsMagick-perl gsl gsl-devel gvfs gvfs-client jasper-devel mozjs24 nodejs npm numactl-devel p7zip pigz poppler-cpp poppler-cpp-devel poppler-devel rdma-core-devel readline-devel samba-libs samba-common-tools samba-devel squashfs-tools tbb-devel tcl-devel tix tk-devel tkinter tmux valgrind-devel vte
yum -y -q install libarchive-devel libcurl-devel libssh2-devel libtiff-devel libusb libverto-tevent libXdmcp-devel libXevie
yum -y -q install pcp-doc pcp-export-pcp2graphite pcp-pmda-activemq pcp-pmda-apache pcp-pmda-bash pcp-pmda-bonding pcp-pmda-cisco pcp-pmda-dbping pcp-pmda-dm pcp-pmda-ds389 pcp-pmda-ds389log pcp-pmda-elasticsearch pcp-pmda-gfs2 pcp-pmda-gluster pcp-pmda-gpfs pcp-pmda-gpsd pcp-pmda-json pcp-pmda-kvm pcp-pmda-lmsensors pcp-pmda-logger pcp-pmda-lustre pcp-pmda-lustrecomm pcp-pmda-mailq pcp-pmda-memcache pcp-pmda-mounts pcp-pmda-mysql pcp-pmda-named pcp-pmda-netfilter pcp-pmda-news pcp-pmda-nfsclient pcp-pmda-nginx pcp-pmda-nvidia-gpu pcp-pmda-pdns pcp-pmda-postfix pcp-pmda-postgresql pcp-pmda-roomtemp pcp-pmda-rpm pcp-pmda-sendmail pcp-pmda-shping pcp-pmda-summary pcp-pmda-trace pcp-pmda-unbound pcp-pmda-weblog pcp-pmda-zswap pcp-system-tools
yum -y -q install perl-BSD-Resource perl-common-sense perl-GD perl-JSON-XS perl-Linux-Pid perl-Readonly perl-Readonly-XS perl-Regexp-Common perl-Term-ReadLine-Gnu perl-Text-CSV perl-Text-Format perl-Types-Serialiser
yum -y -q install pygtk2 python-dateutil python-ldap python-matplotlib
yum -y -q install trafshow iftop
yum -y -q groups install "ohpc-base"
yum -y -q groups install "ohpc-base-compute"
yum -y -q install "ganglia-gmond-ohpc"
yum -y -q install nrpe-ohpc
yum -y -q install nagios-plugins-swap-ohpc nagios-plugins-disk-ohpc nagios-plugins-load-ohpc
yum -y -q install warewulf-cluster-node-ohpc
yum -y -q install nhc-ohpc
yum -y -q install mesa-private-llvm
yum -y -q install sssd openldap-clients
yum -y -q install ksh
yum -y -q install /$WORKDIR/gpfs/gpfs*.rpm
sed -i s/SELINUX=enforcing/SELINUX=permissive/ /etc/selinux/config
mkdir /etc/openldap/cacerts
cp /$WORKDIR/ldap_hpc_rutgers_edu_interm.cer /etc/openldap/cacerts/
authconfig --updateall --enableldap --enableldapauth --ldapserver=ldap://ldap.hpc.rutgers.edu:389 --ldapbasedn=dc=hpc,dc=rutgers,dc=edu --enableldaptls --enableldapstarttls
cacertdir_rehash /etc/openldap/cacerts/
cp -r /$WORKDIR/gpfs.service.d/ /etc/systemd/system/
cp -r /$WORKDIR/sssd.service.d/ /etc/systemd/system/
cp -r /$WORKDIR/slurmd.service.d /etc/systemd/system/
cp -r /$WORKDIR/remote-fs.target.d/ /etc/systemd/system/
cp -r /$WORKDIR/sysstat.service.d/ /etc/systemd/system/
rmdir /home/
ln -s /cache/home /home
ln -s /cache/projects /projects
ln -s /cache/sw /opt/sw
cp /$WORKDIR/resolv.conf /etc/
yum -y -q install pmix-ohpc ohpc-filesystem munge-ohpc
yum -y -q install /root/bill/slurm/*.rpm
chown -R 150:150 /etc/slurm/
chown -R 150:150 /var/log/slurm_jobacct.log
chown -R 150:150 /var/spool/slurm
chown -R 996:993 /etc/munge
chown -R 996:993 /var/lib/munge
chown -R 996:993 /var/log/munge
mkdir /var/log/slurm
chown -R 150:150 /var/log/slurm/
mkdir -p /var/lib/slurm/slurmd
mkdir -p /var/lib/slurm/slurmctld
chown -R 150:150 /var/lib/slurm
ln -s /opt/sw/admin/lmod/lmod/init/cshrc /etc/profile.d/modules.csh
ln -s /opt/sw/admin/lmod/lmod/init/profile /etc/profile.d/modules.sh
rm -f /etc/profile.d/lmod*
yum -y -q install /$WORKDIR/StarNetFastX2-2.4.16.rhel6.x86_64.rpm
/usr/lib/fastx2/install.sh --quiet
mkdir /usr/lib/fastx2/var/tmp
mkdir /usr/lib/fastx2/var/uploads
cp /$WORKDIR/fastx/certs/* /usr/lib/fastx2/var/certs
cp /$WORKDIR/fastx/config/* /usr/lib/fastx2/var/config
chown -R 983:982 /usr/lib/fastx2
yum -y -q install https://yum.puppet.com/puppet6/puppet6-release-el-7.noarch.rpm
yum -y -q install puppet-agent
cp /$WORKDIR/snmpd.conf /etc/snmp
sed -i s/daemon\ =\ 1/daemon\ =\ 0/ /etc/tuned/tuned-main.conf
systemctl enable snmpd
systemctl enable lldpd
systemctl disable abrtd
systemctl disable gdm
systemctl disable irqbalance
systemctl disable lvm2-lvmetad
systemctl disable firewalld
systemctl disable ipmievd
systemctl disable rpcbind
tuned-adm profile throughput-performance
yum -y -q install https://downloads.rclone.org/v1.46/rclone-v1.46-linux-amd64.rpm
echo done in chroot

