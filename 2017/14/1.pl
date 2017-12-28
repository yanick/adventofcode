use 5.20.0;

use lib '.';
use hash;
my $key = 'stpzcrnm';

use List::AllUtils qw/ sum /;

say sum
    map { split '' }
    map { sprintf "%04b", $_ }
    map { hex }
    map { split '' }
    map { knot_hash( join '-', $key, $_) } 0..127;
