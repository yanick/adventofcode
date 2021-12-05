package P1;

use 5.20.0;
use warnings;

use List::AllUtils qw/ /;
use Math::Vector::Real;

use Moose;
use MooseX::MungeHas 'is_rw';

use experimental qw/ signatures postderef switch /;

has coords => sub {
    return V(0,0);
};

has facing => sub {
    1;
};

my @delta = (
    V(0,1),
    V(1,0),
    V(0,-1),
    V(-1,0),
);

sub delta {
    return \@delta;
}

sub turn($self,$n) {
    my $d = ($self->facing + $n/90)%4;
    $self->facing($d);
}

sub move($self,$m) {
    $m =~ /(.)(\d+)/;

    my ( $x, $c ) = ($1,$2);

    my $coords = $self->coords;

    given($x) {
        $coords += $c * $delta[$self->facing] when 'F';
        $coords += $c * $delta[0] when 'N';
        $coords += $c * $delta[1] when 'E';
        $coords += $c * $delta[2] when 'S';
        $coords += $c * $delta[3] when 'W';
        $self->turn($c) when 'R';
        $self->turn(-$c) when 'L';
    }

    $self->coords($coords);
}

sub solution($class,@instructions) {
    my $self = $class->new;

    $self->move($_) for @instructions;

    $self->coords->manhattan_dist(V(0,0));
}

1;
