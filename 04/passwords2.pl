use 5.20.0;
use List::AllUtils qw/ uniq sum /;

say sum map {
    my @u = uniq @$_;
    @u == @$_;
}
map { [ map { sortify($_) } @$_ ] }
map { chomp; [ split ] } <>;

sub sortify {
    join '', sort split '', shift;
}
