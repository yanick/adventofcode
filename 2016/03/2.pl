use 5.20.0;

use Algorithm::Combinatorics qw/ partitions /;
use List::AllUtils qw/ sum any all natatime /;

use DDP;

my $possible;
my(@a,@b,@c);
while(<>) {
    my @x = split ' ';
    push @a, shift @x;
    push @b, shift @x;
    push @c, shift @x;
}

my $it = natatime 3, @a, @b, @c;

while( my @x = $it->() ) {
    next unless all { $x[$_] < sum( @x ) - $x[$_] } 0..2;
    $possible++;
}

say $possible;
