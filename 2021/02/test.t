use 5.34.0;

use Test2::V0;
use Path::Tiny;

require './part1.pm';
require './part2.pm';

my @sample = path('sample')->lines;
my @input = path('input')->lines;

subtest part1 => sub {
    is part1::solution(@sample) => 150;
    is part1::solution(@input) => 2091984;
};

subtest part2 => sub {
    is part2::solution(@sample ) => 900;
    is part2::solution(@input) => 2086261056;
};
