package part2;


use 5.20.0;
use warnings;

use experimental qw/
    signatures
    postderef
/;

require './part1.pm';

sub contains($name, $bags) {
    my $contained = 0;

    while( my( $name, $qty ) = each $bags->{$name}->%* ) {
        $contained += $qty * ( 1+ contains($name, $bags));
    }

    return $contained;
}


sub solution(@lines) {
    my %bags = map { part1::parse_line($_) } @lines;

    return contains('shiny gold', \%bags );
}
