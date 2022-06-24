#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my @batters;

for my $a ( @a ) {
    push @batters, 0;
    for my $i ( 0 .. $#batters ) {
        $batters[ $i ] += $a;
    }
}

say scalar grep { $_ > 3 } @batters;

__END__

my $p = 0;
my @cells = ( 0 ) x 4;

for my $i ( 0 .. $n - 1 ) {
    $cells[0]++;
    my $step = $a[ $i ];

    my @indexes = map { $_ + $step }
                  grep { $cells[ $_ ] }
                  0 .. $#cells;
    my $add = grep { $_ >= 4 } @indexes;
    $p += $add;

    for my $j ( 0 .. $#cells ) {
        $cells[ $j ] = grep { $_ == $j } @indexes;
    }
}

say $p;

exit;
