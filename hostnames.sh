#!/bin/sh

# create execd local spool directory
mkdir -p /UGEexecdspool
chown -R vagrant:vagrant /UGEexecdspool

# configure passwordless ssh
mkdir -p /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
cp /vagrant/id_rsa.pub /home/vagrant/.ssh/
cp /vagrant/id_rsa /home/vagrant/.ssh/
cp /vagrant/known_hosts /home/vagrant/.ssh/known_hosts
cp /vagrant/authorized_keys /home/vagrant/.ssh/
chown -R vagrant:vagrant /home/vagrant/.ssh

mkdir -p /root/.ssh
chmod 700 /root/.ssh
cp /vagrant/id_rsa.pub /root/.ssh/
chmod 644 /root/.ssh/id_rsa.pub
cp /vagrant/id_rsa /root/.ssh/
chmod 600 /root/.ssh/id_rsa
cp /vagrant/known_hosts /root/.ssh/known_hosts
cp /vagrant/authorized_keys /root/.ssh/

# TERM needs to be set for the installer
echo "export TERM=xterm" >> /root/.bashrc
echo "export TERM=xterm" >> /home/vagrant/.bashrc

# install man page command to access UGE man pages
yum install -y man 

# install libnuma.so
yum install -y numactl

# install cgroups (use when UGE version >= 8.1.7p5 is going to be installed)
yum install -y libcgroup
# make it persistent
chkconfig --level 3 cgconfig on
# enable it
service cgconfig start

# configure hosts file
mv /etc/hosts /etc/hosts_orig
echo "192.168.10.99 master" > /etc/hosts
echo "192.168.10.100 execd1" >> /etc/hosts
echo "192.168.10.101 execd2" >> /etc/hosts
echo "127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4" >> /etc/hosts 
echo "::1       localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /etc/hosts

