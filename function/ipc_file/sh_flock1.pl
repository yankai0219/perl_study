#!/usr/bin/perl

# Description: the file lock function flock
# flock is the same as man 2 flock in C library

$filename = 'a';
use Fcntl qw(:DEFAULT :flock);
open(FH, "< $filename") or die "Cannot open:$!";

flock(FH, LOCK_SH | LOCK_NB) or die "Cannot lock filename:$!";
print "flock Succeed\n";
while (<FH>) {
    print $_, "\n";
}
