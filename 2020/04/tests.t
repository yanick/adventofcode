use Test::More;

BEGIN { push @INC, '.'; }

use part1;

is valid_passports('test') => 2;

is valid_passports('input') => 210;

done_testing();
