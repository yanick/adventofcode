---
to: '<%= day %>/test.t'
---
use 5.34.0;

use Test2::V0;
use Path::Tiny;

require './part1.pm';
require './part2.pm';

subtest part1 => sub {
    my $todo = todo 'TODO';
    is part1::solution( ) => 'TODO';
};

subtest part2 => sub {
    my $todo = todo 'TODO';
    is part2::solution( ) => 'TODO';
};
