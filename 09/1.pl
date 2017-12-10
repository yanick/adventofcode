use 5.20.0;

my $stream = <>;
chomp $stream;

$stream = clean_stream($stream);

use Text::Balanced qw/ extract_bracketed /;
use List::AllUtils qw/ sum /;

use experimental qw/signatures /;

say score( $stream );

sub score($stream,$level=1) {

    $stream =~ s/.*?\{(.*)\}.*?/$1/;
    my @children;
    my $extracted;
    while( length $stream ) {
        ( $extracted, $stream ) = extract_bracketed( $stream, '{}', qr/,?/ );
        push @children, $extracted if length $extracted;
        $stream =~ s/^,|,$//;
    }

    return sum $level, map { score($_,$level+1) } @children;


}

sub clean_stream {
    my $s = shift;

    return $s unless $s =~ s/^(.*?)<//;

    my $clean = $1;

    while( $s =~ s/^.*?(!!|!>|>)// ) {
        last if $1 eq '>';
    }

    return $clean . clean_stream($s);
}
