use 5.20.0;
use warnings;

use List::AllUtils qw/ minmax pairs uniq sum /;
use List::UtilsBy qw/ max_by /;

use experimental qw/
    signatures
    postderef
/;

my @points = map { [ split ', ' ] } <>;

my @range_x = minmax map { $_->[0] } @points;
my @range_y = minmax map { $_->[1] } @points;

use DDP;

p @range_x;
p @range_y;

my %grid;
my @infinite;

my @movers = ( [
    int sum( @range_x )/2, int sum(@range_y)/2
] );

while( my $next = shift @movers ) {
    calculate_distances( @$next );
}


say sum map { values %$_ } values %grid;

# for my $row ( @grid ) {
#     say map { $_ ?
#             ($_->[1]->@* > 1 ? ' ' : $_->[1]->@* ) : '' } @$row
# }

sub dist($x1,$y1,$x2,$y2) {
    return abs($x1-$x2) + abs($y1-$y2);
}

sub calculate_distances($x, $y) {

    return if exists $grid{$x}{$y};

    $grid{$x}{$y} = 10_000 > sum map { dist($x,$y,@$_) } @points
        or return;


    push @movers,
        [ $x+1, $y ],
        [ $x-1, $y ],
        [ $x, $y+1 ],
        [ $x, $y-1 ];
}
