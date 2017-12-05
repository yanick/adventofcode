use 5.20.0;
use experimental 'signatures';

my $alpha = join '', 'a'..'z';
my $seq = join '|', map { substr $alpha, $_, 3 } 0..length($alpha)-3;
$seq = qr/$seq/;


my $password = <>;
chomp($password);

1 until is_valid(++$password);
1 until is_valid(++$password);
say $password;

sub is_valid($p) {
    return 0 if $p =~ /[iol]/;
    return 0 unless $p =~ /(.)\1.*?(.)\2/;
    return $p =~ $seq;
}
