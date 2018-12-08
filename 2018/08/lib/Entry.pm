package Entry;

use Moose;

use experimental qw/ signatures postderef /;

use List::AllUtils qw/ sum /;

has stream => (
    is => 'ro',
    required => 1,
    traits => [ 'Array' ],
    handles => {
        splice => 'splice',
    },
    trigger => sub($self,$stream) {
        my( $nchild, $ndata ) = splice @$stream, 0, 2;
        $self->children([
            map { Entry->new( stream => $stream ) } 1..$nchild
        ]);
        $self->data([ splice @$stream, 0, $ndata ]);
    }
);

has children => (
    is => 'rw',
    default => sub { [] },
);

has data => (
    is => 'rw',
    default => sub { [] },
);

sub all_data($self) {
    return $self->data->@*, map {$_->all_data} $self->children->@*;
}

sub value($self) {
    if( ! $self->children->@* ) {
        return sum $self->data->@*
    }

    return sum 
        map { $_->value }
        grep { $_ }
        map { $self->children->[ $_  ] }
        grep { $_ >= 0 }
        map { $_ -1 }
        $self->data->@*;


}

1;
