package part2;

use 5.20.0;
use warnings;
use experimental 'signatures';

use List::AllUtils qw/ /;

require './part1.pm';

use experimental qw/ signatures postderef /;
use DDP;

sub solution($balls, $cards) {
    my $number = shift @$balls;

    for my $index ( reverse 0..$cards->$#* ) {
        my $card = $cards->[$index];

        for my $row ( @$card ) {
            $row = [ map { $_ == $number ? -1 : $_ } @$row ];
        }

        my $score =  part1::victory($number,$card) or next;

        return $score if @$cards == 1;

        splice @$cards, $index, 1;
    }

    @_ = ( $balls, $cards );
    goto &solution;
}

1;
