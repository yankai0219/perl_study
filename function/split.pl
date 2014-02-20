#!/usr/bin/perl

$test = '   hello world';
print $test, "\n";

# 1. split by one or more characters
#    [note] if pattern is empty string '', 
#    empty string may be used to split EXPR into 
#    a list of its component character
#    [note] '' is different from ' '

print "split by ll \n";
@split_arr = split('ll', $test);
foreach (@split_arr) {
    print $_, "\n";
}

print "split by empty string ''\n";
@split_arr = split('', $test);
foreach (@split_arr) {
    print $_, "\n";
}

# 2. if pattern is one whitespace ' ', any leading 
#    whitesapce in EXPR is removed before splitting occurs
#    and the PATTERN is instead tread as if it were /\s+/
print "split by whitespace ' '\n";
@split_arr = split(' ', $test);
foreach (@split_arr) {
    print $_, "\n";
}

print "split by pattern /\\s+/ \n";
@split_arr = split(/\s+/, $test);
foreach (@split_arr) {
    print $_, "\n";
}

# 2. special case for split
#    empty pattern (//) may be used to matches the 
#    empty string, which is contrary to its usual 
#    interpretation as the last successful match
print "split by empty pattern // \n";
@split_arr = split(//, $test);
foreach (@split_arr) {
    print $_, "\n";
}
print "split by pattern /^ / \n";
@split_arr = split(/^/, $test);
foreach (@split_arr) {
    print $_, "\n";
}

$msg = "hello<-!@=x=@!->world";
my $sep = "<-!@=x=@!->";
my ($file, $size) = split($sep, $msg, 2);
print "file:$file, size:$size\n";
