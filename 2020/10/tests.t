use Test2::V0;
use Path::Tiny;

require './part1.pm';
require './part2.pm';

my @sample2 = path('sample2')->lines;
my @input = path('input')->lines;

subtest part1 => sub {
    is part1::solution(@sample2) => 220, 'sample2';

    is part1::solution( @input) => 1700;
};

subtest part2 => sub {
    is part2::solution(@input ) => 12401793332096;
};

done_testing();
