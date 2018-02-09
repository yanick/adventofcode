use 5.20.0;

use JSON 'to_json';
use List::AllUtils qw/ all min part uniq pairgrep any /;

my %state = (
    E => 1,
    EG => 1,
    DG => 1,
    DM => 1,
    EM => 1,
    TG => 1,
    TM => 1,
    PG => 1,
    SG => 1,
    PM => 2,
    SM => 2,
    WG => 3,
    WM => 3,
    RG => 3,
    RM => 3,
);

sub freeze { to_json( { @_ }, { canonical => 1 } ) }

my %history = (
    0 => freeze(%state),
);

use DDP;
p %history;

my @next = ( [ 0, %state ] );

while( my $n = shift @next ) {
    search( @$n );
}

sub search {
    my( $steps, %state ) = @_;

    say "size: ", scalar @next;
    say $steps;
#    p $steps;
#    p %state;

    if( all { $_ == 4 } values %state ) {
        say "woohoo, found it: $steps";
        die;
    }

    my $f = freeze(%state);

    if( $history{$f}++ ) {
        return say "seen it";
    }

    if( britzle(%state) ) {
#        say "we fried something";
        return;
    }


    my $level = $state{E};
    my @things = grep { $_ ne 'E' and $state{$_} == $level } keys %state;

    for my $thing ( @things ) {
        for my $next_level ( grep { $_ >= 1 and $_ <= 4 } $level + 1, $level - 1 ) {
            push @next, [
                $steps + 1,
                %state,
                E => $next_level,
                $thing => $next_level,
            ];
        }
    }

    if ( @things >=2 ) {
        use Algorithm::Combinatorics qw(combinations);
        my $combs = combinations( \@things, 2 );
        while( my $c = $combs->next ) {
            for my $next_level ( grep { $_ >= 1 and $_ <= 4 } $level + 1, $level - 1 ) {
                push @next, [
                    $steps + 1,
                    %state,
                    map { $_ => $next_level } 'E', @$c
                ];
            }
        }
    }

}

sub britzle {
    my %state = @_;

    my @danger = grep { $state{$_} != $state{ s/M$/G/r } } grep { /.M/ } keys %state;

    for my $level ( uniq map { $state{$_} } @danger ) {
        return 1 if pairgrep { $a =~ /G$/ and $b == $level } %state;
    }

    return 0;
}
