#!/usr/bin/perl
use strict;
# Description: the use of select function

use IO::Handle;
use IO::Select;

our $FH;
my $filename = 'test.txt';
open $FH, '<', $filename;

my $select_handle = new IO::Select;
if (!defined($select_handle) || ($select_handle < 0)) {
    print STDERR "error io::Select\n";
    exit(1);
}

$select_handle->add($FH);

while (1) {
    my @ready_sock = $select_handle->can_read(0);
    if (@ready_sock != 0) {
        my $sock = @ready_sock[0];
        my $msg = <$FH>;
        chomp $msg;
        print "msg:$msg\n";
    }
    $select_handle->remove($FH);
}
