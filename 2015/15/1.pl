use 5.20.0;

use List::AllUtils qw/ pairmap max product sum /;

my %ingredients = pairmap { 
    $a => { $b =~ /(\w+) (-?\d+)/g }
} map { split ': ' } <>;

my @dim = qw/ capacity durability flavor texture /;

use DDP;
p %ingredients;

say max_score( 100, [ sort keys %ingredients ], {} );

use experimental 'signatures';

sub max_score( $spoons, $ingr, $mix ) {

    unless($spoons) {
        # use DDP; p $mix;
        my $total;
        return product 
            map { max $_, 0 }
            map { my $d = $_; sum pairmap {  $b * $ingredients{$a}{$d} } %$mix } @dim;
    }

    my( $i, @r ) = @$ingr;

    return max_score(0,[],{ %$mix, $i => $spoons }) unless @r;

    return max map { 
        max_score( $spoons - $_, \@r, { %$mix, $i => $_ } )
    } 0..$spoons;


}
