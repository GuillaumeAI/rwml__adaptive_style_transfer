#!/bin/bash

echo 'Hehe, pretty much it is like I am doing stuff in this container then it will quit'
ls
echo "---------------------------------------------" >> /app/log-secondservice.log
echo "-------------$0 is starting--------------------------------" >> /app/log-secondservice.log
sleep 5
echo "Environment: MYVAL=$MYVAL, MYVAL2=$MYVAL2 "  >> /app/log-secondservice.log 
echo "Second service is running $(date)" >> /app/log-secondservice.log 
sleep 55
echo "Second service just shutted down at $(date)" >> /app/log-secondservice.log
