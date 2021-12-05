use Test2::V0;
use Path::Tiny;

require './part1.pm';
require './part2.pm';

my @input = path('input')->lines;

0 and subtest part1 => sub {
    is P1->solution(@input)  => 1221;
};

subtest part2 => sub {
    is P2->solution(qw/
F10
N3
F7
R90
F11 /) => 286, 'example';

    is P2->solution(@input ) => 59435;
};

done_testing();
