#!/usr/bin/perl
# Description: net client 

use IO::Socket::INET;
use strict;


my $remote_host = "10.16.27.186";
my $remote_port = 12121;
my $socket = IO::Socket::INET->new(PeerAddr => $remote_host,
                                PeerPort => $remote_port,
                                Proto    => "tcp",
                                Type     => SOCK_STREAM)
    or die "Could't connect to $remote_host:$remote_port:$!\n";

print "hello client\n";
print $socket "why don't u call me anymore?\n";

my $answer = <$socket>; # read remote response
print $answer;
close($socket);
