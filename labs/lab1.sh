#!/bin/bash

user=$USER
time=`date +%H:%M:%S`
date=`date +%D`
work_dir=`pwd`
process_count=`ps aux | wc -l`
work_time=`uptime -p`

echo "user:   $user
time:	$time
date:	$date
pwd:	$work_dir
ps:	$process_count
work:	$work_time"
                
              
             
         
        
  
