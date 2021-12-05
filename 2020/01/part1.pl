use 5.20.0;
use warnings;

use Path::Tiny;

my @expenses = path('input')->lines;

while(my $this = shift @expenses) {
    my $that = 2020 - $this;
    next unless grep { $_ == $that } @expenses;

    print join " ", $this, $that, $this*$that;
}
