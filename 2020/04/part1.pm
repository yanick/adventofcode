use 5.20.0;
use warnings;

use Path::Tiny;
use List::AllUtils qw/all/;

use parent qw/ Exporter/;

use experimental qw/
  signatures
  postderef
  /;

our @EXPORT = qw/ valid_passports /;

sub valid_passports($file) {
    my $data = path($file)->slurp;

    my @passports = map { +{ split /:| |\n/ } } split "\n\n", $data;

    return scalar grep {
        my $p = $_;
        all { $p->{$_} } qw/ byr iyr eyr hgt hcl ecl pid /
    } @passports;
}
