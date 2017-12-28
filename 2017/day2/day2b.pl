#!/usr/bin/perl

use 5.20.0;
use experimental 'signatures';

use List::AllUtils qw/ sum first /;

say sum map { divisors( sort { $b <=> $a } split ) } <>;

sub divisors(@nums) {
    while( my $x = shift @nums ) {
        return $x / $_ for grep { defined $_ } first { not $x % $_ } @nums;
    }
}
