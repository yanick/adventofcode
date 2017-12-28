use 5.20.0;

use Math::Vector::Real;

use experimental qw/ postderef signatures /;

my @d = map { V(@$_) } [ -1,0], [0,1],[1,0],[0,-1];
my $di = 0;

my %grid;
my ($i,$j) = (0,0);
for my $r( <> ) {
    $j = 0;
    chomp $r;
    for ( split '', $r ) {
        $grid{$i}{$j++} = $_;
    }
    $i++;
}

use DDP;
p %grid;

my $coord = V(12,12);


my $sum;
for(1..10_000){
    my $infected = $grid{$coord->[0]}{$coord->[1]} eq '#';
    $di += $infected ? 1 : 3;
    $di %= 4;
    $grid{$coord->[0]}{$coord->[1]} = $infected ? '.' : '#';
    $sum++ unless $infected;
    $coord += $d[$di];
}

say $sum;

