use 5.20.0;

my @commands = split ',', scalar <>;
my $skip = 0;

my $i = 0;
my @array = 0..255;

for my $c ( @commands ) {
    @array[0..$c-1] = @array[ reverse 0..$c-1];
    push @array, shift @array for 1..$c + $skip++;
    $i += $c + $skip-1;
    say "@array";
    warn "index: $i";
}

warn $i;
unshift @array, pop @array for 1..($i%@array);
    say "@array";

say $array[0] * $array[1];
