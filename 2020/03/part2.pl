use 5.20.0;
use warnings;

use experimental qw/
    signatures
    postderef
/;

use Path::Tiny;

my @forest = path(shift)->lines({chomp => 1 });


sub go_down($forest,$right,$down=1) {
    my $trees = 0;
    my @forest = @$forest;

    my $line = shift @forest;
    my $i = 0;

    use DDP;

    while( $line) {


        $trees++ if '#' eq substr $line, $i, 1;
        $i+=$right;
        $i %= length $line;

        $line = shift @forest for 1..$down;
    }

    return $trees
}

use List::AllUtils qw/ product /;
$, = " ";
print product map { go_down([@forest],@$_) } (
    [1,1],
    [3,1],
    [5,1],
    [7,1],
    [1,2],
)


