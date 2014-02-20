#!/usr/bin/perl
use strict;
# use Socket qw(SOCK_STREAM getaddrinfo);
use Socket;
my %hints = (socktype => SOCK_STREAM);
my ($err, @res) = getaddrinfo("localhost", "echo", \%hints);
die "Cannot getaddrinfo - $err" if $err;
my $sock;

foreach my $ai (@res) {
    my $candidate = IO::Socket->new();
    $candidate->socket($ai->{family}, $ai->{socktype}, $ai->{protocol})or next;
    $candidate->connect($ai->{addr}) or next;
    $sock = $candidate;
    last;
}
die "Cannot connect to localhost:echo" unless $sock;
$sock->print("Hello, world!\n");
print <$sock>;
