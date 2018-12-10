use 5.20.0;
use warnings;

use experimental qw/
    signatures
    postderef
/;

use List::UtilsBy qw/ nsort_by /;
use List::AllUtils qw/ min /;

use Sim;

use Graph::Directed;

my $g = Graph::Directed->new;

while(<>) {
    /Step (.).*before step (.)/;
    $g->add_edge( $1 => $2 );
}

my $workers = 5;

Sim->schedule(
    0 => \&check_for_work,
);

my %available = map { $_ => 1 } $g->vertices;

Sim->run( fires => 100_000 );

sub time_for {
        ord(shift) - ord('A') + 1 + 60;
}


sub check_for_work {
    say "time: ", Sim->now;

    my @next = sort $g->predecessorless_vertices or return;

    while( $workers ) {
        my $next = shift @next or return;

        $available{$next} or next;

        delete $available{$next};

        $workers--;

        Sim->schedule(
            Sim->now + time_for($next) => sub {
                say "time done $next: ", Sim->now;
                $g->delete_vertex($next);
                $workers++;
                Sim->schedule( Sim->now, \&check_for_work );
            }
        )
    }
}


