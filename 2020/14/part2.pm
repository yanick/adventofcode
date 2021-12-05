package part2;

use 5.20.0;
use warnings;

use List::AllUtils qw/ zip pairmap sum reduce/;

require './part1.pm';

use experimental qw/ signatures postderef /;

sub solution(@lines) {
    my @mask;
    my %mem;

    while( my $line = shift @lines ) {
        warn $line;
        if( $line =~ /mask = (.*)/ ) {
            @mask = split '', $1;
            next;
        }

        $line =~ /mem\[(\d+)\] = (\d+)/ or die;

        my $value = $2;
        my @num = split '', sprintf "%036b", $1;

        my $l = join '', pairmap { $a || $b } zip @mask, @num;

        my $num = $l =~ s/X/%d/g;

        for( 0..(2**$num)-1 ) {
            my $address = reduce {
                2*$a + $b
            } split '', sprintf $l, split '', sprintf "%0${num}b", $_;
            $mem{$address} = $value;
        }
    }

    no warnings;
    return sum values %mem;
}

1;
