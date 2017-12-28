use 5.20.0;

use List::Lazy qw/ lazy_list lazy_range /;

my $mask = 2**16 - 1;

my $list_a = ( lazy_list {
    $_ *= 16_807;
    $_ %= 2147483647;
    $_;
} 679 )->grep( sub { not $_ % 4 } )->map(sub{ $_ & $mask });

my $list_b = ( lazy_list {
    $_ *= 48_271;
    $_ %= 2147483647;
    $_;
} 771 )->grep( sub { not $_ % 8 } )->map(sub{ $_ & $mask });


use DDP;
my $i = 0;
say $list_a
    ->until(sub{ ++$i >= 5_000_000})
    ->spy(sub { say $i unless $i % 100_000 })
    ->grep(sub { $_ == $list_b->next } )
    ->reduce(sub { $a + 1},0);

