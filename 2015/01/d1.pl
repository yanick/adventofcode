use 5.20.0;

say eval <> =~ s/\(/+1/gr =~ s/\)/-1/gr;

