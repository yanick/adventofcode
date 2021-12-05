package part1;

use 5.20.0;
use warnings;

use experimental qw/
    signatures
    postderef
/;

sub solution($n, $entries) {
    my @numbers = split "\n", $entries;

    my %seen;
    my @previous;

    # prime the pump
    while( @previous < $n ) {
        my $n = shift @numbers;
        $seen{$n + $_}++ for @previous;
        push @previous, $n;
    }

    while(my $next = shift @numbers) {
        return $next unless $seen{$next};

        my $goner = shift @previous;
        $seen{$goner + $_}-- for @previous;
        $seen{$next + $_}++ for @previous;

        push @previous, $next;
    }


}

1;
