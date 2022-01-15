#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $a, $b, $c ) = do { chomp( my $l = <> ); split m{}, $l };
my $abc = join q{}, ( $a, $b, $c );
my $bca = join q{}, ( $b, $c, $a );
my $cab = join q{}, ( $c, $a, $b );

say $abc + $bca + $cab;

exit;
