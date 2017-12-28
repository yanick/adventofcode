use 5.20.0;
use List::AllUtils qw/ sum /;
use List::UtilsBy qw/ nsort_by /;

use DDP; 

my $i;
my @raw = map { [ map { [ split ',' ] } /[pva]=<(.*?)>/g ] } <>;
my @p = map { [ map { manhat(@$_) } @$_ ] } @raw;

for ( sort {
    $p[$a][2] <=> $p[$b][2]
        or
    $p[$a][1] <=> $p[$b][1]
        or
    $p[$a][0] <=> $p[$b][0]
} 0..$#p ) {
#    p $raw[$_];
    p $p[$_];
    say $_;
    exit if $i++ >= 3;
}


sub manhat { sum map { abs } @_ }

p @p;

my( $min ) = sort {
    $p[$a][2] <=> $p[$b][2]
        or
    $p[$a][1] <=> $p[$b][1]
        or
    $p[$a][0] <=> $p[$b][0]
} 0..$#p;

say $min;

