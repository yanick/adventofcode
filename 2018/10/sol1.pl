use 5.20.0;
use warnings;
use experimental qw/
    signatures
    postderef
/;

use List::AllUtils qw/ pairmap minmax zip min/;
use Term::Caca;

my @points =  map { [  map { [ split ', ' ] } /(?<=\<).*?(?=>)/g ] }  <>;

use DDP;

my $width = 1E9;

my $time = -1;

while() {

    move(\@points);
    $time++;

    my $new_width = width(@points);
    #    say $width;
    last if $new_width > $width;
    $width = $new_width;
}

# for part II
# say $time; exit;

move(\@points,-1);

my $minx = min map { $_->[0][0] } @points;
my $miny = min map { $_->[0][1] } @points;

$_->[0] = [
    $_->[0][0] - $minx,
    $_->[0][1] - $miny,
] for @points;


my $caca = Term::Caca->new;

for my $p ( @points ) {
    $caca->text( $p->[0], '*' );
}

$caca->refresh;

my $foo = <>;

sub move($points,$dir=1) {
        $_->[0] = [
            pairmap { $a + $dir * $b } zip $_->[0]->@*, $_->[1]->@*
        ] for @$points;
}

sub width(@points) {
    ( pairmap { $b - $a }
        minmax map { $_->[0][0] } @points
    )[0];
}


