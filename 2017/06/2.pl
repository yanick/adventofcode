use 5.20.0;
use experimental 'postderef';

use List::UtilsBy qw/ max_by/;

my @stacks = split ' ', <>;

my %seen;

until( $seen{ join ':', @stacks }++ ) {
    redistribute();
}

my $target = join ":", @stacks;

my $i = 0;

redistribute($i++) until $i and $target eq join ':', @stacks;

say $i;

sub redistribute {
    warn "@stacks\n";
    my $col = max_by { $stacks[$_] }  0..$#stacks;
    my $v = $stacks[$col];
    $stacks[$col] = 0;
    $stacks[ ++$col % @stacks ]++ while $v--;
}

