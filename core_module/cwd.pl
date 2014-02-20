#!/usr/bin/perl
use strict;
use Cwd;
use Cwd qw(abs_path realpath);
# Description: This is the cwd module
# Cwd - get pathname of current working directory


# 1. get directory Without parameter
#    1) getcwd
#    Returns the current working directory
my $cwd = getcwd();
print "current directory:$cwd\n";

#    2) cwd
#    for most systems it is identical to pwd
#    but without the trailing line terminator
$cwd = cwd();
print "current directory:$cwd\n";

# 2. get directory WITH parameter
#    These functions are exported only on request.
#    They each take a single argument and 
#    return the absolute pathname for it. 
#    if no argument is given they'll use the current 
#    working directory

my $bin      = './file_spec.pl';
my $abs_path = abs_path();
print "current directory:$abs_path\n";
my $abs_path = abs_path($bin);
print "$bin directory:$abs_path\n";
my $real_path = realpath($bin);
print "$bin directory:$real_path\n";


# 3. test
our $CUR_DIR = __FILE__;
print "_FILE__:$CUR_DIR\n";
$CUR_DIR =~ s/[^\/]+$//g;
print "match:$CUR_DIR\n";
$CUR_DIR = realpath($CUR_DIR);
print "realpath:$CUR_DIR\n";

