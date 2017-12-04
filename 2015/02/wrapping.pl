use 5.20.0;

use Algorithm::Combinatorics qw( combinations );
use List::AllUtils qw/ sum min product /;

my $total;
for(map {[ split 'x' ]} <>) {
    my $x = [ combinations($_,2) ];
    my @v = map { product @$_  } combinations( $_, 2 );
    $total += sum min( @v ), map { 2*$_ } @v;
}

say $total;


