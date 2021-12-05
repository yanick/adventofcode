package part1;

use 5.34.0;
use warnings;
use experimental 'signatures';

use Path::Tiny;
use List::AllUtils qw/ natatime any sum all sum0/;

sub readFile($file) {
    my @lines = path($file)->lines;

    my @balls = split ',', shift @lines;
    my $it = natatime 5, map { [split] } grep { /\d/ } @lines;

    my @cards;
    while( my @next = $it->() ) { push @cards, \@next }

    return {
        balls => \@balls,
        cards => \@cards,
    }
}

sub has_line($n,$card) {
    return all { $_ == -1} $card->[$n]->@*;
}

sub has_column($n,$card) {
    return all { $_ == -1 } map {$_->[$n]} @$card;
}

sub score( $n, $card ) {
    return $n * sum map { sum0 grep { $_ > 0 } @$_ } @$card;
}

sub victory ($number, $card) {
    for ( 0..4 ) {
        if ( has_line($_,$card) or has_column($_,$card) ) {
            return score($number,$card);
        }
    }

    return 0;
}

sub solution($balls, $cards) {

    my $number = shift @$balls;

    for my $card ( @$cards ) {
        for my $row ( @$card ) {
            $row = [ map { $_ == $number ? -1 : $_ } @$row ];
        }

        if( my $score =  victory($number,$card) ) {
            return $score;
        }
    }

    goto &solution;
}

1;
