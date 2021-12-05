package part2;

use 5.34.0;

use experimental qw/ signatures switch/;

sub solution(@lines) {
    my( $depth, $aim, $x );

    for my $line ( @lines ) {
        my( $action, $value ) = split ' ', $line;

        given($action) {
            $aim+=$value when 'down';
            $aim-=$value when 'up';
            when( 'forward' ) {
                $x += $value;
                $depth += $aim * $value;
            }
        }
    }

    return $x * $depth;

}

1;
