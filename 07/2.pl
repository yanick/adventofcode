use 5.20.0;
use experimental qw/ smartmatch signatures postderef /;
use List::AllUtils qw/ sum /;
use List::UtilsBy qw/ nsort_by /;

my %prog;

while(<>) {
    my( $name, $weight, @deps ) =
        map { split ', ' } /(\S+).*?(\d+)(?:.*?-> (.*))?/;
    $prog{$name} = [ $weight, \@deps ];
}

balance('qibuqqg');

sub balance($prog) {
    my %child = map { $_ => balance($_) } $prog{$prog}[1]->@*;

    my %w;
    while ( my( $n, $w ) = each %child ) {
        push @{ $w{$w} }, $n;
    }

    if( 1 < keys %w ) {
        my( $bad, $good ) = nsort_by { scalar $w{$_}->@* } keys %w;
        die $w{$bad}[0], " needs to be ", $prog{$w{$bad}[0]}[0] - $bad + $good;
    }

    return $prog{$prog}[0] + sum values %child;
}



