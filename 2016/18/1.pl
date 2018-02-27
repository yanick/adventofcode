use 5.20.0;

use experimental qw/ postderef /;

my @levels = (
    map { chomp; [ 
        map { $_ eq '^' } split '' ] } <>
);

use DDP;

p @levels;
my $sum = 0;
use List::AllUtils qw/ sum /;

for ( 1..400000-1 ) {
    my @previous = ( 0, $levels[-1]->@* );
    my @new;
    while( @previous >= 2 ) {
        my( $left, $mid, $right ) = @previous;
        push @new, 
            ( $left && $mid && ! $right )
         || ( !$left && $mid && $right )
         || ( $left && !$mid && !$right )
         || ( !$left && !$mid && $right );
         shift @previous;
    }
    push @levels, \@new;

    $sum += sum map { !$_ } map { @$_ } shift @levels;
}


say sum $sum, map { !$_ } map { @$_ } @levels;
