use 5.20.0;
use List::AllUtils qw/ sum /;

while(<>){
    chomp;
    $::l += 2;
    use DDP;
    s/\\(\\|"|x[a-f0-9]{2})(?{$::l +=length $1})//g;
    warn $_;
}

say $::l;
