use 5.20.0;

my $i = 380;

my $p = 0;
my $x;

use DDP;
for(1..50_000_000) {
    say $_ unless $_ % 100_000;
    $p = ( 1 + $p + $i ) % $_;
    $x = $_ if  $p == 1;
    $p ||= $_;
}

say $x;
