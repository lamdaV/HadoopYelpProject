#!/usr/bin/expect
spawn ssh root@hadoop-03.csse.rose-hulman.edu
expect "password:"
send "had00prad\r"
expect "# "
interact
