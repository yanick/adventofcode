use 5.20.0;

use List::AllUtils qw/ sum /;
use File::Serialize;

use experimental 'signatures', 'smartmatch';

my $data = deserialize_file shift;

say add($data);

sub add($data) {
   given ( ref $data ) {
       return sum map { add($_) } @$data when 'ARRAY';
       return ( ( grep { $_ eq 'red' } values %$data ) ? 0 : 1) * sum map { add($_) } values %$data when 'HASH';
       default { return 0 + $data };
   }
}


