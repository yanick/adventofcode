use 5.20.0;

my @maze = <>;
my $position = 0;
my $steps = 0;

while( $position < @maze ) {
    $steps++;
    my $i = $position;
    $position += $maze[$position];
    $maze[$i] += $maze[$i] > 2 ? -1 : 1;
}

say $steps;
