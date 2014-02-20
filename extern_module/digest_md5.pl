#!/usr/bin/perl
use strict;

use Digest::MD5;

my $md5 = Digest::MD5->new;
$md5->add('foo', 'bar');
my $digest = $md5->hexdigest;

print "Digest is $digest\n";
