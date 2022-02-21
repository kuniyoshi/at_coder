#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my @stack;
my $count = 0;

for $a ( @a ) {
    if ( !@stack ) {
        push @stack, [ $a, 1 ];
        $count++;
        say $count;
        next;
    }

    if ( $stack[-1][0] != $a ) {
        push @stack, [ $a, 1 ];
        $count++;
        say $count;
        next;
    }

    $stack[-1][1]++;
    $count++;

    while ( @stack && $stack[-1][1] >= $stack[-1][0] ) {
        $stack[-1][1] = $stack[-1][1] - $stack[-1][0];
        $count = $count - $stack[-1][0];
        pop @stack
            if $stack[-1][1] == 0;
    }

    say $count;
}


exit;
