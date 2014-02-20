#!/usr/bin/perl
use JSON;

my $json = JSON->new->utf8;
%hash_data = (a => 'abc',
              b => [3, 4]);

my $json_text = $json->encode(\%hash_data);
print 'json_test', $json_text, "\n";

my $hash_text = $json->decode($json_text);
print "a:$hash_text->{'a'}\n";
