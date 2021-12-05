---
to: '<%= day %>/part2.pm'
---
package part2;

use 5.20.0;
use warnings;
use experimental 'signatures';

use List::AllUtils qw/ /;

require './part1.pm';

use experimental qw/ signatures postderef /;

sub solution() {
}

1;
