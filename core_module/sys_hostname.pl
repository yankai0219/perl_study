#!/usr/bin/perl

use Sys::Hostname;
$host = &hostname;
print "host:$host\n";
