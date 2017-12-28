use 5.20.0;
use experimental qw/ signatures postderef smartmatch /;
use List::AllUtils qw/ sum  max first_index  min/;
my @elements = map { chomp; [ split '/' ] } <>;

use DDP; 

my $inv_length = 1E99;
my $max = 0;

build_bridge(0,0,@elements);
say $max;

sub build_bridge( $sofar = 0, $connector = 0, @left ) {

    for my $i ( 0..$#left ) {
        next unless $connector ~~ $left[$i]->@*;
        my @copy = @left;
        my $i = splice @copy, $i, 1;
        my $next_con = $i->[ 1 - first_index { $_ == $connector } @$i ];
        build_bridge( $sofar + sum( @$i ), $next_con, @copy );
    }

    return if @left > $inv_length;

    if( @left == $inv_length ) {
        $max = max $max, $sofar;
    }
    else {
        $inv_length = @left;
        $max = $sofar;
    }

}


