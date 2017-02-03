#!/usr/bin/expect
set filen [lindex $argv 0]
set path [lindex $argv 1]
set password "had00prad"
spawn scp -p 2222 $filen root@hadoop-03.csse.rose-hulman.edu:
expect "password:"
send "$password\r"
expect "$ "
spawn basename $filen
expect "$ "
set name $expect_out(buffer)
set fname [string trim $name]
spawn ssh root@hadoop-03.csse.rose-hulman.edu
expect "password:"
send "$password\r"
expect "# "
send "hdfs dfs -put $fname $path \r"
expect "# "
send "exit\r"
interact
