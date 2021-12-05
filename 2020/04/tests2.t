use Test2::V0;

BEGIN { push @INC, '.'; }

use List::AllUtils qw/ pairmap /;
use part2;

is { pairmap { $a => !!$b } validate_passport(
    pid => '087499704',  hgt => '74in',
    ecl => 'grn', iyr => 2012,  eyr => 2030,  byr => 1980,
    hcl => '#623a2f')
} => {
    map {
    $_ => 1 } qw/ pid hgt ecl iyr eyr byr hcl /
};

is valid_passports_2('input') => 131;

done_testing();
