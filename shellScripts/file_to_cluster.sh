#!/usr/bin/expect
set filen [lindex $argv 0]
set path [lindex $argv 1]
set password "had00prad"
spawn scp -p 2222 $filen root@hadoop-03.csse.rose-hulman.edu:$path
expect " password:"
send "$password\r"
expect "$ "
interact
