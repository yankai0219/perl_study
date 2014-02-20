#!/usr/bin/perl
use strict;

my $fromchild = "from child";
my $fromparent = "from parent";
my $tochild;
if (open(TO, "|-")) {
    print TO $fromparent;
} else {
    $tochild = <STDIN>;
    print $tochild, "CHILD\n";
    exit;
}


if (open(FROM, "-|")) {
    $fromchild = <FROM>;
    print $fromchild, " PARENT\n";
} else {
    print STDOUT $fromchild;
    exit;
}
