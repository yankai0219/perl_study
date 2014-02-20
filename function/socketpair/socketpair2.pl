#!/usr/bin/perl -w
# pipe2 - bidirectional communication using socketpair
#   "the best ones always go both ways"
use Socket;
use IO::Handle;  # thousands of lines just for autoflush :-(
# We say AF_UNIX because although *_LOCAL is the
# POSIX 1003.1g form of the constant, many machines
# still don't have it.



our $CHILD = IO::Handle->new;
our $PARENT = IO::Handle->new;
socketpair($CHILD, $PARENT, AF_UNIX, SOCK_STREAM, PF_UNSPEC)
                            ||  die "socketpair: $!";
$CHILD->autoflush(1);
$PARENT->autoflush(1);

if ($pid = fork()) {
    $PARENT->close();
    syswrite $CHILD, "Parent Pid $$ is sending this\n";
    chomp($line = <$CHILD>);
    print "Parent Pid $$ just read this: '$line'\n";
    $CHILD->close();
    waitpid($pid, 0);
} else {
    die "cannot fork: $!" unless defined $pid;
    $CHILD->close();
    print 'child';
    chomp($line = <$PARENT>);
    print "Child Pid $$ just read this: '$line'\n";
    syswrite $PARENT, "Child Pid $$ is sending this\n";
    $PARENT->close();
    exit(0);
}
