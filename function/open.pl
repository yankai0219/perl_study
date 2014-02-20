#!/usr/bin/perl
use strict;

my $response;
open (my $fileb, ">", \$response);
print $fileb, "hello,world";
print STDOUT $response;
