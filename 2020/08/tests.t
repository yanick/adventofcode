use Test2::V0;
use Path::Tiny;

require './part1.pm';
require './part2.pm';

subtest part1 => sub {
    is part1::solution(<<END) => 5, 'sample';
nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6
END

    is part1::solution( path('input')->slurp ) => 1262, 'part1';
};

is part2::solution( path('input')->slurp ) => 1643, 'part2';

done_testing();
