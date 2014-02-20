#!/usr/bin/perl
# Description:
#     I do not understand the socketpair 
use strict;
use IO::Handle;
use IO::Select;
use Socket;
# init ipcs

our $LISTEN_PAIR = IO::Handle->new;
our $WATCH_PAIR  = IO::Handle->new;

# create a socketpair 
socketpair($LISTEN_PAIR, $WATCH_PAIR, AF_UNIX, SOCK_STREAM, PF_UNSPEC);

$LISTEN_PAIR->autoflush(1);
$WATCH_PAIR->autoflush(1);

# init process
my @param_yk;
my %proc_hash = ('listen' => [\&listen_proc, \@param_yk],
                 'watch'  => [\&watch_proc, \@param_yk]);

my $pid = fork;
if ($pid == 0) {
    foreach my $one_proc (keys %proc_hash) {
        my $subroutine = $proc_hash{$one_proc}[0];
        my $param_yk = $proc_hash{$one_proc}[1];
        &$subroutine(@$param_yk);
    }
} else {
    waitpid($pid, 0);
}

sub listen_proc {
    print "begin into listen_proc\n";

    sleep(2);
    $WATCH_PAIR->close();    

    my $select_handle = new IO::Select;
    $select_handle->add($LISTEN_PAIR);

    while (1) {
        my @ready_socks = $select_handle->can_read(1);

        if (@ready_socks != 0) {
            my $msg = <$ready_socks[0]>;
            next unless defined($msg);
            chomp $msg;
            if ($msg) {
                print STDOUT "listen_pro:$msg\n";
            }
        }
    }



    print $LISTEN_PAIR, "Listen_proc ListenPair from Listen_proc pid:$$\n";
    print 'listen_proc\n';
}
sub watch_proc {
    print "begin into watch_proc\n";
    
    close $LISTEN_PAIR;
    print STDOUT 'after listen_pair close\n';
    my $select_handle = new IO::Select;
    $select_handle->add($WATCH_PAIR);
    print 'after add watch pair\n';

    while (1) {
        print 'while(1)\n';
        my @ready_socks = $select_handle->can_read(1);

        if (@ready_socks != 0) {
            my $msg = <$ready_socks[0]>;
            next unless defined($msg);
            chomp $msg;
            if ($msg) {
                print STDOUT "listen_pro:$msg\n";
            }
        }
    }
    
    print $WATCH_PAIR "Watch_proc WathcPair from Watch_proc pid:$$\n";
    print 'watch_proc\n';

}
