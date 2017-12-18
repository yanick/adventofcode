use 5.20.0;
use experimental qw/ signatures postderef /;
use List::AllUtils qw/ any /;

my @commands = <>;

my @prog = map { bless 
 { q => [], id => $_, reg => { p => $_ },  }, 'Prog'
} 0..1;

use DDP; 

my $sent1;


package Prog {
    my $vr = qr/(?<val>-?\d+|.)/;

    sub valof($self, $x) {
        $x =~ /\d/ ? $x : $self->{reg}{$x};
    }

    sub run($self) {
        while() {
            use DDP;
            my $i = $self->{i};
            my $c = $commands[$i] or return;

            if( $c =~ /snd (.)/ ) {
                warn ++$sent1 if $self->{id};
                push $prog[ 1 - $self->{id} ]->{q}->@*, $self->valof($1);
            }
            elsif( $c =~ /set (.) $vr/ ) {
                $self->{reg}{$1} = $self->valof($2);
            }
            elsif( $c =~ /add (.) $vr/ ) {
                $self->{reg}{$1} += $self->valof($2);
            }
            elsif( $c =~ /mul (.) $vr/ ) {
                $self->{reg}{$1} *= $self->valof($2);
            }
            elsif( $c =~ /mod (.) $vr/ ) {
                $self->{reg}{$1} %= $self->valof($2);
            }
            elsif( $c =~ /jgz (.) $vr/ ) {
                $self->{i} += ($self->valof($1) > 0) ? $self->valof($2) : 1;
                next;
            }
            elsif( $c =~ /rcv (.)/ ) {
                return unless $self->{q}->@*;
                my $j = shift $self->{q}->@*;
                $self->{reg}{$1} = $j;
            }
            else { die "wut? $_"; }

            $self->{i}++;

        }
    }
}

while() {
    $prog[1]->run;
    $prog[0]->run;
    # p @prog;
    # my $dummy = <STDIN>;
    warn join ":", map { $_->{i} } @prog;
    last unless any { scalar $_->@* } map { $_->{q} } @prog;
    last if 2 == grep { $_  >= @commands  } map { $_->{i} } @prog;
}

say $sent1;

