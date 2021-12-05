package part2;

use 5.20.0;
use warnings;

use List::AllUtils qw/ /;

require './part1.pm';

use experimental qw/ signatures postderef /;

use Memoize;

memoize('ways');

sub ways($first, @rest) {
    return 1 unless @rest;

    my $ways = 0;

    while( my $next = shift @rest ) {
        last if $next - $first > 3;
        $ways += ways($next, @rest);
    }

    return $ways;
}


sub solution(@lines) {
    @lines = sort {$a<=>$b}@lines;
    unshift @lines, 0;
    push @lines, $lines[-1] + 3;

    return ways(@lines);
}

1;
