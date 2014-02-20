#!/usr/bin/perl

# Description: Server

use IO::Socket::INET;

$listen_queue_size = 10;
$server_port = 12121;
print STDOUT 'test';
$server = IO::Socket::INET->new(LocalPort  => $server_port,
                               Listen     => $listen_queue_size,
                               Reuse      => 1,
                               Type       => SOCK_STREAM)
    or die "Couldn't be a tcp server on port";
while ($socket = $server->accept()) {
    $socket->send("client content from server") 
        or print "connection closed at other end\n";
    $socket->recv($line, 80);
 
    if ($line eq "") {
        print "connection closed at other end\n";
    }
    print "client:$line\n";
    $socket->close;
}

close($server);
