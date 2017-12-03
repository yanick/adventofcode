use 5.20.0;

use base 'Exporter';

use experimental 'signatures';

our @EXPORT = qw/ path /;

say path(shift) unless caller;

sub path($x) {
    my $i = 1;

    return 0 if $x == 1;

    $i+=2 until $x <= $i**2;

    my $j = ( $x - ($i-2)**2 ) % ($i-1);

    ($i-1)/2 + abs( $j - ($i-1)/2 );
}

1;
