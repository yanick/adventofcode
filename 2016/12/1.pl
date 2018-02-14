use 5.20.0;

undef $/;
my $code = <>;

$code =~ s/\b([a-d])\b/\$$1/g;

$code =~ s/cpy (\S+) (\S+)/$2 = $1/g;

$code =~ s/inc (\S+)/$1++/g;
$code =~ s/dec (\S+)/$1--/g;


my $i = 1;
$code =   
    join "\n",
    map { $_->[1] }
    map { 
        $_->[1] =~ s/jnz (\S+) (\S+)/"if($1){ goto LINE_" . ( $_->[0] + $2 ) . "}"/e;
        $_ } 
    map { $_->[1] = "LINE_" . $_->[0] . ': ' . $_->[1]; $_ }
    map { [ $i++, $_ ] } grep { length } split /\n/, $code;

$code =~ s/$/;/mg;

my( $c, $d) = ( 1,0);
eval $code;

die $@ if $@;

say $a;

__END__
use Scalar::Util qw/ looks_like_number /;

my $i  = 0;
my @instructions = map { "LINE_" . $i++ . ': ' . $_ } <>;


my %reg;

while ( my $c = $instructions[$i++] ) {
    say $i;
    use DDP;
    p %reg;
    if( $c =~ /cpy (\S+) (.)/ ) {
        $reg{$2} = looks_like_number($1) ? $1 : $reg{$1};
    }
    elsif ( $c =~ /(inc|dec) (.)/ ) {
        $reg{$2} += ($1 eq 'inc') ? 1 : -1;
    }
    elsif( $c =~ /jnz (.) (.*)/ ) {
        $i += -1 + $2 if $reg{$1};
    }
    else { die }
    my $x = <STDIN>;
}

say $reg{a};
