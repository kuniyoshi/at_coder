#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my @accs = @a;

for my $i ( 0 .. $m - 1 ) {
    warn Dumper \@accs;
    my @new = ( 0 );
    for my $acc ( @accs ) {
        push @new, $new[-1] + $acc;
    }
    @accs = @new;
}

for ( my $i = 0; $i < @accs; ++$i ) {
    next
        if $i < 2 * $m;
}

exit;
