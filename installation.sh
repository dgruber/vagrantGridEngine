#!/bin/sh

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
VERSION="8.2.0-demo"

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

