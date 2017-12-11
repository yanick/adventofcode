use 5.20.0;

use List::AllUtils qw/ sum min first /;

use experimental 'signatures';

my @sizes = <>;
use DDP; p @sizes;

say number_fitting( 150, sum(@sizes), 0, @sizes );

my @nbr_containers;

say first { $_ } @nbr_containers;



sub number_fitting( $left, $max, $nbr, @sizes ) {
    return 0 if $max < $left;

    return 0 if $left and not @sizes;

    return $nbr_containers[$nbr]++ unless $left;

    my $this = shift @sizes;

    return sum map { 
        number_fitting( $left - $_ * $this, $max - $this, $nbr + $_, @sizes );
    } 0..min 1, ($left / $this);

}
