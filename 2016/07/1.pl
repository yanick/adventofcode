# 117 is too high
# 108 is too high

use 5.20.0;
use experimental qw/ signatures /;
use List::AllUtils qw/ reduce none all any /;
use DDP; 

say scalar
grep { 
    any { has_sequence($_) } split /\[.*?\]/;
}
grep {
    none { has_sequence($_) } /\[(.*?)\]/g;
} map { chomp; $_ } <>;

sub has_sequence($s) {
    return $s =~ /(.)(?!\1)(.)\2\1/;
}
