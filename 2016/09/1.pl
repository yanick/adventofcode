use 5.20.0;

my $compressed = <>;
chomp $compressed;

my $decompressed = '';

while( $compressed =~ s/^(.*?)\((\d+)x(\d+)\)// ) {
    $decompressed .= $1 . ( substr $compressed, 0, $2, '' ) x $3;
}

say length $decompressed;
