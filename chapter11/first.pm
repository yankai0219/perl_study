package first;
require Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(camel);
#our @EXPORT_OK = qw($weight);
our $VERSION = 1.00;

sub camel {
    print "This is first module--> camel function\n";
}
sub dog {
    print "This is first module--> dog function\n";
}

$weight = 2.0;

