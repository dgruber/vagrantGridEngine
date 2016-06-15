#!/bin/sh

# Installs Open Container runtime: runc

sudo yum install -y git
sudo yum install -y libseccomp-devel
mkdir -p /vagrant/github.com/opencontainers
cd /vagrant/github.com/opencontainers 
git clone https://github.com/opencontainers/runc
cd runc
make
sudo make install

ssh root@execd1 yum install -y libseccomp-devel
ssh root@execd2 yum install -y libseccomp-devel

scp /usr/local/sbin/runc root@execd1:/usr/local/sbin/runc
scp /usr/local/sbin/runc root@execd2:/usr/local/sbin/runc

# now create an example image
mkdir -p /nfs/busybox/rootfs
cd /nfs/busybox
docker export $(docker create busybox) | tar -C rootfs -xvf -
runc spec
