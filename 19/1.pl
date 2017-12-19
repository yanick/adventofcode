use 5.20.0;

use List::AllUtils qw/ first_index min max /;
use experimental qw/ postderef smartmatch /;

my @grid = map { chomp; [ ' ', split '' ] } <>;

my @c = ( 0, first_index { $_ eq '|' } $grid[0]->@* );

my @d = (1,0);

use DDP;
p @c;
my $steps;

my $safe = @grid * $grid[0]->@*;
while() {
    die unless $safe--;
    given( $grid[$c[0]][$c[1]] ) {
        print $1 when /([A-Z])/;

        when( '+' ) {
            @d = next_direction();
        }
    }
    $steps++;
    last if $grid[$c[0]][$c[1]] eq 'T';
    $grid[$c[0]][$c[1]] = ' ';
    @c = map { $c[$_] + $d[$_] } 0..1; 

    last if min(@c) < 0;
    last if max(@c) >= $grid[0]->@*;
    # print_around();
#    print @$_ for  @grid;
    #   my $x = <STDIN>;
 }

 say $steps;

sub print_around {
    for my $r ( max(0,$c[0]-5)..$c[0]+5 ) {
        say join '', $grid[$r]->@[ max(0,$c[1]-5)..$c[1]+5 ]
    }
    my $x = <STDIN>;

}

sub next_direction() {
    for( [0,1], [0,-1] ) {
        return @$_ if $grid[$c[0]+$_->[0]][$c[1] + $_->[1]] eq '-';
    }
    for( [1,0], [-1,0] ) {
        return @$_ if $grid[$c[0]+$_->[0]][$c[1] + $_->[1]] eq '|';
    }
    die join ":", @c;
}
