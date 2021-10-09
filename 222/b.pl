#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $head = <> );
my( $n, $p ) = split m{\s}, $head;

chomp( my $line = <> );
my @a = split m{\s}, $line;

my $count = grep { $_ < $p } @a;

say $count;


exit;
