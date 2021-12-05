use Test2::V0;
use Path::Tiny;

require './part1.pm';
require './part2.pm';

subtest part1 => sub {
    is part1::solution( 5, <<'END') => 127;
35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576
END

    is part1::solution( 25, path('input')->slurp ) => 26796446;
};

subtest part2 => sub {
    is part2::solution( 26796446, path('input')->slurp ) => 3353494;
};

done_testing();
