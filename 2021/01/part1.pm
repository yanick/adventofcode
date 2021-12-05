package part1;

use 5.34.0;
use warnings;

use experimental 'signatures';

use List::AllUtils qw/ sum /;

sub solution(@list) {
    return sum map { $list[$_] > $list[$_-1] } 1..$#list;
}

1;
