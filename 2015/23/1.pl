use 5.20.0;

my @code = <>;

my $i = 0;

my %t;
while( $i < @code ) {
    warn join ' ', $i, $t{a}, $t{b}, $code[$i];
#    my $dummy = <>;
    if( $code[$i] =~ /inc (.)/ ) {
        $t{$1}++;
        $i++;
    }
    elsif( $code[$i] =~ /tpl (.)/ ) {
        $t{$1} *= 3;
        $i++;
    }
    elsif( $code[$i] =~ /hlf (.)/ ) {
        $t{$1} /= 2;
        warn $t{$1};
        $i++;
    }
    elsif( $code[$i] =~ /jmp ([+-]\d+)/ ) {
        $i+=$1;
    }
    elsif( $code[$i] =~ /jie (.), ([+-]\d+)/ ) {
        $i+= ($t{$1} % 2) ? 1 : $2;
    }
    elsif( $code[$i] =~ /jio (.), ([+-]\d+)/ ) {
        $i+= ($t{$1} != 1) ? 1 : $2;
        warn $i;
    }
    
}

use DDP;
p %t;


