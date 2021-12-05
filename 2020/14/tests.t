use Test2::V0;
use Path::Tiny;

require './part1.pm';
require './part2.pm';

my @sample1 = path('sample1')->lines;
my @input = path('input')->lines;

subtest part1 => sub {
    skip_all;
    is part1::solution(@sample1) => 165;
    is part1::solution(@input) => 14954914379452;
};

subtest part2 => sub {
    my @sample2 = path('sample2')->lines;
    is part2::solution(@sample2) => 208;
    is part2::solution(@input) => 3415488160714;
};

done_testing();
