use 5.20.0;

my $input = 3004953;

my @elves = 1..$input;

while( @elves > 1 ) {
    say $elves[0];
    push @elves, shift @elves;
    shift @elves;
}

say @elves;
