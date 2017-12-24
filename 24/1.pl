use 5.20.0;
use experimental qw/ signatures postderef smartmatch /;
use List::AllUtils qw/ sum  max first_index /;
my @elements = map { chomp; [ split '/' ] } <>;

use DDP; 

say build_bridge(0,0,@elements);

sub build_bridge( $sofar = 0, $connector = 0, @left ) {
    # warn scalar @left;
#    p @_;
#    my $summy = <STDIN>;

    my  $max =  $sofar;

    for my $i ( 0..$#left ) {
        next unless $connector ~~ $left[$i]->@*;
        my @copy = @left;
        my $i = splice @copy, $i, 1;
        my $next_con = $i->[ 1 - first_index { $_ == $connector } @$i ];
        $max = max $max, build_bridge( $sofar + sum( @$i ), $next_con, @copy );
    }

    return $max;
}


