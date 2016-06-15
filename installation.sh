#!/bin/sh

# add host keys
ssh-keyscan master > /home/vagrant/.ssh/known_hosts
ssh-keyscan execd1 >> /home/vagrant/.ssh/known_hosts
ssh-keyscan execd2 >> /home/vagrant/.ssh/known_hosts
chmod 0600 /home/vagrant/.ssh/known_hosts
chown vagrant /home/vagrant/.ssh/known_hosts

ssh-keyscan master > /root/.ssh/known_hosts
ssh-keyscan execd1 >> /root/.ssh/known_hosts
ssh-keyscan execd2 >> /root/.ssh/known_hosts
chmod 0600 /root/.ssh/known_hosts

# Expected to have the UGE demo tar.gz here in vagrant directory
# if you don't have then download them from http://www.univa.com

# 1.) Extract UGE packages in subdirectory
if [ -d /vagrant/UGE ]; then
   rm -rf /vagrant/UGE
fi
mkdir /vagrant/UGE
cd /vagrant/UGE

# Select which UGE version is going to be installed.
# When the demo tar.gz verion specifed exists (can be 
# downloaded from www.univa.com for free), we take
# them. Otherwise we check if a uge-lx-amd64.tar.gz
# and a uge-common.gar.gz exits. This I use for for
# setting a symlink to a specific version I want
# to install.

#VERSION="8.1.5-demo"
#VERSION="8.3.1p6-demo"
#VERSION="8.3.1p7"
VERSION="8.4.0-demo"

if [ -f ../ge-$VERSION-bin-lx-amd64.tar.gz ]; then
   tar zxvpf ../ge-$VERSION-bin-lx-amd64.tar.gz
   tar zxvpf ../ge-$VERSION-common.tar.gz
elif [ -f ../uge-lx-amd64.tar.gz ]; then
   tar zxvfp ../uge-lx-amd64.tar.gz
   tar zxvfp ../uge-common.tar.gz
else
   echo "NO UGE PACKES FOUND! ABORTING!"
   exit 1
fi

# 2.) Perfom auto installation
echo "Starting auto-installation of Univa Grid Engine"
export TERM=xterm
./inst_sge -m -x -auto ../auto_install_template

# 2.1) Adapt the cluster (/bin/csh is not installed in box)
source /vagrant/UGE/default/common/settings.sh
# change shell to /bin/sh from /bin/csh
qconf -mattr queue shell /bin/sh all.q

# 3.) Change .bashrc of vagrant/root user in order to source UGE environment
echo "source /vagrant/UGE/default/common/settings.sh" >> /home/vagrant/.bashrc
echo "source /vagrant/UGE/default/common/settings.sh" >> /root/.bashrc

# FINISHED
echo "Installation of UGE finished"

# Install gcc
echo Installing GCC
yum install -y gcc

# EPEL package support installation
cd 
wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm 
rpm -ivh epel-release-6-8.noarch.rpm

# GOLANG support 
yum install -y golang

echo "/nfs   192.168.10.0/24(rw,async)" >> /etc/exports
echo "portmap: 192.168.10.0/24" >> /etc/hosts.allow
service nfs restart
service nfs-server restart
ssh execd1 mount /nfs
ssh execd2 mount /nfs

