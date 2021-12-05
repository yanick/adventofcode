package part2;

use 5.20.0;
use warnings;
use experimental 'signatures';

use List::AllUtils qw/ /;

require './part1.pm';

use experimental qw/ signatures postderef /;
use List::AllUtils qw/ any min max sum zip pairmap /;

sub solution(@sample) {
    my %grid;

    for my $line (@sample) {
        for my $step ( part1::steps(@$line) ) {
            $grid{$step->[0]}{$step->[1]}++;
        }
    }

    return part1::score(%grid);
}

1;
