use 5.20.0;
use warnings;
use experimental qw/
    signatures
    postderef
/;

use lib './lib';

use Entry;

my @input = split / /, <>;

my $entry = Entry->new( stream => \@input );

say $entry->value;
