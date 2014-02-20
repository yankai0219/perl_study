#!/usr/bin/perl
use strict;

if (-t STDOUT) { # only when stdout is terminal
    my $pager = $ENV{PAGER} || 'more';
    open(STDOUT, "| $pager") or die "Cannot fork a pager:$!";
}
END {
    close(STDOUT) or die "Cannot close STDOUT:$!";
}

