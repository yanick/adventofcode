use 5.20.0;
use List::AllUtils qw/ reduce /;

my $i;
reduce {
    my $l = $a + ( $b eq '(' ? 1 : -1 );
    $i++;
    die $i if $l < 0;
    $l;
} 0, split '', <>;
