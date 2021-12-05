package part2;

use 5.20.0;
use warnings;

use List::AllUtils qw/ sum reduce /;
use Set::Object qw/ set /;

use experimental qw/ signatures postderef /;

sub solution($input) {
    return sum map {
        my $answers = reduce { $a * $b } map { set( split '' ) } split "\n";
        $answers->size;
    } split "\n\n", $input;
}

1;
