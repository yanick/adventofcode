use Test2::V0;

BEGIN { push @INC, '.' }

use Path::Tiny;
use List::AllUtils qw/ max /;

use part1;
use part2;

subtest "part1" => sub {
    is resolve('BFFFBBFRRR') => 567;

    is max( map { resolve($_) } path('input')->lines ) => 813;
};

subtest part2 => sub {
    is part2::solution( path('input')->lines ) => 612;
};

done_testing();
