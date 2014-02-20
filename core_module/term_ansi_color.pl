#!/usr/bin/perl
use strict;
use Term::ANSIColor;

print color 'blue';
print "This txt is bold blue\n";
print color 'reset';
print "This txt is normal\n";

print colored("this text is bold blue\n", 'blue');
print "This txt is normal\n";

