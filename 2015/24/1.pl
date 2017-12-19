use 5.20.0;

my @gifts = map { 0+$_} <>;

use List::AllUtils qw/ sum product min /;

my $goal = sum(@gifts)/3;

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

__END__
#    p @_;
    my $total = sum $sofar->@*;

    return if $total > $goal;

    if( $total == $goal ) {
        if ( $done ) {
            # warn @$next, '!', @$gifts;
            #$DB::single = 1;
            die unless @$next or @$gifts;
            my @elt  = ( $done, $sofar, [ @$next, @$gifts ] );
            my @sorted = sort {
                @$a <=> @$b
                or
                product(@$a) <=> product(@$b)
            } @elt;
            my $prev = $min;
            $min = min $min, product @{$sorted[0]};
            say $min if $min < $prev;
            return; 
        }
        
        my @n = ( @$next, @$gifts );
        return aggregate( \@n, [shift @n], [], $sofar );
    }

    my @g = @$gifts or return;
    my $i = shift @g;

    aggregate( \@g, [ @$sofar, $i ], $next, $done );
    aggregate( \@g, $sofar, [ @$next, $i ], $done );

}


my $min = 1E99;
my @poss = possibilities(\@gifts,[]);
say $min;

use DDP;

p @poss;



sub possibilities( $left, $parts, $sum = 0 ) {
    if( $sum == 0 ) {

        if( @$parts == 2 ) {
            my @parts = ( @$parts, $left );

            my @sorted = sort {
                @$a <=> @$b
                or
                product(@$a) <=> product(@$b)
            } @$parts;
            $min = min $min, product @{$sorted[0]};
            say $min;
            return;
        }
        else {
            my @left = @$left;
            my $i = shift @left or return;
            $parts = [ @$parts, [ $i ] ];
            $sum = $goal - $i;
        }

    }

    for my $g ( grep { $sum - $_ >= 0 } @$left ) {
        my @parts = @$parts;
        $parts[-1] = [  @{$parts[-1]}, $g  ];
        possibilities( [ grep { $_ != $g } @$left], \@parts, $sum - $g );
    }

}


