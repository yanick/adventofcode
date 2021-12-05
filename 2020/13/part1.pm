package part1;

use 5.20.0;
use warnings;

use List::AllUtils qw/ min /;

use experimental qw/ signatures postderef /;

sub solution($timestamp,@entries) {
    @entries = grep { $_ ne 'x' } @entries;

    my %sched = map {
        (int($timestamp / $_)+1 )* $_ => $_
    } @entries;

    my $k = min keys %sched;
    $sched{ $k } * ( $k - $timestamp ) ;

}

1;
