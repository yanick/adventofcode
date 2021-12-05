package part1;

use 5.20.0;
use warnings;

use List::AllUtils qw/  part /;

use experimental qw/ signatures postderef /;

sub solution(@lines) {
    @lines = sort {$a<=>$b}@lines;
    unshift @lines, 0;
    push @lines, $lines[-1] + 3;

    my @diffs = part { $_ } map { $lines[$_] - $lines[$_-1] } 1..$#lines;

    return $diffs[1]->@* * $diffs[3]->@*;
}

1;
