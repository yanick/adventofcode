use 5.20.0;

my @commands = <>;

my $i = 0;

my %reg;
my $last_played;

use experimental qw/ signatures /;

sub valof($x) {
    $x =~ /\d/ ? $x : $reg{$x};
}

my $vr = qr/(-?\d+|.)/;

my $times;

use DDP;

my $t;
while() {
    last if $i < 0 or $i > $#commands;
    $_ = $commands[$i++];
#    say $_;


    if( /set (.) $vr/ ) {
        $reg{$1} = valof($2);
    }
    elsif( /sub (.) $vr/ ) {
        $reg{$1} -= valof($2);
    }
    elsif( /mul (.) $vr/ ) {
        $reg{$1} *= valof($2);
        $times++;
        die if $times > 10_000;
#        say $times;
    }
    elsif( /jnz (.) $vr/ ) {
        $i += -1 + valof($2) if valof($1) != 0;
    }
    else { die "wut? $_"; }

#    say $_;
#    p %reg ;#unless $t++ % 10_000;
    #   my $dummy = <STDIN>;

}

say $times;
