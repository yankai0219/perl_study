#!/usr/bin/perl

$file = "test";
open (FILE, '>', $file) or die "Fail open $!";
$oldfd = select(FILE);
print "This is sent to $oldfd\n";

print "oldfd: $oldfd\n";


$test = select($oldfd);
print "This is sent to STDOUT\n";
print "test: $test\n";

