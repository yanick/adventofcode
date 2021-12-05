use 5.20.0;
use warnings;

use experimental qw/
    signatures
    postderef
/;

use Path::Tiny;

my @forest = path(shift)->lines({chomp => 1 });

my $trees = 0;

my $i = 0;
for my $line ( @forest ) {
    $trees++ if '#' eq substr $line, $i, 1;
    $i+=3;
    $i %= length $line;
}

print $trees;


