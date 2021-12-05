use 5.20.0;
use warnings;

use Path::Tiny;

use experimental qw/
    signatures
    postderef
/;

my @lines = path(shift)->lines;

print scalar grep { is_valid($_) } @lines;

sub is_valid($line) {
    $line =~ /(?<min>\d+)-(?<max>\d+) (?<letter>\w): (?<password>\w+)/;

    my $min = $+{min};
    my $max = $+{max};
    my @matches = $+{password} =~ /$+{letter}/g;
    return ( @matches >= $min and @matches <= $max );
}
