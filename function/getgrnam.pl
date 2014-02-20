#!/usr/bin/perl
use strict;

my ($name, $passwd, $uid, $gid,
    $quota, $comment, $gcos, $dir, $shell, $expire) = getpwnam("yankai");
print "name:$name, uid:$uid, dir:$dir\n";

my $uid = getpwnam("yankai");
print "uid:$uid\n";

