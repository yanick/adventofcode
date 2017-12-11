use 5.20.0;
use List::AllUtils qw/ pairmap reduce pairs /;

my %target = (
    children=> 3,
    cats=> 7,
    samoyeds=> 2,
    pomeranians=> 3,
    akitas=> 0,
    vizslas=> 0,
    goldfish=> 5,
    trees=> 3,
    cars=> 2,
    perfumes=> 1,
);

while(<>) {
    my %attr = eval( ( split ':', $_, 2 )[1] =~ s/:/=>/gr );
    die $_ if reduce {
        $a and $target{$b->[0]} == $b->[1]
    } 1, pairs %attr;
}
