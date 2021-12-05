package part2;

use 5.20.0;
use warnings;

use List::AllUtils qw/ min max /;
use POSIX qw/ ceil /;

require './part1.pm';

use experimental qw/ signatures postderef /;

sub find($t, $next=undef, @buses) {

    return 0 unless $next;

    if( $next eq 'x' ) {
        return find($t+1, @buses );
    }

    my $n = $t / $next;
    my $nint = int $n;

    if( $nint == $n ) {
        return find( $t+1, @buses );
    }

    return (1+$nint)*$next;

}

sub solution(@buses) {
    @buses = map { $_ eq 'x'?1:$_
    } @buses;

    my $t = 1;
    T: while() {
        my $i = 0;
        my @min = map {
            my $s = $t + $i++;
            $_ * ceil($s/$_);
        } @buses;
        warn join " ", @min;
        for(0..$#min-1) {
            if( $min[$_] != $min[$_+1]-1 ) {
                $t = max map { $min[$_] - $_ } 0..$#min;
                next T;
            }
        }
        return $t;
    }
}

1;
