use Test2::V0;
use Path::Tiny;

require './part1.pm';
require './part2.pm';

my $sample = path('sample')->slurp;
my $input = path('input')->slurp;

subtest part1 => sub {
    is P1->new->solution( $sample ) => 37;
    is P1->new->solution( $input ) => 2427;
};

subtest part2 => sub {
    is P2->new->solution( $sample ) => 26;
    is P2->new->solution( $input ) => 2199;
};

done_testing();
