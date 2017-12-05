use 5.20.0;

my $s = <>;
chomp $s;
say $s;


$s =~ s/(.)\1*/ length($&) . $1 /eg for 1..40;

say $s;
say length $s;

