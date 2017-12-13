use 5.20.0;

use List::AllUtils qw/ min sum /;

my @grid = map { [ split '' ] } map { chomp; $_ } <>;

use DDP; 

@grid = iteration(@grid) for 1..100;

say sum map { $_ eq '#' } map { @$_ } @grid;

sub iteration { 
    my @grid = @_;

    #say join ' ', @$_ for @grid;
    #say;


    my $size = @grid-1;

    my @new_grid;

    for my $x ( 0..$size ) {
        for my $y ( 0..$size ) {
            my $neig = neighbors(\@grid,$x,$y);

            if( $grid[$x][$y] eq '#' ) {
                $new_grid[$x][$y] = $neig ~~ [ 2,3] ? '#' : '.';
            }
            else {
                $new_grid[$x][$y] = $neig == 3 ? '#' : '.';
            }
        }
    }

    return @new_grid;
}



sub neighbors {
    my( $grid, $x, $y ) = @_;

    my $sum;
    for my $i ( -1..1 ) {
        for my $j ( -1..1 ) {
            next if !$i and !$j;
            my($m,$n) = ($x+$i,$y+$j);
            next if 0 > min $m, $n;
            $sum += $grid->[$m][$n] eq '#';
        }
    }

    return $sum;
}

