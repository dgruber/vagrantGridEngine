vagrantGridEngine
=================

Automatic installation of Grid Engine packages for testing purposes via Vagrant on virtual machines

Here are the prerequisites:
- Having your own laptop / desktop with MacOS X / Linux or Windows (untested) running
- Having free VirtualBox installed 
- Having free Vagrant installed
- Having git version management installed (or alternative you can copy the files from my github account manually)
- Having free Grid Engine tar.gz packages (I assume here ge-8.1.5-demo-common.tar.gz and ge-8.1.5-demo-bin-lx-amd64.tar.gz which you can get for free here: http://www.univa.com/resources/univa-grid-engine-trial.php / it also works with Univa Grid Engine 8.2)

Once you have all the files in a own directory (including the ge-8.1.5... packages!)
just run:

    vagrant up

A Vagrant "box" (VM image based on CentOS 6.5 is downloaded from Vagrant repository - but just one time)
is created and 3 virtual machines are created under Virtual Box (master, execd1, execd2).

In order to use your cluster, just type

    vagrant ssh master

The password for user vagrant is always "vagrant".

Then you can do qhost, qstat -f, qsub -b y sleep 120, qstat -j <jobid> etc.

Have fun!

Note that this just a quick hack to get it running and it is not perfect.

Daniel
