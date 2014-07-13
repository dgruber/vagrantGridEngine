#!/bin/sh

# expected to have the UGE demo tar.gz here in vagrant directory
# if you don't have then download them from www.univa.com

# 1.) Extract UGE packages in subdirectory
if [ -d /vagrant/UGE ]; then
   rm -rf /vagrant/UGE
fi
mkdir /vagrant/UGE
cd /vagrant/UGE
tar zxvpf ../ge-8.1.5-demo-bin-lx-amd64.tar.gz
tar zxvpf ../ge-8.1.5-demo-common.tar.gz

# 2.) Perfom auto installation
echo "Starting auto-installation of Univa Grid Engine"
export TERM=xterm
./inst_sge -m -x -auto ../auto_install_template

# 2.1) Adapt the cluster (/bin/csh is not installed in box)
source UGE/common/settings.sh
# change shell to /bin/sh from /bin/csh
qconf -mattr queue shell /bin/sh all.q

# 3.) Change .bashrc of vagrant/root user in order to source UGE environment
echo "source /vagrant/UGE/default/common/settings.sh" >> /home/vagrant/.bashrc
echo "source /vagrant/UGE/default/common/settings.sh" >> /root/.bashrc

# FINISHED
echo "Installation of UGE finished"

