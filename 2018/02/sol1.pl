use 5.20.0;
use warnings;

use experimental qw/
    signatures
    postderef
/;

use List::UtilsBy qw/ partition_by /;
use List::AllUtils qw/ pairmap sum product /;

my @items = 
    map {  
        +{ 
            pairmap { scalar @$b => $a }
            partition_by { $_ }
            @$_
        }
    }
    map { [ split '' ] }
    <>;

say product 
    map { scalar @$_ }
    map {
        my $x = $_;
        [ grep { $_->{$x} } @items ]
    } 2, 3
