use Test2::V0;
use Path::Tiny;

require './part1.pm';
require './part2.pm';

subtest part1 => sub {
    is part1::solution(0,3,6) => 436;
    is part1::solution(0,13,1,16,6,17) => 234;
};

subtest part2 => sub {
    is part2::solution(0,13,1,16,6,17) => 8984;
};

done_testing();
