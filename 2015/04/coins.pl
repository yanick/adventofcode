use 5.20.0;

my $s = shift;

use Digest::MD5 qw/ md5_hex /;

my $i = 0;

$i++ until md5_hex( $s . $i ) =~ /^0{5}/;

say $i;


