use 5.20.0;
use experimental qw/ signatures /;

my $compressed = <>;
chomp $compressed;

say decompress($compressed);

sub decompress($s) {
    warn $s;
    my $decompressed = 0;

    while( $s =~ s/^(.*?)\((\d+)x(\d+)\)// ) {
        my( $prefix, $l, $r ) = ( $1,$2,$3);
        $decompressed += length $prefix;
        $decompressed += $r * decompress( substr $s, 0, $l, '' );
    }

    return $decompressed + length $s;
}
