#!/usr/bin/perl

# Description:
#     IPC using the way transfer fd 
use Fcntl qw(:DEFAULT :flock);
use POSIX ":sys_wait_h";

open(INPUT, '<', "/etc/fstab")
    or die "/etc/motd:$!";

print 'test';
if ($pid = fork) {
    waitpid($pid, 0);
} else {
    defined($pid)
        or die "fork:$!";
    while (<INPUT>) {
        print "$.:$_";
    }
    exit;
}
