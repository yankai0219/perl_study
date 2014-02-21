#!/usr/bin/perl
# Description: net client 

use Socket;
use strict;

# my $remote_host = "10.16.27.186";
my $remote_host = "127.0.0.1";
my $remote_port = 12121;
socket(Server, PF_INET, SOCK_STREAM, getprotobyname('tcp'));

my $internet_addr = inet_aton($remote_host)
    or die "Couldn't convert $remote_host into ip:$!";

my $ipaddr = sockaddr_in($remote_port, $internet_addr);

# connect
connect(Server, $ipaddr)
    or die "Couldn't connect to $remote_host:$remote_port:$!";

# open command buffer
select((select(Server), $| = 1)[0]); 

# send messages through socket
print Server "why don't u call me anymore?\n";

my $answer = <Server>; # read remote response

close(Server);
