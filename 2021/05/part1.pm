package part1;

use 5.34.0;
use warnings;
use experimental 'signatures';

use Path::Tiny;
use List::AllUtils qw/ any min max sum zip pairmap/;
use Math::Vector::Real;

sub score(%grid) {
    return sum map { $_ > 1 ? 1 : 0 } map { values %$_ } values %grid;
}

sub delta($from,$to) {
    $from == $to ? 0 : $from < $to ? 1 : -1;
}

sub steps($pa,$pb) {
    my $incr = V( pairmap { delta($a,$b) } zip @$pa, @$pb );

    my @steps = ( V(@$pa) );
    my $dest = V(@$pb);
    while( $steps[-1] != $dest) {
        push @steps, V($steps[-1]->@*) + $incr;
    }

    return @steps;

}

sub readFile ($filename) {
    return map {
        [ map { [split ',' ] } split ' -> ' ]
    } path($filename)->lines;
}

sub solution (@sample) {
    my %grid;

    for my $line (@sample) {
        next unless any { $line->[0][$_] == $line->[1][$_] } 0 .. 1;
        for my $step ( steps(@$line) ) {
            $grid{$step->[0]}{$step->[1]}++;
        }
    }

    return score(%grid);

}

1;
