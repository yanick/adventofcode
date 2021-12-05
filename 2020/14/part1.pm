package part1;

use 5.20.0;
use warnings;

use List::AllUtils qw/ zip pairmap reduce sum/;

use experimental qw/ signatures postderef /;

sub solution(@lines) {
    my @mask;
    my @mem;

    while( my $line = shift @lines ) {
        if( $line =~ /mask = (.*)/ ) {
            @mask = split '', $1;
            next;
        }

        $line =~ /mem\[(\d+)\] = (\d+)/ or die;

        my @num = split '', sprintf "%036b", $2;

        $mem[$1] = reduce { 2*$a + $b } pairmap { $a eq 'X' ? $b : $a } zip @mask, @num;
    }

    no warnings;
    return sum @mem;
}

1;
