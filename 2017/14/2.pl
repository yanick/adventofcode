use 5.20.0;

use lib '.';
use hash;
my $key = 'stpzcrnm';

use List::AllUtils qw/ sum /;

my @grid =
    map { [ map { $_ ? '#' : ' ' } map { split '', sprintf "%04b", hex } split '' ] }
    map { knot_hash( join '-', $key, $_) } 0..127;

my $clusters;
for my $x ( 0..127 ) {
    for my $y ( 0..127 ) {
        $clusters+= eradicate(\@grid,$x,$y);
    }
}

say $clusters;

use experimental qw/ signatures /;
sub eradicate($grid,$i,$j) {
        return 0 if $grid->[$i][$j] ne '#';
        $grid->[$i][$j] = ' ';
        eradicate($grid,$i-1,$j) if $i > 0;
        eradicate($grid,$i,$j-1) if $j > 0;
        eradicate($grid,$i+1,$j);
        eradicate($grid,$i,$j+1);
        return 1;
}


sub print_g {
    say @$_ for @grid;
}
