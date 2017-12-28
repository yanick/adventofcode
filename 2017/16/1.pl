use 5.20.0;
use List::AllUtils qw/ first_index indexes /;

my @d = 'a'..'p';

for ( split ',', <> ) {
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

say @d;
