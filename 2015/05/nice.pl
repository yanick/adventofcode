use 5.20.0;
use List::AllUtils qw/ sum /;

say sum map { nice() }<>;

sub nice {
    return 0 if /ab|cd|pq|xy/ or not /(.)\1/;
    my @x = /([aeiou])/g;
    @x >= 3;
}
