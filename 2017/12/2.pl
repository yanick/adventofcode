use 5.20.0;

use List::AllUtils qw/ pairmap /;

use experimental 'postderef';

my %pipe = pairmap { $a => [ split ', ', $b] } map { split ' <-> ' } 
    map { chomp; $_ }<>;

use DDP;

for my $from (keys %pipe ) {
    my @i = $pipe{$from}->@*;
    for my $i ( @i ) {
        push $pipe{$i}->@*, $from;
    }
}

my $nbr_groups = 0;

while ( keys %pipe ) {
    $nbr_groups++;
    my ( $first ) = keys %pipe;
    my @unprocessed = ( $first );
    my @group;
    my %seen;
    while( @unprocessed ) {
        my $next = shift @unprocessed;
        my $p = delete $pipe{$next} or next;
        push @unprocessed, $p->@*;
    }
}

say $nbr_groups;
