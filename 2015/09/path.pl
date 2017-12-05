use 5.20.0;

use List::AllUtils qw/ uniq min /;

use experimental qw/ signatures /;

my %dist;
while(<>) {
    my( $from, $to, $dist ) = split / (?:to|=) /;
    $dist{$from}{$to} = $dist{$to}{$from} = $dist;
}

my @cities = uniq keys %dist;

say min map { 
    my @c = @cities;
    min_distance( splice( @c, $_, 1 ), @c )
} 0..$#cities;

sub min_distance( $src, @left ) {
    return 0 unless @left;

    return min map { 
        $dist{$src}{$left[ $_ ]} + min_distance( $left[$_], @left[0..$_-1], @left[$_+1..$#left] )
    } 0..$#left;

    



}
