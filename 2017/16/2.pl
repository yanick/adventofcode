use 5.20.0;
use List::AllUtils qw/ first_index indexes /;

use experimental qw/ smartmatch /;

my @d = 'a'..'p';

my @moves = split ',', <>;

my @round = ( "@d" );

my $total = 1_000_000_000;

while( $total-- ) {
    for ( @moves ) {
        if( /s(\d+)/ ) {
            splice @d, 0, 0, splice @d, -$1;
        }
        elsif( m#x(\d+)/(\d+)# ) {
            @d[$1,$2]  =  @d[$2,$1];
        }
        elsif( m#p(.)/(.)# ) {
            my @i= indexes { $_ ~~ [ $1, $2 ] } @d;
            @d[@i] = @d[reverse@i];
        }
    }

    if( "@d" ~~ @round ) {
        warn "@d";
        @round = splice @round, first_index { $_ eq "@d" } @round;
        last;
    }
    else {
        push @round, "@d";
    }

}

$total %= @round;

say $round[$total] =~ s/ //gr;
