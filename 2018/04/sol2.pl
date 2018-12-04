use 5.20.0;
use warnings;

use List::AllUtils qw/ before after_incl indexes sum pairs pairmap first unpairs /;
use List::UtilsBy qw/ partition_by max_by /;

use experimental qw/
    signatures
    postderef
/;

my @entries = sort <>;

say $_ for @entries;

my %sleep;

my $guard;
my $start;
for ( @entries ) {
    if( /#(\d+)/ ) { $guard = $1; }
    elsif( /0?(\d+)\] falls asleep/ ) { $start = $1; }
    elsif( /0?(\d+)\] wakes/ ) { 
        push $sleep{$guard}->@*, [ $start, $1 ];
    }
}

sub best_time {
    unpairs
    max_by { $_->[1] }
    pairs 
    pairmap { $a => scalar @$b } partition_by { $_ }  map { $_->[0]..$_->[1]-1 } @_;
}

use DDP;

my $worst =
max_by { $_->[2] }
pairmap { [ $a => best_time( @$b ) ] } %sleep;

p $worst;
say $worst->[0] * $worst->[1];
