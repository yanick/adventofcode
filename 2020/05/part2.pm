package part2;

use 5.20.0;
use warnings;

use experimental qw/
  signatures
  postderef
  switch
  /;

use part1;

sub solution(@codes) {
    my @positions = sort { $a <=> $b } map { resolve($_) } @codes;

    my $i = $positions[0];

    for (@positions) {
        return $_ - 1 if $_ != $i++;
    }

}

1;

