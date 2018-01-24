use 5.20.0;
use experimental qw/ postderef /;

my $grid = [ map { [ (0) x 50 ] } 0..5 ];

use DDP;

while(<>) {
    if( /rect (\d+)x(\d+)/ ) {
        for my $x ( 0..$1-1 ) {
            for my $y ( 0..$2-1 ) {
                $grid->[$y][$x] = 1;
            }
        }
    }

    if( /rotate row y=(\d+) by (\d+)/ ) {
        my @v = $grid->[$1]->@*;
        $grid->[$1] = [ @v[ (-$2)..-1 ], @v[0..($#v-$2)] ];
    }

    if( /rotate column x=(\d+) by (\d+)/ ) {
        my @v = map { $_->[$1] } $grid->@*;
        @v = ( @v[ (-$2)..-1 ], @v[0..($#v-$2)] );
        $grid->[$_][$1] = shift @v for 0..5;
    }

    say;
    say map { $_ ? '#' : ' ' } @$_ for @$grid;
}

use List::AllUtils qw/ sum /;
say sum map { @$_ } @$grid;
