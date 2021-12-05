package part1;

use 5.20.0;
use warnings;

use experimental qw/
  signatures
  postderef
  switch
  /;

use parent qw/ Exporter::Tiny /;

our @EXPORT = qw/ resolve /;

sub resolve($code) {
    my @row    = ( 0, 127 );
    my @column = ( 0, 7 );

    for ( split '', $code ) {
        when ('F') { $row[1] = $row[0] + int( ( $row[1] - $row[0] ) / 2 ) }
        when ('B') { $row[0] = $row[0] + 1 + int( ( $row[1] - $row[0] ) / 2 ) }
        when ('L') {
            $column[1] = $column[0] + int( ( $column[1] - $column[0] ) / 2 )
        }
        when ('R') {
            $column[0] = $column[0] + 1 +
              int( ( $column[1] - $column[0] ) / 2 )
        }

    }

    return 8 * $row[0] + $column[0];
}
