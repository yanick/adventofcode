
use 5.20.0;

my @maze = <>;
my $position = 0;
my $steps = 0;

while( $position < @maze ) {
    $steps++;
    $position += $maze[$position]++;
}

say $steps;
