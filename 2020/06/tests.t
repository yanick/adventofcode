use Test2::V0;

BEGIN { push @INC, '.'; }
use part1;
use part2;
use Path::Tiny;

is part1::solution( path('input')->slurp ) => 6633;
is part2::solution( path('input')->slurp ) => 3202;

done_testing();
