use 5.20.0;
my %happiness;

while(<>) {
    /(?<from>\S+).*(?<gain>gain|lose) (?<happiness>\d+).*?(?<to>\S+)\.$/;
    $happiness{$+{from}}{$+{to}} = $+{happiness} * ( $+{gain} eq 'gain' ? 1 : -1 );
}

$happiness{yanick}{''} = 0;

use Algorithm::Combinatorics qw/  circular_permutations /;
use List::AllUtils qw/ max sum /;

say max map { happiness_for($_) }    circular_permutations([ keys %happiness ]);

sub happiness_for {
    my @group = @{ $_[0] };

    sum map {
        my $who = $group[$_];
        map { $happiness{$who}{$group[ $_ ]} } map { $_ % @group } $_+1, $_ + @group - 1;
    } 0..$#group;
}
