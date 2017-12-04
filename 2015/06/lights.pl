use 5.20.0;

my $grid = [];

while(<>) {
    warn $_;
    /
        (?<command>on|off|toggle)
        .*?
        (?<from_x>\d+),
        (?<from_y>\d+)
        .*?
        (?<to_x>\d+),
        (?<to_y>\d+)
    /x;

    for my $x ( $+{from_x}..$+{to_x} ) {
        for my $y ( $+{from_y}..$+{to_y} ) {
            $grid->[$x][$y] = 
                $+{command} eq 'on' ? 1
                :$+{command} eq 'off' ? 0
                : !$grid->[$x][$y];
 
        }
    }
}

use List::AllUtils qw/ sum /;

say sum map { $_  ? @$_ : () } @$grid;
