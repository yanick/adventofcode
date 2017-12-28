use 5.20.0;

use List::UtilsBy qw/ sort_by /;
use List::AllUtils qw/ sum /;
use experimental qw/ signatures /;

my @real = grep { is_real($_) } <>;

my @alphabet = ( 'a'..'z' );
say $_, ": ", decrypt($_) for @real;


sub decrypt($line) {

    $line =~ s/(\d+).*$//;
    my $checksum = $1;

    $line =~ s/-/ /g;
    $line =~ s/([a-z])/ $alphabet[ ( ord( $1 ) - ord( 'a' ) + $checksum ) % @alphabet ]/eg;

    $line;

}

sub is_real ( $line ) {
    $line =~ s/\[(.*?)\]//;
    my $checksum = $1;

    $checksum eq join '', ( sort_by { 
        sprintf "%03d%s", 999 - (eval "\$line =~ y/$_/$_/"), $_
    } 'a'..'z' )[0..4];
}
