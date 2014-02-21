#!/usr/bin/perl -w
# pipe2 - bidirectional communication using socketpair
#   "the best ones always go both ways"
use Socket;
use IO::Handle;  # thousands of lines just for autoflush :-(
# We say AF_UNIX because although *_LOCAL is the
# POSIX 1003.1g form of the constant, many machines
# still don't have it.
socketpair(CHILD, PARENT, AF_UNIX, SOCK_STREAM, PF_UNSPEC)
                            ||  die "socketpair: $!";
CHILD->autoflush(1);
PARENT->autoflush(1);

if ($pid = fork()) {
    close CHILD;
    sleep(2);
    print PARENT "Parent Pid $$ is sending this\n";
    chomp($line = <PARENT>);
    print "Parent Pid $$ just read this: '$line'\n";
    waitpid($pid, 0);
} else {
    die "cannot fork: $!" unless defined $pid;
    close PARENT; # close the peer
    print CHILD "Child Pid $$ is sending this\n";
    chomp($line = <CHILD>);
    print "Child Pid $$ just read this: '$line'\n";
    sleep(2);
    exit(0);
}
