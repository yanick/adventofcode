use 5.20.0;

my @commands = <>;

my $i = 0;

my %reg;
my $last_played;

use experimental qw/ signatures /;

sub valof($x) {
    my $y = $x =~ /\d/ ? $x : $reg{$x};
    die $_ if $y eq 'Inf';
    return $y;
}

my $vr = qr/(-?\d+|.)/;

while() {
    $_ = $commands[$i++];
    warn $_ if /\bb\b/;
    if( /snd (.)/ ) {
        $last_played = valof($1);
    }
    elsif( /set (.) $vr/ ) {
        $reg{$1} = valof($2);
    }
    elsif( /add (.) $vr/ ) {
        $reg{$1} += valof($2);
    }
    elsif( /mul (.) $vr/ ) {
        $reg{$1} *= valof($2);
    }
    elsif( /mul (.) $vr/ ) {
        $reg{$1} *= valof($2);
    }
    elsif( /mod (.) $vr/ ) {
        $reg{$1} %= valof($2);
    }
    elsif( /jgz (.) $vr/ ) {
        next unless $reg{$1} > 0;
        $i += -1 + valof($2);
    }
    elsif( /rcv (.)/ ) {
        next unless $reg{$1};
        die $last_played;
    }
    else { die "wut? $_"; }

}
