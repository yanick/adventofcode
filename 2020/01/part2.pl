use 5.20.0;
use warnings;

use Path::Tiny;
use List::AllUtils qw/ product /;

use experimental qw/ signatures /;

my @expenses = path('input')->lines;

$, = " ";
print product find_group( \@expenses, 2020, 3, [] )->@*;

sub find_group($list,$goal,$n,$so_far) {

    if( $n == 1 ) {
        if( grep { $_ == $goal } @$list ) {
            return [ @$so_far, $goal ];
        };
        return;
    }

    my @list = grep { $_ < $goal } @$list;

    while ( my $next = shift @list ) {
        my $result = find_group( \@list, $goal - $next, $n-1, [ @$so_far, $next ] ) or next;

        return $result;
    }
}
