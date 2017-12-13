use 5.20.0;

use List::AllUtils qw/ /;
use experimental qw/ signatures postderef /;

my %g = map { split ': ' }  <>;


my $i = 1;

until( pass($i) ) {
    $i++;
}

say '>>>',$i;
    
sub pass($i) {
    for my $g ( keys %g ) {
        return unless ($i+$g)  % (2*($g{$g}-1));
    }
    return 1;
}

