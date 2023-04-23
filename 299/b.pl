#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $t ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @c = do { chomp( my $l = <> ); split m{\s}, $l };
my @r = do { chomp( my $l = <> ); split m{\s}, $l };

my %count;
$count{ $_ }++
    for @c;
my $color = $count{ $t } ? $t : $c[0];

my( $winner ) = map { $_->[0] }
                sort { $b->[1] <=> $a->[1] }
                map { [ $_, $r[ $_ ] ] }
                grep { $c[ $_ ] == $color }
                0 .. $n - 1;

say $winner + 1;

exit;
