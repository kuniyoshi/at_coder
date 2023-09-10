#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @j = grep { $n % $_ == 0 } 1 .. 9;

my @results;

OUT:
for ( my $i = 0; $i <= $n; ++$i ) {
    for my $j ( @j ) {
        if ( $i % ( $n / $j ) == 0 ) {
            push @results, $j;
            next OUT;
        }
    }
    push @results, q{-};
}

say join q{}, @results;

exit;
