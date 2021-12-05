package part1;

use 5.20.0;
use warnings;

use List::AllUtils qw/ /;

use experimental qw/ signatures postderef /;

sub solution(@seeds) {
    my $last = shift @seeds;
    my $turn = 1;
    my %said;

    for(@seeds) {
        $said{$last} ||= [];
        push $said{$last}->@*, $turn++;
        $last = $_;
    }

    until( $turn == 2020 ) {
        if( !$said{$last} ) {
            $said{$last} = [$turn];
            $last = 0
        } else {
            push $said{$last}->@*, $turn;
            if( $said{$last}->@* > 2 ) {
                shift $said{$last}->@*;
            }
            $last = $said{$last}[-1] - $said{$last}[-2];
        }

        $turn++;
    }

    return $last;


}

1;
