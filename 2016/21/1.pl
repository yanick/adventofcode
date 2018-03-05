use 5.20.0;

use List::AllUtils qw/ first_index indexes /;

my @code = split '', 'abcde'; #fgh';  # agcebfdh

while( <> ) {
    if( /swap position (\d+) with position (\d+)/ ) {
        @code[ $1, $2 ] = @code[$2, $1];
    }
    elsif( /swap letter (.) with letter (.)/ ) {
        my @x = indexes { $_ eq $1  or $_ eq $2 } @code;
        @code[ @x ] = @code[ reverse @x ];
    }
    elsif( /reverse positions (\d+) through (\d+)/ ) {
        @code[ $1..$2 ] = reverse @code[ $1..$2 ];
    }
    elsif( /rotate left (\d+)/ ) {
        push @code, shift @code for 1..$1;
    }
    elsif( /rotate right (\d+)/ ) {
        unshift @code, pop @code for 1..$1;
    }
    elsif( /move position (\d+) to position (\d+)/ ) {
        my($x) = splice @code, $1, 1;
        splice @code, $2, 0, $x;
    }
    elsif( /rotate based on position of letter (.)/ ) {
        my $i = first_index { $_ eq $1 } @code;
        $i++ if $i >= 4;
        $i++;
        unshift @code, pop @code for 1..$i;
    }
    else {
        die $_;
    }

    say @code;
}
