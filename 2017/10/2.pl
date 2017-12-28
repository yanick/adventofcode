use 5.20.0;

use List::AllUtils qw/ reduce part /;

my $e = <>;
chomp $e;
my @commands = map { ord } split '', $e;
#pop @commands;
push @commands, 17, 31, 73, 47, 23;

my $skip = 0;

my $i = 0;
my @array = 0..255;

for ( 1..64 ) {
for my $c ( @commands ) {
    @array[0..$c-1] = @array[ reverse 0..$c-1];
    push @array, shift @array for 1..$c + $skip++;
    $i += $c + $skip-1;
}
}

unshift @array, pop @array for 1..($i%@array);
say "@array";

my $j;
my @grouped = map {
    reduce { $a ^ $b } @$_
} part { $j++ / 16 } @array;

use DDP;
p @grouped;
say map { sprintf "%02x", $_ }  @grouped;


