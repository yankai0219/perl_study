#!/usr/bin/perl
use strict;
# Description: the use of select function

use IO::Handle;
use IO::Select;
use IO::Socket::INET;


my $listen_queue_size = 10;
my $server_port = 12121;
print STDOUT 'test';
my $listensock = IO::Socket::INET->new(LocalPort  => $server_port,
                               Listen     => $listen_queue_size,
                               Reuse      => 1,                                                                           Type       => SOCK_STREAM) 
    or die "Couldn't be a tcp server on port";
if (!defined($listensock)) {
    print STDERR "error listensock\n";
    exit(1);
}

my $select_handle = new IO::Select;
if (!defined($select_handle) || ($select_handle < 0)) {
    print STDERR "error io::Select\n";
    exit(1);
}

$select_handle->add($listensock);

my @ready_socks;
my $fh;
while (1) {
    if (@ready_socks = $select_handle->can_read(0)) {
        foreach $fh (@ready_socks) {
            if ($fh == $listensock) {
                my $new = $listensock->accept;
                $select_handle->add($new);
            } else {
               my $line;
               $fh->recv($line, 89);
               print "client:$line\n";
               
               $select_handle->remove($fh);
               $fh->close;
            }
        }
    }
}
