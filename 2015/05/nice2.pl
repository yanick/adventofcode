use 5.20.0;
use List::AllUtils qw/ sum /;

say sum map { nice() }<>;

sub nice {
    return !!( /(..).*?\1/ and /(.).\1/ );
}
