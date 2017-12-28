use 5.20.0;

my $path = <>;
chomp $path;

my %path;

$path{$_}++ for split ',', $path;

use DDP; 

my %d = (
    n => [ 0,1],
    s => [ 0,-1],
    e => [ 1, 0],
    w => [ -1,0],
);

use experimental 'postderef', 'signatures';

for my $y ( qw/  n s / ){
    for my $e ( qw/  e w / ){
        $d{"$y$e"} = [ map { $_/2 } add( $d{$y}, $d{$e} )->@* ];
    }
}

my $position = [0,0];

use List::AllUtils qw/ reduce min /;

$position = reduce { add($a,$d{$b}) } $position, split ',', $path;

p %d;
p %path;

p $position;

my @position = map { abs } @$position;

my $to_go = 0;
my $i  = min @position;
$to_go = 2 * $i;
@position = map { $_ - $i } @position;
$to_go += 2 * $position[0] + $position[1];

say $to_go;

sub add($x,$y) {
    [ map { $x->[$_] + $y->[$_] } 0..1 ]
}
