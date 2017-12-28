my @maze = <>;
my $position = 0;
my $steps = 0;
my $p;

while( $position < @maze ) {
    $steps++;
    my $i = $position;
    $position += $p = $maze[$position];
    $maze[$i] += $p > 2 ? -1 : 1;
}

print $steps;
