use 5.20.0;

use Digest::MD5 qw/ md5_hex /;
use Math::Vector::Real;
use List::AllUtils qw/ min max minmax /;

my @directions = (
    [ 'U', V(0,-1) ],
    [ 'D', V(0,1) ],
    [ 'L', V(-1,0) ],
    [ 'R', V(1,0) ],
);

my $best_path; 

wander( 'bwnlcvfs', V(0,0) );

say length($best_path) - 8;

sub wander {
    my( $hash, $c ) = @_;

    my( $min,$max ) = minmax @$c;

    return if 0 > $min;
    return if 3 < $max;

    if( $c == V(3,3) ) {
        say $hash;
        if( length($hash) >= length($best_path) ) {
            $best_path = $hash;
        }
        return;
    }

    my @md5 = split '', md5_hex($hash), 5;

    my @d = grep { (shift @md5) =~ /[b-f]/ } @directions;

    for my $d ( @d ) {
        wander( $hash . $d->[0], $c + $d->[1] );
    }
}
