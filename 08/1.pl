use 5.20.0;

my %reg;

while(<>) {
    s/^(\w+)/\$reg{$1}/;
    s/(?<=if )(\w+)/\$reg{$1}/;
    s/dec/-=/;
    s/inc/+=/;
    eval;
}

use List::UtilsBy qw/ max_by /;
use List::AllUtils qw/ max /;

say max values %reg;
