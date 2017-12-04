use List::AllUtils qw/ sum max /;

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

    my $level = $+{command} eq 'on' ? 1 : $+{command} eq 'off' ? -1 : 2;

    for my $x ( $+{from_x}..$+{to_x} ) {
        for my $y ( $+{from_y}..$+{to_y} ) {
            $grid->[$x][$y] = max 0, $grid->[$x][$y] + $level;
        }
    }
}

say sum map { $_  ? @$_ : () } @$grid;
