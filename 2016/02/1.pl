use 5.20.0;
use List::AllUtils qw/ reduce min max /;

my @grid = (
    [ 1,2,3],
    [4,5,6],
    [7,8,9],
);

my %d = (
    U => [ -1, 0 ],
    R => [ 0, 1 ],
    L => [ 0, -1 ],
    D => [ 1, 0 ],
);

my $coord = [ 1,1 ];
while(<>) {
    chomp;
    $coord =  reduce { 
        my $n = $d{$b};
        use DDP;
        #   p $a;
        [
            map { max 0, min $_, 2 }
            map { $a->[$_] + $n->[$_] }
            0..1
        ]


    } $coord, split '';

    say $grid[$coord->[0]][$coord->[1]];

}
