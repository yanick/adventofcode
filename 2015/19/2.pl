use 5.20.0;
use List::AllUtils qw/ uniq /;

my @lines = <>;
chomp for @lines;

my $sequence = pop @lines;
pop @lines;

my %mutation = reverse map { split ' => ' } @lines;

my $steps = 0;
my @possible = ( $sequence );
my %s = ( $sequence => 0 );

while( not $s{e} ) {
    use DDP;
    warn scalar @possible;

    my $n = shift @possible;

    warn $n;
    my @new = mutate($n);

    for(@new) {
        next if exists $s{$_};
        $s{$_} = $s{$n}+1;
        push @possible, $_;
    }

    @possible = sort { length $a <=> length $b } @possible;

}

say $s{e};

use experimental 'signatures';

sub mutate($sequence) {
    my @molecules;

    while( my( $from, $to ) = each %mutation ) {
#        warn $from;
        while( $sequence =~ /\G(.*?)($from)/g ) {
            push @molecules, $` . $1 . $to . $'
        }
    }

    return @molecules;
}



