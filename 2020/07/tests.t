use Test2::V0;
use Path::Tiny;

require './part1.pm';
require './part2.pl';

my $sample = <<'END';
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
END

subtest part1 => sub {
    is part1::solution(split "\n", $sample) => 4;

    is part1::solution(path('input')->lines) => 278;
};

subtest part2 => sub {
    is part2::solution( sample2() ) => 126, 'example';

    is part2::solution(path('input')->lines) => 45157, 'solution';
};


done_testing();

sub sample2 {
    return split "\n", <<'END';
shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.
END
}

