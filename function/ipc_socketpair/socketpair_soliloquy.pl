#!/usr/bin/perl
# Description:
#     1. socketpair is only used to communicate between parent and child process
#     2. waitpid($pid, 0) is not used. if it is used, parent process will be blocked
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

foreach my $one_proc (keys %proc_hash) {
    print "parent pid:$$\n";
    print "key:$one_proc\n";
    my $subroutine = $proc_hash{$one_proc}[0];
    my $param_yk = $proc_hash{$one_proc}[1];
    my $pid = create_process($subroutine, @$param_yk);

    if (!defined($pid)) {
        kill(-9, -$$);
    } else {
        print "child pid: $$\n";
    }
}

sub create_process($func, @args) {
    my ($subroutine, @parameter) = @_;
    
    my $pid = fork;
    if ($pid == 0) {
        print "child pid:$$\n";
        &$subroutine();
        print 'subroutine finish execute\n';
        exit(0);
    } else {
        # waitpid($pid, 0);
        return $pid;
    }
}
sub listen_proc {

    sleep(5);
    print "begin into listen_proc\n";
    $WATCH_PAIR->close();    

    my $select_handle = new IO::Select;
    $select_handle->add($LISTEN_PAIR);
    
    my $count = 0;
    while (1) {
        print STDOUT "listen_proc into while\n";
        my @ready_socks = $select_handle->can_read(1);
        if (@ready_socks != 0) {
            my $msg = <$ready_socks[0]>;
            next unless defined($msg);
            chomp $msg;
            if ($msg) {
                print STDOUT "listen_pro:$msg\n";
            }
        } else {
            print "no can read\n";
        }
        $count++;
        syswrite $LISTEN_PAIR, "$count Listen_proc ListenPair from Listen_proc pid:$$\n";
    }



    print "listen_proc\n";
}
sub watch_proc {
    sleep(2);    
    print "begin into watch_proc\n";
    $LISTEN_PAIR->close();
    print  "after listen_pair close\n";
    my $select_handle = new IO::Select;
    $select_handle->add($WATCH_PAIR);
    print "after add watch pair\n";

    print "watch_proc before print to watch_pair\n";
    print "watch_proc\n";

    my $count = 0;
    while (1) {
        print "watch while(1)\n";
        my @ready_socks = $select_handle->can_read(1);

        if (@ready_socks != 0) {
            my $msg = <$ready_socks[0]>;
            # next unless defined($msg);
            chomp $msg;
            if ($msg) {
                print STDOUT "listen_pro:$msg\n";
            }
        }
        $count++;
        syswrite $WATCH_PAIR, "$count Watch_proc WathcPair from Watch_proc pid:$$\n";
    }
}
