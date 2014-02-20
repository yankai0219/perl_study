#!/usr/bin/perl
use strict;

use WWW::Curl::Easy;
my $curl = new WWW::Curl::Easy;
$curl->setopt(CURLOPT_URL, 'http://oook.de');
$curl->perform;
print 'test';
my $err = $curl->errbuf;
my $info = $curl->getinfo(CURLINFO_HTTP_CODE);

print $info;

