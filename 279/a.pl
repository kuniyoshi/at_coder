#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

chomp( my $s = <> );
my $count = sum( map { $_ eq q{w} ? 2 : 1 } split m{}, $s );
say $count;

exit;
