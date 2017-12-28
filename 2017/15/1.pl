use 5.20.0;

use List::AllUtils qw/ pairgrep /;

my @v = ( 679,771 );

my $mask = 2**16 - 1;

my $match;
for ( 1..40_000_000 ) {
    @v = ( 16807 * $v[0], 48271 * $v[1] );
    $_ %= 2147483647 for @v;

    $match += ($v[0] & $mask) == ($v[1] & $mask);

}

say $match;
