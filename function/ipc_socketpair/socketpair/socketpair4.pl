#!/usr/bin/perl
# socketpair.pl 
use warnings;
use strict;
use IO::Handle;
use Socket;

our $PARENT = IO::Handle->new;
our $CHILD  = IO::Handle->new;

socketpair $PARENT, $CHILD, AF_UNIX, SOCK_STREAM, PF_UNSPEC;

my $message = "S";

if (fork) {
    $CHILD->close();

    syswrite $PARENT, "$message \n";
    while (<$PARENT>) {
        chomp;
        print "Parent got: $_ \n";
        syswrite $PARENT, "P$_ \n";
        sleep 1;
    }
} else {
    $PARENT->close();
    while (<$CHILD>) {
        chomp;
        print "Child got : $_ \n";
        syswrite $CHILD, "C$_ \n";
    }
}
