#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );
my @p = do { chomp( my $l = <> ); split m{\s}, $l };
my $max = max( @p );

if ( $p[0] != $max ) {
    say $max - $p[0] + 1;
}
else {
    my @how_many = grep { $_ == $max } @p;
    say scalar( @how_many ) > 1 ? 1 : 0;
}



exit;
