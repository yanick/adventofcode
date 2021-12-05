package part1;

use 5.20.0;
use warnings;

use experimental qw/
    signatures
    postderef
    switch
/;

sub parse_code($lines) {
    return map { [ split ] }
    split "\n", $lines
}

sub run_once($index,$accum,$code) {
    my( $op, $val ) = $code->[$index]->@*;

    given( $op ) {
        when( 'nop' ) { $index++ }
        when( 'acc' ) { $index++; $accum += $val; }
        when( 'jmp' ) { $index += $val; }
    }

    return ( $index, $accum );
}

sub solution($lines) {
    my @code = parse_code($lines);

    my $index = 0;
    my $accum = 0;
    my %seen;

    until( $seen{$index}++ ) {
        ($index,$accum) = run_once($index,$accum,\@code);
    }

    return $accum;
}

1;
