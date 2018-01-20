use 5.20.0;
use experimental qw/ signatures /;
use List::AllUtils qw/ reduce none all any /;
use DDP; 

say scalar
grep {
    has_sequence($_)
} map { chomp; $_ } <>;

sub has_sequence($s) {
    my @inner = $s =~ /\[(.*?)\]/g;

    for ( split /\[.*?\]/ ) {
        while( length($_) >= 3 ) {
            my $sub = substr $_, 0, 3;
            if( $sub =~ /(.)(?!\1)(.)\1/ ) {
                my $code = "$2$1$2";
                return 1 if any { -1 < index $_, $code } @inner;
            }
            s/^.//;
        }
    }

    return;
}
