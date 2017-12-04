use 5.20.0;
use List::AllUtils qw/ sum /;

while(<>){
    chomp;
    $::l += 2;
    use DDP;
    s/(\\|")(?{$::l++})//g;
    warn $_;
}

say $::l;
