#!/usr/bin/expect
set filen [lindex $argv 0]
set password "had00prad"
spawn ssh root@hadoop-03.csse.rose-hulman.edu
expect "password:"
send "$password\r"
expect "# "
send "hdfs dfs -rm -f $filen \r"
expect "# "
send "exit\r"
interact
