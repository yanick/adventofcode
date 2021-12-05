use 5.20.0;
no warnings;

use Path::Tiny;
use List::AllUtils qw/all/;

use parent qw/ Exporter/;

use experimental qw/
  signatures
  postderef
  /;

our @EXPORT = qw/ valid_passports_2 validate_passport /;

my %validator = (
    byr => sub($x) { $x >= 1920 and $x <= 2002 },
    iyr => sub($x) { $x >= 2010 and $x <= 2020 },
    eyr => sub($x) { $x >= 2020 and $x <= 2030 },
    hgt => sub($x) { $x =~ /(in|cm)$/ and (
            $& eq 'in' ? ( $x >= 59 and $x <= 76) :( $x >= 150 and $x <= 193)
        )},
    hcl => sub($x) {
        !!($x =~ /^#[0-9a-f]{6}$/)
    },
    ecl => sub($x) { $x =~ /^(amb|blu|brn|gry|grn|hzl|oth)$/ },
    pid => sub($x) { $x =~ /^\d{9}$/ },
);

use List::AllUtils qw/ pairmap /;

sub validate_passport(%passport) {
    pairmap { $a => $validator{$a}->($b) } %passport;
}

sub valid_passports_2($file) {
    my $data = path($file)->slurp;

    my @passports = map { +{ split /:| |\n/ } } split "\n\n", $data;

    return scalar grep {
        my $p = $_;
        all { $validator{$_}->($p->{$_}) } qw/ byr iyr eyr hgt hcl ecl pid /
    } @passports;
}


