package part2;

use 5.34.0;
use warnings;
use experimental 'signatures';

use List::AllUtils qw/ sum /;

require './part1.pm';

sub solution(@list) {
    return part1::solution(
        map { my $i = $_; sum map { $list[$i+$_] } 0..2 } 0..$#list-2
    );
}

1;
