#!/usr/bin/expect
set jar [lindex $argv 0]
set other [lindex $argv 1]
set password "had00prad"
spawn scp -p 2222 $jar root@hadoop-03.csse.rose-hulman.edu:
expect "password:"
send "$password\r"
expect "$ "
spawn basename $jar
expect "$ "
set name $expect_out(buffer)
set fname [string trim $name]
spawn ssh root@hadoop-03.csse.rose-hulman.edu
expect "password:"
send "$password\r"
expect "# "
send "yarn jar $fname $other \r"
expect "# "
interact
