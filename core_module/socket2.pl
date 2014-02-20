#!/usr/bin/perl
use strict;

use Socket;
my $packed_ip = gethostbyname("www.perl.org");
if (defined $packed_ip) {
    my $ip_address = inet_ntoa($packed_ip);
    print "ip:$ip_address\n";
}

