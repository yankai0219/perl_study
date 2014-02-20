#!/usr/bin/perl
# Description: Perl extension for reading from continously updated files
# Date: 20140219 ERROR: The code cannot be run
use strict;

use File::Tail;

my $line;
my $file = File::Tail->new("/tmp/file_tail.log");
while (defined($line = $file->read)) {
    print "line:$line\n";
}


