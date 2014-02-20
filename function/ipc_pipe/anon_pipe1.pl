#!/usr/bin/perl
use strict;
#open SPOOLER, "| ls -l ~ | grep -v study  "
open SPOOLER, "|-","ls -l ~"
    or die "cannot fork:$!";
local $SIG{PIPE} = sub {die "spooler pipe broke"};

print SPOOLER "stuff\n";
close(SPOOLER) or die "bad pool:$! $?";
