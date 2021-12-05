use Test2::V0;
use Path::Tiny;

require './part1.pm';
require './part2.pm';

my $input = path('input')->slurp;

subtest part1 => sub {
    is part1::solution($input) => 20048;
};

subtest part2 => sub {
    is part2::solution($input) => 4810284647569;
};

done_testing();
