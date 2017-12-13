use 5.20.0;

my @lines = <>;
chomp for @lines;

my $sequence = pop @lines;
pop @lines;

my %molecules;

for my $s ( @lines ) {
    my( $from, $to ) = split ' => ', $s;
    while( $sequence =~ /\G(.*?)($from)/g ) {
        $molecules{ 
            $` . $1 . $to . $'
        } = 1;
    }
}

say scalar keys  %molecules;


