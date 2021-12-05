package P2;

use 5.20.0;
use warnings;

use List::AllUtils qw/ /;
use Math::Vector::Real;

require './part1.pm';

use Moose;
extends 'P1';

use experimental qw/ signatures postderef /;

sub neighbours ( $self, $i, $j, $grid ) {

    my $n = 0;

    for my $x ( -1, 0, 1 ) {
        for my $y ( -1, 0, 1 ) {
            next unless $x or $y;

            my $delta = V( $x, $y );
            my $c     = V( $i, $j );

            while () {
                $c += $delta;

                last if grep { $_ < 0 } @$c;
                my $x = $grid->[ $c->[0] ][ $c->[1] ];

                last if !$x or $x eq 'L';

                next if $x eq '.';

                $n++;
                last;
            }
        }
    }

    return $n;

}

sub iterate ( $self, $room ) {

    my @grid = map { [ split '' ] } split "\n", $room;
    my @next = map { [@$_] } @grid;

    for my $i ( 0 .. $#grid ) {
        my $row = $grid[$i];
        for my $j ( 0 .. $row->$#* ) {
            if ( $row->[$j] eq 'L' ) {
                if ( not $self->neighbours( $i, $j, \@grid ) ) {
                    $next[$i][$j] = '#';
                }
            }
            elsif ( $row->[$j] eq '#' ) {
                if ( $self->neighbours( $i, $j, \@grid ) >= 5 ) {
                    $next[$i][$j] = 'L';
                }
            }
        }
    }

    return join "\n", map { join '', @$_ } @next;
}

1;
