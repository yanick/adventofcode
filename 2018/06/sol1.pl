use 5.20.0;
use warnings;

use List::AllUtils qw/ minmax pairs uniq /;
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

my @grid;
my $id = 'a';
my @infinite;

my @movers = map {
    $id++;
    [ $id, 0, @$_ ]
} @points;

while( my $next = shift @movers ) {
    calculate_distances( @$next );
}

push @infinite,
    uniq
    map { eval { $_->[1]->@* } }
    grep { $_ and 1 == $_->[1]->@* }
    map { $grid[$_]->@* }    $range_x[0]-1, $range_x[1]+1;

my %tally;

for my $x ( map { eval { $_->[1] } } map { eval { @$_ } } @grid ) {
    next unless ref $x;
    next if 1 < @$x;
    $tally{ $x->[0] }++;
}

delete @tally{@infinite};

my $max = max_by { $_->[1] } pairs %tally;

p $max;

# for my $row ( @grid ) {
#     say map { $_ ?
#             ($_->[1]->@* > 1 ? ' ' : $_->[1]->@* ) : '' } @$row
# }


sub calculate_distances($id, $distance, $x, $y) {

    if( $x < $range_x[0] - 1
            or $x > $range_x[1] +1
            or $y < $range_y[0] - 1
            or $y > $range_y[1] +1 ) { return; }

    if( !$grid[$x][$y] ) {
        $grid[$x][$y] = [ $distance, [ $id ] ];
    }
    else {
        if( $distance < $grid[$x][$y][0] ) {
            $grid[$x][$y] = [ $distance, [ $id ] ];
        }
        elsif( $distance == $grid[$x][$y][0] ) {
            if( grep { $_ eq $id } $grid[$x][$y][1]->@* ) { return }
            push $grid[$x][$y][1]->@*, $id;
            return;
        }
        else {
          return;
        }
    }

    $distance++;

    push @movers,
        [ $id, $distance, $x+1, $y ],
        [ $id, $distance, $x-1, $y ],
        [ $id, $distance, $x, $y+1 ],
        [ $id, $distance, $x, $y-1 ];
}
