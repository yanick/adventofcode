use 5.20.0;

use MoobX;

use experimental qw/ postderef signatures /;

my @bot;
my @output : Observable;

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
        my( $obs, $t1, $low, $t2, $high ) = ( $1, $2, $3, $4, $5 );
        autorun {
            state $last = 0;

            return if $last == bot($obs)->@*;

            my @a = bot($obs)->@*;
            $last = @a;
            
            return if @a != 2;

            say $obs;
            say $low, " ", $high;

            my @s = sort { $a <=> $b } @a;

            if ( $t1 eq 'bot' ) {
                push bot($low)->@*, $s[0];
            }
            else {
                $output[$low] = $s[0];
            }

            if ( $t2 eq 'bot' ) {
                push bot($high)->@*, $s[1];
            }
            else {
                $output[$high] = $s[0];
            }
        };
    }
}

use DDP;

p @output;
