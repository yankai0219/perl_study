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
    while (1) {
        my @ready_socks = $select_handle->can_read(1);
        if (@ready_socks != 0) {
            foreach my $sock (@ready_socks) {
                if ($sock == $LISTEN_PAIR) {
                    my $msg = <$sock>;
                    chomp $msg;
                    if ($msg) {
                        print STDOUT "listen_pro:$msg\n";
                    }
                }
            }
        } else {
            print STDOUT "listen_proc NO Data\n";
            syswrite $LISTEN_PAIR, "Listen_proc ListenPair from Listen_proc pid:$$\n";
        }
    }

}
sub watch_proc {
    sleep(2);    
    $LISTEN_PAIR->close();
    my $select_handle = new IO::Select;
    $select_handle->add($WATCH_PAIR);

   

    while (1) {
        my @ready_socks = $select_handle->can_read(1);
        syswrite $WATCH_PAIR, "Watch_proc WathcPair from Watch_proc pid:$$\n";

        if (@ready_socks != 0) {
            foreach my $sock (@ready_socks) {
                if ($sock == $WATCH_PAIR) {
                    my $msg = <$sock>;
                    chomp $msg;
                    if ($msg) {
                        print STDOUT "watch_pro:$msg\n";
                    }
                }
            }
        } else {
            syswrite $WATCH_PAIR, "Watch_proc WathcPair from Watch_proc pid:$$\n";
        }

        sleep(2);
    }
}
