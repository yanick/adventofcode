use 5.20.0;

use List::AllUtils qw/ /;
use experimental qw/ signatures postderef /;

my %g = map { split ': ' }  <>;

my $score;

for my $g ( keys %g ) {
    next if $g  % (2*($g{$g}-1));
    warn $g;
    $score += $g  * $g{$g};
}

say $score;
