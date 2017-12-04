use 5.20.0;

use Algorithm::Combinatorics qw( combinations );
use List::AllUtils qw/ sum min product /;

my $total;

say sum 
    map { 2 * ( $_->[0] + $_->[1] ), product @$_ } 
    map {[ sort { $a <=> $b } split 'x' ]} <>;


