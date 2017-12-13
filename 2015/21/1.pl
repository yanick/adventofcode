use 5.20.0;
use Path::Tiny;

use Algorithm::Combinatorics qw/ combinations /;
use List::AllUtils qw/ sum max /;

use 5.20.0;

use experimental 'postderef';

my @weapons = (
#Weapons:    Cost  Damage  Armor
[ qw/ Dagger        8     4       0 / ],
[ qw/  Shortsword   10     5       0/ ],
[ qw/  Warhammer    25     6       0/ ],
[ qw/  Longsword    40     7       0/ ],
[ qw/  Greataxe     74     8       0/ ],
);

my @armors =  (
#Armor:      Cost  Damage  Armor
[ qw/  Leather      13     0       1/ ],
[ qw/  Chainmail    31     0       2/ ],
[ qw/  Splintmail   53     0       3/ ],
[ qw/  Bandedmail   75     0       4/ ],
[ qw/  Platemail   102     0       5/ ],
);


my @rings = (
#Rings:      Cost  Damage  Armor
[ qw/  Damage+1    25     1       0/ ],
[ qw/  Damage+2    50     2       0/ ],
[ qw/  Damage+3   100     3       0/ ],
[ qw/  Defense+1   20     0       1/ ],
[ qw/  Defense+2   40     0       2/ ],
[ qw/  Defense+3   80     0       3/ ],
);


my @boss = map { /(\d+)/ } path('input.txt')->lines;

use DDP;
p @boss;

my $min_price = 1E9;
for my $weapon ( @weapons ) {
    for my $armor ( [], @armors ) {
        for my $rings( [[]], ( map { [ $_ ] } @rings ), combinations( \@rings, 2 ) ) {
            my $price = sum map { $_->[1] } $weapon, $armor, 
                $rings->@*;
            next if $price > $min_price;

            my @stats = ( 100, map { my $i = $_; sum map { $_->[$i] } $weapon, $armor, $rings->@* } 2,3 );


            $min_price = $price if win_fight( \@stats, [ @boss ] );
        }
    }
}

say $min_price;

use experimental 'signatures';
sub win_fight( $me, $opponent ) {
    p @_;
    my $damage = max 1, $me->[1] - $opponent->[2];
    $opponent->[0] -= $damage;
    return 1 if $opponent->[0] <= 0;
    return not win_fight( reverse @_ );
}

