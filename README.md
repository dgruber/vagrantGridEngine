vagrantGridEngine
=================

Automatic installation of Grid Engine packages for testing purposes via Vagrant on virtual machines

Here are the prerequisites:
- Having you own laptop / desktop with MacOS X / Linux (untested) or Windows (untested) running
- Having free VirtualBox installed
- Having free Vagrant installed
- Having git version management installed (or alternative you can copy the files from my github account manually)
- Having free Grid Engine tar.gz packages (I assume here ge-8.1.5-demo-common.tar.gz and ge-8.1.5-demo-bin-lx-amd64.tar.gz which you can get for free here: http://www.univa.com/resources/univa-grid-engine-trial.php)

Once you have all the files in a own directory (including the ge-8.1.5... packages!)
just run:

vagrant up

A Vagrant "box" (VM image based on CentOS 6.5 is downloaded from Vagrant repository - but just one time)
is created and 3 virtual machines are created under Virtual Box (master, execd1, execd2).

In order to use your cluster, just type

vagrant ssh master

Then you can do qhost, qstat -f, qsub -b y sleep 120, qstat -j <jobid> etc.

Have fun!

Note that I just hacked that together to have it running and it is not perfect.

Daniel
