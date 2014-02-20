#!/usr/bin/perl
use strict;

open STATUS, "netstat -an 2>/dev/null |"
    or die "cannot fork:$!";

while (<STATUS>) {
    next if /^(tcp|dump)/;
    print;
}

close STATUS or die "bad nestat:$!:$?";



