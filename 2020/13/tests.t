use Test2::V0;
use Path::Tiny;

require './part1.pm';
require './part2.pm';

my @input = path('input')->lines;

subtest part1 => sub {
    is part1::solution( $input[0], split ',', $input[1] ) => 171;
};

subtest part2 => sub {
    is part2::solution( 17, 'x', 13, 19 ) => 3417;
    #   is part2::solution( split ',', $input[1] ) => 171;
};

done_testing();
