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


my @steps;
my @weeks;

for my $a ( @a ) {
    push @steps, $a;

    if ( @steps == 7 ) {
        push @weeks, sum( @steps );
        @steps = ( );

    }
}

push @weeks, sum( @steps )
    if @steps;

say join q{ }, @weeks;

exit;
