use 5.20.0;

my $script = "\$a = 1;\n";
while(<>) {
    s/\b[a-h]\b/\$$&/g;
    s/sub (\S+) (\S+)/$1 -= $2;/;
    s/set (\S+) (\S+)/$1 = $2;/;
    s/mul (\S+) (\S+)/$1 *= $2;/;
    s/jnz (\S+) (\S+)/"goto L" . ($. + $2) . " if $1;"/e;
    s/^/L${.}: /;
    $script .= $_;
}

for ( 1..35 ) {
    my @c = $script =~ /(L$_: )/g;
    next if @c > 1;
    $script =~ s/L$_: //g;
}

print $script;

__END__

my $i = 0;

my %reg = ( a => 1);
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
    }
    elsif( /jnz (.) $vr/ ) {
        $i += -1 + valof($2) if valof($1) != 0;
    }
    else { die "wut? $_"; }

    say $i;
#    say $_;
    p %reg unless $t++ % 10_000;
    #   my $dummy = <STDIN>;

}

say $reg{h};
