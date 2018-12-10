use 5.20.0;
use warnings;
use experimental qw/
    signatures
    postderef
/;

my @marbles;
my $next_marble = 0;

my $nbr_elves = 419;
my $current_elf = 0;
my $last_marble = 72164 * 100;

my %score;

while() {
    warn $next_marble if 0 == $next_marble % 10_000;

    last if $next_marble > $last_marble;

    if( $next_marble > 0 and 0 == $next_marble % 23 ) {
        unshift @marbles, splice @marbles, -6, 6;
        my $score = $next_marble + pop @marbles;
        $current_elf %= $nbr_elves;
        $score{$current_elf} += $score;
    }
    else {
        push @marbles, splice @marbles, 0, 2;
        unshift @marbles, $next_marble;
    }

    $next_marble++;
    $current_elf++;
}


use List::UtilsBy qw/ max_by /;
use List::AllUtils qw/ pairs max /;

say max values %score;
