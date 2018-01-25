use 5.20.0;

use MoobX;

use experimental qw/ postderef signatures /;

my @bot;

sub bot($i) {
    unless( $bot[$i] ) {
        my @item : Observable;
        $bot[$i] = \@item;
    }
    return $bot[$i];
}

while(<>) {
    if( /value (\d+) goes to bot (\d+)/ ) {
        push bot($2)->@*, $1;
    }


    if( /bot (\d+) gives low to (bot|output) (\d+) and high to (output|bot) (\d+)/ ) {
        my( $obs, $low, $high ) = ( $1, $2, $3 );
        autorun {
            state $last = 0;

            return if $last == bot($obs)->@*;

            my @a = bot($obs)->@*;
            $last = @a;
            
            return if @a != 2;

            say $obs;
            say $low, " ", $high;

            my @s = sort { $a <=> $b } @a;
            die $obs if $s[0] == 17 and $s[1] == 61;

            #  say $obs, 'x';
            push bot($low)->@*, $s[0];
            #say $obs, 'y';
            push bot($high)->@*, $s[1];
            #say $obs, 'z';
        };
    }
}

use DDP;

p @bot;
