#!/usr/bin/env perl -n

use 5.20.0;
use List::AllUtils qw/ sum /;

chomp;
my @n = split '';

say sum @n[ grep { $n[$_] == $n[($_+@n/2)%@n] }  0..$#n ]
