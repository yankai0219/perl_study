#!/usr/bin/perl 
use strict;

our @test1 = qw(a1 b1 c1 d1);
our @test2 = qw(a2 b2 c2 d2);

foreach (@test1)  {
    foreach local $_(@test2) {
        print $_, "\n";
    }
    print $_, "\n";
}
