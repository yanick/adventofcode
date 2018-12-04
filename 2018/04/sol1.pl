use 5.20.0;
use warnings;

use List::AllUtils qw/ before after_incl indexes sum pairs pairmap first /;
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

use DDP;
my %nappers = pairmap { $a => sum map { $_->[1] - $_->[0] } @$b } %sleep;
p %nappers;
my( $worst ) = map { $_->[0] } max_by { $_->[1] } pairs %nappers;

#p $sleep{$worst};

say "worst offender: $worst";
my @x = pairs pairmap { $a => sum map { $_->[1] - $_->[0] } @$b } %sleep;

# p @x;

my %times = pairmap { $a => scalar @$b } partition_by { $_ }  map { $_->[0]..$_->[1]-1 } $sleep{$worst}->@*;
p %times;
my ($minute) = map { $_->[0] } max_by { $_->[1] } pairs  %times;

say $minute;

say "$worst, $minute ", $guard * $minute;

say $worst * $minute;
# 51618 is too low
