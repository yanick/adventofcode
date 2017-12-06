use 5.20.0;
use List::AllUtils qw/ max/;
use experimental qw/ postderef /;
use List::UtilsBy qw/ max_by /;

my %reindeer =
    map { $_->[0] => [ ($_->[1]) x $_->[2], ( 0 ) x $_->[3] ] }
    map { [ /(\S+).*?(\d+).*?(\d+).*?(\d+)/ ] } <>;

use DDP;
p %reindeer;

my %dist;
my %score;

for ( 0..2502 ) {
    while( my( $r, $s ) = each %reindeer ) {
        $dist{$r} += $reindeer{$r}[ $_ % $reindeer{$r}->@* ]
    }
    my $max = max values %dist;
    $score{$_}++ for grep { $dist{$_} == $max } keys %dist;
}

say max values %score;


