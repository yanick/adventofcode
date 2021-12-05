package part1;

use 5.20.0;
use warnings;

use Path::Tiny;
use List::AllUtils qw/ sum /;

use experimental qw/
  signatures
  postderef
  /;

sub solution($input) {
    return sum map {
        my %x = map { $_ => $_ } /(\w)/g;
        scalar keys %x;
    } split "\n\n", $input;
}

1;
