#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my $max = max( @a );

my @used = ( 0 ) x ( $max + 2 );

for my $a ( @a ) {
    $used[ $a ]++;
}

for my $index ( 0 .. $#used ) {
    next
        if $used[ $index ];

    say $index;
    exit;
}

die "could not answer";

exit;
