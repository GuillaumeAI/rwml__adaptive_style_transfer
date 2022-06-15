#!/bin/bash
#logfile=$logfile
echo 'Hehe, pretty much it is like I am doing stuff in this container then it will quit'
ls
echo "---------------------------------------------" >> $logfile
echo "-------------$0 is starting--------------------------------" >> $logfile
sleep 5
echo "Environment: MYVAL=$MYVAL, MYVAL2=$MYVAL2 "  >> $logfile
echo "Second service is running $(date)" >> $logfile 
sleep 55
echo "Second service just shutted down at $(date)" >> $logfile
