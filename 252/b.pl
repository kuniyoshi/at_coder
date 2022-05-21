#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

my( $n, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @b = do { chomp( my $l = <> ); split m{\s}, $l };

my $max = max( @a );
my @candidates = map { $_ + 1 }
                 grep { $a[ $_ ] == $max } 0 .. $#a;

my %is_hating;
$is_hating{ $_ }++
    for @b;

my $may_be = grep { $is_hating{ $_ } } @candidates;

say YesNo::get( $may_be );


exit;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
