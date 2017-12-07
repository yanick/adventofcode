use 5.20.0;
use experimental qw/ smartmatch /;

my %prog;

while(<>) {
    my( $name, @deps ) =
        map { split ', ' } /(\S+).*?-> (.*)/;
    $prog{$name} = \@deps;
}

my @all_deps = map { @$_ } values %prog;

say $_ 
    for grep { not $_ ~~ @all_deps } keys %prog;
