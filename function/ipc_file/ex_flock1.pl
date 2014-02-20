#!/usr/bin/perl

# Description: the file lock function flock
# flock is the same as man 2 flock in C library
# This is exclusive lock

use Fcntl qw(:DEFAULT :flock);

$filename = 'a';
sysopen(FH, $filename, O_WRONLY | O_CREAT) 
    or die "Cannot open:$!";

flock(FH, LOCK_EX) 
    or die "Cannot lock filename:$!";
truncate(FH, 0);

print "flock Succeed\n";
print FH "flock Succeed\n";


close(FH);
