use 5.20.0;
use warnings;
use experimental qw/
    signatures
    postderef
/;

my @marbles;
my $next_marble = 0;
my $index = 0;

my $nbr_elves = 419;
my $current_elf = 0;
my $last_marble = 72164 * 100;

my %score;

while() {
    warn $next_marble if 0 == $next_marble % 10_000;
    last if $next_marble > $last_marble;
    if( $next_marble > 0 and 0 == $next_marble % 23 ) {
        $index = ( $index - 7 + @marbles ) % @marbles;
        my $score = $next_marble + splice @marbles, $index, 1;
        $score{$current_elf} += $score;
    }
    else {
        $index = ( $index + 2 ) % ( @marbles || 1 );
        splice @marbles, $index, 0, $next_marble;

    }

    #    say join ' ', @marbles;
    #    my $x = <>;

    $next_marble++;
    $current_elf++;
    $current_elf %= $nbr_elves;
}


use List::UtilsBy qw/ max_by /;
use List::AllUtils qw/ pairs max /;

say max values %score;
