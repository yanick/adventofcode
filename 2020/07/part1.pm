package part1;

use 5.20.0;
use warnings;

use experimental qw/
    signatures
    postderef
/;

sub parse_line($line) {
    $line =~ s/(\w+ \w+) bags//;
    my $bag = $1;

    my %content = ();

    while ( $line =~ /(\d+) (\w+ \w+) bag/g ) {
        $content{$2} = $1;
    }

    return $bag => \%content;
}

sub contains( $name, $target, $bags ) {

    return 1 if $bags->{$name}{$target};

    for ( keys $bags->{$name}->%* ) {
        return 1 if contains( $_, $target, $bags );
    }

    return 0;
}

sub solution(@lines) {
    my %bags = map { parse_line($_) } @lines;

    return scalar grep { contains($_, 'shiny gold', \%bags) } keys %bags;

}

1;
