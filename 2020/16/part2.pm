package part2;

use 5.20.0;
use warnings;

use List::AllUtils qw/ pairmap zip product /;
use Range::Merge qw/ merge /;
use Set::Object qw/ set /;

require './part1.pm';

use experimental qw/ signatures postderef /;

sub inRanges($n, $ranges) {

    for (@$ranges) {
        return 1 if $_->[0] <= $n and $_->[1] >= $n;
    }

    return 0;
}

sub possibilities($n,$fields) {

    return set(
        grep { inRanges($n, $fields->{$_})} keys %$fields
    )


}

sub solution($input) {
    my ( $fields, $myticket, $tickets ) = split "\n\n", $input;

    my %fields = map {
        my ( $name, $ranges) = split ':';
        $name => merge([ map { [ split '-']  } $ranges =~ /(\d+-\d+)/g ])
    }  split "\n", $fields;

    my @global;

    for my $ticket ( split "\n", $tickets ) {
        next if $ticket =~ /nearby/;

        my @fields = split ',', $ticket;

        @fields = map { possibilities($_,\%fields) } @fields;

        next if grep { not $_->size } @fields;

        if(!@global) {
            @global = @fields;
        }
        else {
            @global = pairmap { $a*$b } zip @global, @fields;
        }
    }

    use DDP; say join " ", @$_ for  @global;

    my %indexes;

    LOOP: while() {
        for( 0..$#global ) {
            if( $global[$_]->size == 1 ) {
                my $e = $global[$_];
                $indexes{$global[$_][0]} = $_;
                @global = map { $_ - $e } @global;
                redo LOOP;
            }
        }

        last LOOP;
    }

    p %indexes;

    my @myt = $myticket =~ /(\d+)/g;

    return product
    @myt[
    map { $indexes{$_} }
    grep { /departure/ } keys %indexes ];

}

1;
