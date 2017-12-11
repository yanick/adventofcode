use 5.20.0;

use List::AllUtils qw/ sum min /;

use experimental 'signatures';

my @sizes = <>;
use DDP; p @sizes;

say number_fitting( 150, sum(@sizes), @sizes );

sub number_fitting( $left, $max, @sizes ) {
    return 0 if $max < $left;

    return 0 if $left and not @sizes;

    return 1 unless $left;

    my $this = shift @sizes;

    return sum map { 
        number_fitting( $left - $_ * $this, $max - $this, @sizes );
    } 0..min 1, ($left / $this);

}
