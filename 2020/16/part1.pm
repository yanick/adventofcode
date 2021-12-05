package part1;

use 5.20.0;
use warnings;

use List::AllUtils qw/ sum /;
use Range::Merge qw/ merge /;

use experimental qw/ signatures postderef /;

sub numbers_out_of_range($input) {
    my $ranges = merge([ map { [ split '-' ] } $input =~ /(\d+-\d+)/g]);

    $input =~ /nearby tickets:(.*)/s;
    my @tickets = $1 =~ /(\d+)/g;

    return grep {
        not( $_ >= $ranges->[0][0] and $_ <= $ranges->[0][1])
    } @tickets;

}

sub solution($input) {
    return sum numbers_out_of_range($input);
}

1;
