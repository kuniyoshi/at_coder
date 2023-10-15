#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my %count;
$count{ $_ }++
    for @a;

my $total = 0;
$total += combination3( $_ )
    for values %count;

say $total;

exit;

sub combination3 {
    my $count = shift;
    return 0
        if $count < 3;
    return $count * ( $count - 1 ) * ( $count - 2 ) / 3 / 2 / 1;
}
