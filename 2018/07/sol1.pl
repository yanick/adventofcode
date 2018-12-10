use 5.20.0;
use warnings;

use experimental qw/
    signatures
    postderef
/;

use Graph::Directed;

my $g = Graph::Directed->new;

while(<>) {
    /Step (.).*before step (.)/;
    $g->add_edge( $1 => $2 );
}

while(  my @x = sort $g->predecessorless_vertices ) {
    print $x[0];
    $g->delete_vertex($x[0]);
}

