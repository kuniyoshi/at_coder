#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $s = <> );

my( $lowers ) = $s =~ m{([a-z]*)}msx;

say length( $lowers ) + 1;

exit;
