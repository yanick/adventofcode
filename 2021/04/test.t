use 5.34.0;

use Test2::V0;

require './part1.pm';
require './part2.pm';

my $sample = part1::readFile('sample');
my $input = part1::readFile('input');

subtest part1 => sub {
    is part1::solution( $sample->{ balls }, $sample->{ cards }  ) => 4512;
    is part1::solution( $input->{ balls }, $input->{ cards }  ) => 49860;
};

subtest part2 => sub {
    is part2::solution( $sample->{ balls }, $sample->{ cards }  ) => 1924;
    is part2::solution( $input->{ balls }, $input->{ cards }  ) => 24628;
};
