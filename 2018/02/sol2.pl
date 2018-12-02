use 5.20.0;
use warnings;

my @items = <>;

use List::AllUtils qw/ pairwise /;

use experimental qw/
    signatures
    postderef 
    current_sub
/;

while( my $next = shift @items ) {
    my $match = find([ split '', $next], @items) or next;
    say $match;
    last;
}

sub find( $next, @items ) {
    my $contender = splice @_, 1, 1 or return;
    $contender = [ split '', $contender ];

    my $diff = 0;
    my $r = '';

    for my $i ( 0..$next->@* ) {
        if ( $next->[$i] eq $contender->[$i] ) {
            $r .= $next->[$i];
        }
        else {
            last if $diff++;
        }
    }

    return $r if $diff == 1;

    goto __SUB__;
}
