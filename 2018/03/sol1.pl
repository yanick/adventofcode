use 5.20.0;

my @clothe;

while( <> ) {
    /(?<x>\d+),(?<y>\d+): (?<w>\d+)x(?<h>\d+)/ or die;

    for my $x ( $+{x}...$+{x}+$+{w}-1 ) {
        for my $y ( $+{y}...$+{y}+$+{h}-1 ) {
            $clothe[$x][$y]++
        }
    }
}

say scalar grep { $_ > 1 } map { $_ ? @$_ : () } @clothe;
