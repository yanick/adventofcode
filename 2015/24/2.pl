use 5.20.0;

my @gifts = map { 0+$_} <>;

use List::AllUtils qw/ sum product min /;

my $goal = sum(@gifts)/4;

use experimental qw/ signatures postderef /;

use DDP;

my @min = ( 1 ) x $goal;
my $min = 1E99;

aggregate( \@gifts, $goal );


sub aggregate($gifts,$goal,@sofar) {
    use DDP;
    # p @_;

    return if $goal < 0;

    return if @sofar > @min;
    return if product(@sofar) > $min;

    if($goal == 0) {
        @min = @sofar;
        $min = product(@min);
        say $min;
        return;
    }

    return unless @$gifts;

    my( $i, @gifts) = @$gifts;

    aggregate( \@gifts, $goal - $i, @sofar, $i );
    aggregate( \@gifts, $goal, @sofar );

}

