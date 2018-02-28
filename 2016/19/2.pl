use 5.20.0;

my $input = 3004953;

my @elves = 1..$input;

my $j;

while( @elves > 1 ) {
    say $elves[0] unless $j++ % 1000;
    splice @elves, @elves/2, 1;
    push @elves, shift @elves;
}

say @elves;
