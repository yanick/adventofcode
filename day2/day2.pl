#!/usr/bin/perl

use 5.20.0;

use List::AllUtils qw/ minmax sum pairmap /;

say sum pairmap { -$a, $b } map { minmax split } <>;
