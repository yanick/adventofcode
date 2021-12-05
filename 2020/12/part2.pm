package P2;

use 5.20.0;
use warnings;

use List::AllUtils qw/ /;
use Math::Vector::Real;

require './part1.pm';

use Moose;
use MooseX::MungeHas 'is_rw';

extends 'P1';

use experimental qw/ signatures postderef /;

has +facing => sub { V(10,1) };

sub turn($self,$n) {
    my $f = $self->facing;
    my $d = ($n/90)%4;
    given( $d ) {
        return V($f->[1], -$f->[0]) when 1;
        return V(-$f->[0], -$f->[1]) when 2;
        return V(-$f->[1], $f->[0]) when 3;
    }
    return $f;
}

sub move($self,$m) {
    $m =~ /(.)(\d+)/;

    my ( $x, $c ) = ($1,$2);

    my $coords = $self->coords;
    my $facing = $self->facing;


    given($x) {
        $coords += $c * $self->facing when 'F';
        $facing += $c * $self->delta->[0] when 'N';
        $facing += $c * $self->delta->[1] when 'E';
        $facing += $c * $self->delta->[2] when 'S';
        $facing += $c * $self->delta->[3] when 'W';
        $facing = $self->turn($c) when 'R';
        $facing = $self->turn(-$c) when 'L';
    }

    $self->facing($facing);
    $self->coords($coords);

    warn $self->facing;
    warn $self->coords;
}

1;
