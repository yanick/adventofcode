use 5.20.0;

my @range = ( [ 0, 4294967295 ] );

while(<>) {
    my $avoid = [  split '-' ];

    @range = map { remove_range($_, $avoid) } @range;

}

use DDP;
p $range[0];

use experimental qw/ signatures  /;

use List::AllUtils qw/ min max minmax /;

sub remove_range( $range, $avoid ) {

    return $range if $avoid->[0] > $range->[1]
        or $avoid->[1] < $range->[0];

    return ()
        if $avoid->[0] <= $range->[0]
        and $avoid->[1] >= $range->[1];

    my @range;

    if( $avoid->[0] <= $range->[0] ) {
        @range = ( [ $avoid->[1]+1, $range->[1] ] );
    }
    elsif( $avoid->[1] >= $range->[1] ) {
        @range = ( [ $range->[0], $avoid->[0]-1] );
    }
    else {
        @range = ( 
            [ $range->[0], $avoid->[0]-1],
            [ $avoid->[1]+1, $range->[1] ] );
    }


    return grep { $_->[0] <= $_->[1] }  @range;

}

