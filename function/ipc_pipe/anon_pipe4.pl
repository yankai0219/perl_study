#!/usr/bin/perl
use strict;

print grep {!/^(tcp|udp)/} `netstat -an 2>&1`;
die 'bad netstat' if $?;
