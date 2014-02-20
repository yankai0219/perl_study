#!/usr/bin/perl

# Tutorial on opening things in Perl

# 1. Simple Opens
$file1 = "test1";
$file2 = "test2";

a_open($file1);
b_open($file2);

while (<FD>) {
    print $_, "\n";
}
sub a_open {
    $file1 = shift;
    open FD, '<', $file1 or die "Failed open:$!";
}
sub b_open {
    $file1 = shift;
    open FD, '<', $file1 or die "Failed open:$!";
}

# 2.Pipe Opens
open(PRINTER, "| ls -l ~")    || die "can't run ls: $!";
print PRINTER "stuff\n";
print "output PRINTER";
while (<PRINTER>) {
    print $_, "\n";
}
close(PRINTER)                  || die "can't close lpr: $!";
