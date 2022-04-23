#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @s = do { chomp( my $l = <> ); split m{}, $l };

my $has_large = grep { $_ eq uc } @s;
my $has_small = grep { $_ eq lc } @s;
my $is_unique = do {
    my %count;
    $count{ $_ }++
        for @s;
    !grep { $_ > 1 } values %count
};

my $is_perfect = $has_large && $has_small && $is_unique;

say $is_perfect ? "Yes" : "No";

exit;
