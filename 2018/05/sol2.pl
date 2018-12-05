use 5.20.0;
use warnings;

use List::AllUtils qw/ uniq min /;

use experimental qw/
    signatures
    postderef
/;

my $code = <>;
chomp $code;

use DDP;

say min
    map { length react($_) }
    map { $code =~ s/$_//irg }
    'a'..'z';


sub react ($code) {
    my @combos = map { create_dual($_) } uniq split '', $code;
    my $re = join '|', @combos;

    1 while $code =~ s/$re//g;

    return $code;
}

sub create_dual($x) {
    $x . ( $x eq uc $x ? lc $x : uc $x );
}
