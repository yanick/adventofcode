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

use DDP;

my $max = 55;

search( 0, \%state, freeze(%state) );

say $max;

sub search {
    my( $steps, $state, @history ) = @_;

#    say "steps: ", $steps;

    if( all { $_ == 4 } values %$state ) {
        $max = min $max, $steps;
        say "woohoo, found it: $steps, $max";
        return;
    }

    return if $steps + 1 >= $max;

    my $level = $state->{E};
    my @things = grep { $_ ne 'E' and $state->{$_} == $level } keys %$state;

    use Algorithm::Combinatorics qw(combinations);

    $steps++;

    for my $group (2,1) {
        next if @things < $group;

        my $combs = combinations( \@things, $group );
        while( my $c = $combs->next ) {
            I: for my $next_level ( grep { $_ >= 1 and $_ <= 4 } $level + 1, $level - 1 ) {
                my %new_state = ( %$state, map { $_ => $next_level } 'E', @$c );
                my $f = freeze(%new_state);
                if ( any { $_ eq $f  }  @history ) {  next I };
                if ( britzle(%new_state) ) {  next I; };
                search( $steps, \%new_state, $f, @history )
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
