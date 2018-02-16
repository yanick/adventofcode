use 5.20.0;

use List::UtilsBy qw/ nsort_by /;
use List::AllUtils qw/ min max /;
use Math::Vector::Real;

use experimental qw/ signatures postderef /;

my @grid;

my $number = 1364;


my @pos = ( [V(1,1), dist(V(1,1)),0] );

my $best = 1E99;

while (@pos) {
    @pos = nsort_by { $_->[1] } @pos;
    my $c = shift @pos;
    use DDP;
#    p $c;
    my $i = $c->[2];
    next if $i >= $best;

    unless( $c->[1] ) {
        say "ONE! ", $i;
        $best = min $best, $i;
        next;
    }

    push @pos, map { [ $_, dist($_), $i+1 ] } grep { movable($_,$i) }  surround($c->[0]);

    say map { length($_) ? $_ : ' ' }  @$_ for @grid;
    say "\n\n";

#    my $x = <STDIN>;
}

say $best;


sub movable( $v, $steps ) {
    my($x,$y) = @$v;

    return if $grid[$x][$y] eq '#' or ( $grid[$x][$y] and $grid[$x][$y] <= $steps );

    my $is_wall = ( grep { $_ == 1 } split '', sprintf "%b", $x**2 + 3*$x + 2*$x*$y + $y + $y**2 + $number ) % 2;

    $grid[$x][$y] = $is_wall ? '#' : $steps;

    return !$is_wall;
}

sub surround($v) {
    grep { 0 <= min @$_  } map { $v + $_ } [1,0], [-1,0], [0,1], [0,-1];
}



sub dist($v) {
    return $v->dist2([ 31, 39 ]);
}
