#!/usr/bin/perl 
use strict;
# Description: the use of diamond operator <>
#     1. $_: local my our three types, default is our
#     2. in scalar context, $scalar gets one line of file. 
#        In contrast, @array gets all lines of file

my $file_name = "test.txt";
open my $fh, '<', $file_name or die "Cannot open:$!";

print "scalar context\n";
my $line = <$fh>;
print "line:$line\n";

my @lines = <$fh>;
print "array context\n";
foreach (@lines) {
    print $_, "\n";
}


print "get from stdin\n";
while (<>) {
    print $_, "\n";
}
