#!/bin/sh
# put the path to this file in the starter_method of the queue
# configuration (qconf -mq all.q) if you want to run a job 
# by using runc. Note you need to request a working directory
# for the job -wd where the json container configuration
# resides in
sudo /usr/local/sbin/runc run "$JOB_ID"
