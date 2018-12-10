use 5.20.0;

my @lines = 
    map { 
        /(?<id>\d+).*?(?<x>\d+),(?<y>\d+): (?<w>\d+)x(?<h>\d+)/ or die;
        +{ %+ }
    }
    <>;

my @clothe;

for ( @lines  ) {

    for my $x ( $_->{x}...$_->{x}+$_->{w}-1 ) {
        for my $y ( $_->{y}...$_->{y}+$_->{h}-1 ) {
            $clothe[$x][$y]++
        }
    }
}

say scalar grep { $_ > 1 } map { $_ ? @$_ : () } @clothe;


LINE: for ( @lines  ) {
    for my $x ( $_->{x}...$_->{x}+$_->{w}-1 ) {
        for my $y ( $_->{y}...$_->{y}+$_->{h}-1 ) {
            next LINE if $clothe[$x][$y] > 1;
        }
    }
    say $_->{id};
}
