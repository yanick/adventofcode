use 5.20.0;

use Grid::Transform;

my %transform;
my $i = 0;
while(<>) {
    chomp;
    s/\///g;
    my ($from,$to) = split ' => ';

    my @from  = split '', $from;
    my $gt = Grid::Transform->new( \@from, rows => sqrt @from );

    for my $t ( 
        map { $_, $_->copy->rotate90, $_->copy->rotate180, $_->copy->rotate270 }
        map { $_, $_->copy->flip_vertical } $gt ) {
        $transform{ join '', $t->grid} = $to;
    }
}

use DDP;
#p %transform;

my @grid =  ([qw/ . # . /], [qw/ . . # /], [qw/ # # # /] );

for( 1..18 ) {
my @new_grid;
if( not @grid % 2 ) {
    for my $x ( 0..$#grid/2 ) {
        for my $y ( 0..$#grid/2 ) {
            transform_2(\@grid,\@new_grid,$x,$y);
        }
    }
}
else {
    for my $x ( 0..$#grid/3 ) {
        for my $y ( 0..$#grid/3 ) {
            transform_3(\@grid,\@new_grid,$x,$y);
        }
    }
}

@grid = @new_grid;
}

say scalar grep {  $_ eq '#' } map { @$_ } @grid;

sub transform_2 {
    my ( $grid, $n, $x, $y ) = @_;
    my $k;
    for my $i ( 0..1 ) {
        for my $j ( 0..1 ) {
            $k .= $grid->[2*$x+$i][2*$y+$j];
        }
    }
    my @new = split '', $transform{$k};
    my ($r,$c) = ($x,$y);
    for my $k ( 0..2 ) {
        $n->[3*$r+$k] ||= [];
        $n->[3*$r+$k][3*$c+$_] = shift @new for 0..2;
    }
}

sub transform_3 {
    my ( $grid, $n, $x, $y ) = @_;
    my $k;
    for my $i ( 0..2 ) {
        for my $j ( 0..2 ) {
            $k .= $grid->[3*$x+$i][3*$y+$j];
        }
    }
    my @new = split '', $transform{$k};
    my ($r,$c) = ($x,$y);
    for my $k ( 0..3 ) {
        $n->[4*$x+$k] ||= [];
        $n->[4*$x+$k][4*$c+$_] = shift @new for 0..3;
    }
}
