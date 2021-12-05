package part2;

use 5.20.0;
use warnings;

require './part1.pm';

use experimental qw/
    signatures
    postderef
    switch
/;

sub run_instance(@code) {

    my $index = 0;
    my $accum = 0;
    my %seen;

    until( $seen{$index}++ ) {
        ($index,$accum) = part1::run_once($index,$accum,\@code);

        return $accum if $index >= @code;
    }

    return undef;
}

sub solution($lines) {
    my @code = part1::parse_code($lines);

    for(0..$#code) {
        next if $code[$_][0] eq 'acc';
        my @new_code = @code;
        $new_code[$_] = [ $code[$_]->@* ];
        $new_code[$_][0] = $new_code[$_][0]  eq 'nop' ? 'jmp' : 'nop';

        my $result = run_instance(@new_code);

        return $result if $result;
    }
}

1;
