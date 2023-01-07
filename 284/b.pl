#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $t = <> );

while ( $t-- ) {
    chomp( my $n = <> );
    my @a = do { chomp( my $l = <> ); split m{\s}, $l };
    say scalar grep { $_ % 2 } @a;
}

exit;
