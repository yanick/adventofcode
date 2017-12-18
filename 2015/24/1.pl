use 5.20.0;

my @gifts = map { 0+$_} <>;

use List::AllUtils qw/ sum product min /;

my $goal = sum(@gifts)/3;

use experimental qw/ signatures postderef /;

use DDP;

my $min = 1E99;
aggregate( \@gifts, [shift @gifts], [] );


sub aggregate($gifts,$sofar,$next,$done=undef) {
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

__END__

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


