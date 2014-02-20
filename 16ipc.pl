#!/usr/bin/perl
use strict;
use POSIX ":sys_wait_h";

sub catch_zap {
    my $signame = shift;
    our $shuncks++;
    die "Somebody sent me a SIG$signame!";
   
}

my $shunks = 0;
$SIG{INT} = \&catch_zap;
$SIG{QUIT} = \&catch_zap;
while (1) {

}
