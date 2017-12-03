use 5.20.0;
use experimental 'postderef';

use Array::Tour::Spiral;
use List::AllUtils qw/ sum /;

my $num = shift;

my $spiral = Array::Tour::Spiral->new( dimensions => $num );

my $grid = [];
my $first = 1;
my $current = 0;

until ( $current > $num ) {
    my ($x,$y) = $spiral->next->@*;
    $current = $grid->[$x][$y] = 
        $first ? $first--
               : sum map { 
                    my $i = $_;
                    map { $grid->[$x+$i][$y+$_] } -1..1
                    } -1..1
}

say $current;
