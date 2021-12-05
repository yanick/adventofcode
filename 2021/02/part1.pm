package part1;

use 5.34.0;
use warnings;
use experimental 'signatures';

use List::AllUtils qw/sum/;

sub group_by(@lines) {
    my %grouped = ();

    for my $line (@lines) {
        my( $action, $move ) = split ' ', $line;
        $grouped{$action} //= [];
        push $grouped{$action}->@*, $move;
    }

    return %grouped;
}

sub solution(@lines) {
   my %grouped = group_by(@lines);

   for my $v (values %grouped) {
       $v = sum @$v;
   }

   my $depth = $grouped{down} - $grouped{up};
   my $forward = $grouped{forward};

   return $depth * $forward;

}

1;
