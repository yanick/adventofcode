use 5.20.0;

use List::AllUtils qw/ max min /;

my @boss = map { /(\d+)/ } <>;
#my @boss = ( 14, 8 );

my @me = ( 50, 500 );
#my @me = ( 10, 250 );

my $min_mana = 2000;

simulate_me( {}, \@me, \@boss );

say $min_mana;

use experimental qw/ signatures /;

our $I = 0;

sub simulate_me( $spell, $me, $boss ) {
    use DDP;

    say ' ' x $I, "min_mana: $min_mana";
    say ' ' x $I, "health: ", $me->[0];
    say ' ' x $I, "mana ", $me->[1];

    spell_effect($spell,$me,$boss);

    return if game_over($me,$boss);

    return if $me->[2] > $min_mana; # already too much

    if( $me->[1] >= 53 ) {
        say ' 'x $I, "magic missile!";
        local $I = $I +1;
        my @boss = @$boss;
        $boss[0] -= 4;
        my @me = @$me;
        $me[1] -= 53; $me[2] += 53;
        simulate_boss({%$spell},\@me,\@boss);
    }

    if( $me->[1] >= 73 ) {
        say ' 'x $I, "drain!";
        local $I = $I +1;
        my @boss = @$boss;
        $boss[0] -= 2;
        my @me = @$me;
        $me[0] += 2;
        $me[1] -= 73; $me[2] += 73;
        simulate_boss({%$spell},\@me,\@boss);
    }

    if( $me->[1] >= 113 and not $spell->{shield}) {
        say ' 'x $I, "shield!";
        local $I = $I +1;
        my @boss = @$boss;
        my @me = @$me;
        $me[1] -= 113; $me[2] += 113;
        simulate_boss({ %$spell, shield => 6 },\@me,\@boss);
    }

    if( $me->[1] >= 173 and not $spell->{poison} ) {
        say ' 'x $I, "poison!";
        local $I = $I +1;
        my @boss = @$boss;
        my @me = @$me;
        $me[1] -= 173; $me[2] += 173;
        simulate_boss({ %$spell, poison => 6},\@me,\@boss);
    }

    if( $me->[1] >= 229 and not $spell->{recharge} ) {
        say ' 'x $I, "recharge!";
        local $I = $I +1;
        my @boss = @$boss;
        my @me = @$me;
        $me[1] -= 229; $me[2] += 229;
        simulate_boss({ %$spell, recharge => 5},\@me,\@boss);
    }

    return if not $spell->{recharge};

        say ' 'x $I, "do nothing!";
        local $I = $I +1;
    simulate_boss( {%$spell}, [ @$me ], [ @$boss ] );

}

sub simulate_boss($spell, $me, $boss ) {
    spell_effect($spell, $me, $boss);

    return if game_over($me,$boss);

    say ' 'x $I, "boss health: ", $boss->[0];

    $me->[0] -= max 0, $boss->[1] - ( $spell->{shield} ? 7 : 0 );

    return if game_over($me,$boss);

    simulate_me( $spell, $me, $boss );
}

sub game_over($me,$boss) {
    if( $me->[0] <= 0 ) {
        say ' 'x $I, "dead :-(";
        return 1; # X.X
    }
    if( $boss->[0] <= 0 ) {
        say ' 'x $I, "WON!";
        $min_mana = min $min_mana, $me->[2];
        return 1;
    }
    return;
}

sub spell_effect( $spell, $me, $boss ) {

    if( $spell->{recharge} ) {
        $me->[1] += 101;
    }

    if( $spell->{poison} ) {
        $boss->[0] -= 3;
    }

    $_-- for grep { $_ } values %$spell;

}

