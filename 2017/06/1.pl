use 5.20.0;
use experimental 'postderef';

#use List::SomeUtils qw/ min_by /;
use List::UtilsBy qw/ max_by/;

my @stacks = split ' ', <>;

my %seen;

until( $seen{ join ':', @stacks }++ ) {
    warn "@stacks\n";
    my $col = max_by { $stacks[$_] }  0..$#stacks;
    my $v = $stacks[$col];
    $stacks[$col] = 0;
    $stacks[ ++$col % @stacks ]++ while $v--;
}

say scalar keys %seen;

