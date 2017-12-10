use 5.20.0;

my $stream = <>;
chomp $stream;

my $garbage;
$stream = clean_stream($stream);

say $garbage;

use experimental qw/signatures /;

sub clean_stream($s) {

    return $s unless $s =~ s/^(.*?)<//;

    while( $s =~ s/^(.*?)(!.|>)// ) {
        warn $1;
        $garbage += length $1;
        last if $2 eq '>';
    }

    clean_stream($s);
}
