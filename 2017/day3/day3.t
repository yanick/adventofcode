use Test::More;

use day3;

is path(12) => 3;
is path(23) => 2;
is path(1024) => 31;
is path(1) => 0;

done_testing;
