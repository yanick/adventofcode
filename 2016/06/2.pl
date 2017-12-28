use 5.20.0;

use List::UtilsBy qw/ max_by min_by /;

my @message;

while(<>) {
    chomp;
    my @letters = split '';
    while( my( $i, $l ) = each @letters ) {
        $message[$i]{$l}++;
    }
}

use DDP;

for my $m ( @message ) {
    print min_by { $m->{$_} } keys %$m;
}

