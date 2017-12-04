use 5.20.0;

my %directions = (
    'v' => [ 0, 1 ],
    '^' => [ 0, -1 ],
    '<' => [ 1, 0 ],
    '>' => [ -1, 0 ],
);

my @last = ([0,0],[0,0]);
my @positions = (
    [0,0],
    map { 
        my $last = shift @last;
        my @this = ( $last->[0] + $_->[0], $last->[1] + $_->[1] );
        push @last, \@this;
        \@this;
    }
    map { $directions{$_} }  split '', <> );

use List::AllUtils qw/ uniq /;
@positions = uniq map { join ':', @$_ } @positions;
say scalar @positions;
