use 5.20.0;
use warnings;
use experimental qw/
    signatures
    postderef
/;

my @input = split / /, <>;

parse_metadata(@input);

sub parse_metadata($nbr_children, $nbr_metadata, @payload) {
    my @meta;
    push @meta, pop @payload for 1..$nbr_metadata;



}
