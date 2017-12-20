use 5.20.0;
use List::AllUtils qw/ sum uniq /;
use List::UtilsBy qw/ nsort_by /;

use experimental qw/ postderef smartmatch /;

use DDP; 

my $i;
my @raw = map { [ map { [ split ',' ] } /[pva]=<(.*?)>/g ] } <>;

while() {
    check_collisions();
    move_particles();
    say scalar @raw;
}

sub move_particles {
    for ( @raw ) {
        for my $i ( 0..2 ) {
            $_->[1][$i] += $_->[2][$i];
            $_->[0][$i] += $_->[1][$i];
        }
    }
}

sub check_collisions {
    my %seen;
    my @to_delete;
    for ( 0..$#raw ) {
        my $k = join ':', $raw[$_][0]->@*;
        push @to_delete, $seen{$k}, $_ if exists $seen{$k};
        $seen{$k} = $_;
    }
    return unless @to_delete;
    @raw = @raw[ grep { not $_ ~~ @to_delete }  0..$#raw ];
}
