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
        $grid{$i}{$j++} = $_ eq '#' ? 2 : 0;
    }
    $i++;
}

use DDP;
p %grid;

my $coord = V( ( 12 ) x 2);

my @id = ( 3, 0, 1, 2 );

my $sum;
for(1..10000000){
    my $infected = $grid{$coord->[0]}{$coord->[1]};
    $di += $id[$infected];
    $di %= 4;
    $grid{$coord->[0]}{$coord->[1]} = ($infected +1)%4;
    $sum++ if $infected == 1;
    $coord += $d[$di];
    # my %p = ( 0 => '.', 1 => 'W', 2 => 'I', 3 => 'F' );
    # for my $x ( -3..3 ) {
    #     for my $y ( -3..3 ) {
    #         print $p{ $grid{$x}{$y} };
    #     }
    #     print "\n";
    # }
}

say $sum;

