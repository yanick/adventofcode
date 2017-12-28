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

my @group = ( 0 );
my @unprocessed = $pipe{0}->@*;
my %seen = ( 0 => 1 );
while( @unprocessed ) {
    my $next = shift @unprocessed;
    warn $next;
    next if $seen{$next}++;
    warn join " ", $pipe{$next}->@*;
    push @unprocessed, $pipe{$next}->@*;
}

say join " ", keys %seen;
say scalar keys %seen;
