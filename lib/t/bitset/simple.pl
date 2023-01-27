#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Bitset;

my $bitset = Bitset->new( 7 )->one;
$bitset->shift_left( 3 );
say q{[}, $bitset->dump, q{]};

exit;
