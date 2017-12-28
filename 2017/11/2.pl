use 5.20.0;

use DDP; 

use experimental 'postderef', 'signatures';
use List::AllUtils qw/ reduce min max /;

my $path = <>;
chomp $path;

my %path;

$path{$_}++ for split ',', $path;


my %d = (
    n => [ 0,1],
    s => [ 0,-1],
    e => [ 1, 0],
    w => [ -1,0],
);


for my $y ( qw/  n s / ){
    for my $e ( qw/  e w / ){
        $d{"$y$e"} = [ map { $_/2 } add( $d{$y}, $d{$e} )->@* ];
    }
}

my $position = [0,0];
my $max_distance;

$position = reduce { 
    my $p = add($a,$d{$b});
    $max_distance = max $max_distance, total_distance(@$p);
    $p;
} $position, split ',', $path;

say $max_distance;


sub total_distance ( @position ) {
    my @position = map { abs } @position;
    my $i  = min @position;
    return $i + 2 * ( $position[0] - $i) + $position[1];
}

sub add($x,$y) {
    [ map { $x->[$_] + $y->[$_] } 0..1 ]
}
