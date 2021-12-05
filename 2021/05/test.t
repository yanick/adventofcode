use 5.34.0;

use Test2::V0;
use Path::Tiny;

require './part1.pm';
require './part2.pm';

my @sample = part1::readFile('./sample');
my @input =  part1::readFile('./input');

use DDP;

subtest part1 => sub {
    is [part1::steps([1,1],[3,3])] => [ [ 1,1 ],[2,2],[3,3] ];
    is [part1::steps([3,3],[1,1])] => [ [ 3,3 ],[2,2],[1,1] ];
    is [part1::steps([1,3],[1,1])] => [ [ 1,3 ],[1,2],[1,1] ];

    is part1::solution(@sample ) => 5;
    is part1::solution(@input ) => 5576;
};

subtest part2 => sub {
    is part2::solution(@sample ) => 12;
    is part2::solution(@input ) => 18144;
};
