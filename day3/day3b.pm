use 5.20.0;
use experimental 'postderef';

use Array::Tour::Spiral;
use List::AllUtils qw/ sum /;

my $num = shift;

my $spiral = Array::Tour::Spiral->new( dimensions => $num );

my $grid = [];
my $first = 1;

while ( my ($x,$y) = $spiral->next->@* ) {
    if( $first) {
        $grid->[$x][$y] = 1;
        $first = 0;
    }
    else {
        $grid->[$x][$y] = sum map { 
            my $i = $_;
            map { $grid->[$x+$i][$y+$_] } -1..1
        } -1..1
    }

    warn $grid->[$x][$y];
    exit say $_ for grep { $_ > $num }  $grid->[$x][$y];
}
