package P1;

use 5.20.0;
use warnings;

use List::AllUtils qw/ /;

use Moose;

use experimental qw/ signatures postderef /;

sub neighbours ( $self, $i, $j, $grid ) {

    my $n = 0;

    for my $x ( -1, 0, 1 ) {
        for my $y ( -1, 0, 1 ) {
            next unless $x or $y;
            my ( $c, $d ) = ( $i + $x, $j + $y );
            next if $c < 0 or $d < 0;

            no warnings;
            $n += $grid->[$c][$d] eq '#';
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
                if ( $self->neighbours( $i, $j, \@grid ) >= 4 ) {
                    $next[$i][$j] = 'L';
                }
            }
        }
    }

    return join "\n", map { join '', @$_ } @next;
}

sub solution ( $self, $room ) {
    my $previous;

    no warnings;
    while ( $room ne $previous ) {
        ( $previous, $room ) = ( $room, $self->iterate($room) );
    }

    my @m = $room =~ /(#)/g;
    return scalar @m;
}

1;
