package part2;

use 5.20.0;
use warnings;

use experimental qw/
    signatures
    postderef
/;

use List::AllUtils qw/ minmax sum /;

sub solution($target, $entries) {
    my @numbers = split "\n", $entries;

    my $sum = 0;
    my @seq;

    while( @numbers ) {
        while( $sum < $target ) {
            push @seq, shift @numbers;
            $sum += $seq[-1];
        }
        while( $sum > $target ) {
            $sum -= shift @seq;
        }

        if( $sum == $target ) {
            return sum minmax @seq;
        }

    }
}

1;
