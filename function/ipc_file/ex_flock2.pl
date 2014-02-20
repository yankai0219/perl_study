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
$counter = <FH> || 0;
seek(FH, 0, 0)
    or die "Cannot rewind counterfile:$!";

print FH $counter+1, "\n"
    or die "cannot write counerfile:$!";

truncate(FH, tell(FH))
    or die "cannot truncate:$!";

print "lock succeed";
close(FH);
