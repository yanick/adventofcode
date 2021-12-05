use 5.34.0;

use Test2::V0;
use Path::Tiny;

require './part1.pm';
require './part2.pm';

my @list = path('./input')->lines;

subtest part1 => sub {
    is part1::solution( @list ) => 1602;
};

subtest part2 => sub {
    is part2::solution(@list) => 1633;
};

done_testing();
