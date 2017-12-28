use 5.20.0;

use List::UtilsBy qw/ sort_by /;
use List::AllUtils qw/ sum /;
use experimental qw/ signatures /;


say sum map { /(\d+)/ } grep { is_real($_) } <>;

sub is_real ( $line ) {
    $line =~ s/\[(.*?)\]//;
    my $checksum = $1;

    $checksum eq join '', ( sort_by { 
        sprintf "%03d%s", 999 - (eval "\$line =~ y/$_/$_/"), $_
    } 'a'..'z' )[0..4];
}
