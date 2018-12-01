use List::AllUtils qw/ sum first /;

use 5.20.0;

my @nums = <>;

my $index = 0;

my %seen; 
my $current = 0;

while() {
    $current += $nums[ $index++ % @nums ];
    say $current and last if $seen{$current};
    $seen{$current}++;
}
