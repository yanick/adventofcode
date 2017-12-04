use 5.20.0;
use experimental 'signatures';

my %wire;

while(<>) {
    chomp;
    my( $instructions, $wire ) = split /\s*->\s*/;
    $wire{$wire} = $instructions;
}

my %copy = %wire;
%wire = ( %copy, b => resolve('a') );
say resolve('a');

sub resolve($key,@cycle) {
    die "@cycle" if $key ~~ @cycle;
    push @cycle, $key;
    my $code = $wire{$key};
    #warn $code;

    $code =~ s/\b([a-z]+)\b/resolve($1,@cycle)/ge
        or warn "end of the line $key";

    $code =~ s/NOT/~/;
    $code =~ s/LSHIFT/<</;
    $code =~ s/RSHIFT/>>/;
    $code =~ s/OR/|/;
    $code =~ s/AND/&/;

    die $code if $code =~ /[A-Z]/;

    warn $key, ' -> ', $code;
    $wire{$key} = eval( $code ) || 0;
}

