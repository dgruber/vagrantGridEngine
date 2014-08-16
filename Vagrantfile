# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.synced_folder ".", "/vagrant"

  config.vm.define "execd2" do |execd2|
    execd2.vm.box = "chef/centos-6.5"
    execd2.vm.hostname = "execd2"
    execd2.vm.network "private_network", ip: "192.168.10.101"
    execd2.vm.provision "shell", path: "hostnames.sh"
  end

  config.vm.define "execd1" do |execd1|
    execd1.vm.box = "chef/centos-6.5"
    execd1.vm.hostname = "execd1"
    execd1.vm.network "private_network", ip: "192.168.10.100"
    execd1.vm.provision "shell", path: "hostnames.sh"
  end

  config.vm.define "master" do |master|
    master.vm.box = "chef/centos-6.5"
    master.vm.hostname = "master"
    master.vm.network "private_network", ip: "192.168.10.99"
    master.vm.provision "shell", path: "hostnames.sh"
    master.vm.provision "shell", path: "installation.sh"
  end

  config.vm.provider "virtualbox" do |vb|
     vb.gui = false
     vb.cpus = 4
     vb.customize ["modifyvm", :id, "--memory", "512"]
   end
end
