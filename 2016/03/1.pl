use 5.20.0;

use Algorithm::Combinatorics qw/ partitions /;
use List::AllUtils qw/ sum any all /;

use DDP;

my $possible;
while(<>) {
    my @x = split ' ';
    use DDP; p @x;
    next unless all { $x[$_] < sum( @x ) - $x[$_] } 0..2;
    $possible++;
}

say $possible;
