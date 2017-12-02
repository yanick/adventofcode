#!/usr/bin/env perl -n

use 5.20.0;
use List::AllUtils qw/ sum /;

chomp;
$_ .= substr $_, 0, 1;

say sum /(.)(?=\1)/g;
