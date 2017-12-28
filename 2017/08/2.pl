use 5.20.0;
use List::AllUtils qw/ max /;

my %reg;
my $max;

while(<>) {
    s/^(\w+)/\$reg{$1}/;
    s/(?<=if )(\w+)/\$reg{$1}/;
    s/dec/-=/;
    s/inc/+=/;
    eval;
    $max = max $max, values %reg;
}


say $max;
