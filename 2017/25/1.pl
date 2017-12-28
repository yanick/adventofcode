use 5.20.0;

my $state = 'A';

use experimental qw/ smartmatch /;
use List::AllUtils qw/ sum /;

my $iteration;

my @ribbon;
my $ri = 0;

my %chain = (
    A => [ [ 1, 1, 'B' ], [ 0, -1, 'C' ] ],
    B => [ [ 1, -1, 'A' ], [ 1, 1, 'D' ] ],
    C => [ [ 0, -1, 'B' ], [ 0, -1, 'E' ] ],
    D => [ [ 1, 1, 'A' ], [ 0, 1, 'B' ] ],
    E => [ [ 1, -1, 'F' ], [ 1, -1, 'C' ] ],
    F => [ [ 1, 1, 'D' ], [ 1, 1, 'A' ] ],
);

while( $iteration++ <= 1_2481_997 ) {
    say $iteration unless $iteration % 100_000;
    my $change = $chain{$state}[ $ribbon[$ri] ];
    $ribbon[$ri] = $change->[0];
    $ri += $change->[1];
    if( $ri == -1 ) {
        unshift @ribbon, 0;
        $ri = 0;
    }
    $state = $change->[2];
}

say sum @ribbon;
