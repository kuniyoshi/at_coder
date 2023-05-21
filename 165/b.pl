#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use POSIX qw( ceil );

chomp( my $x = <> );

# 100 * 1.01 ^ y >= x
# 1.01 ^ y >= x / 100
# y >= log( x / 100 ) / log( 1.01 )

my $count = 0;
my $acc = 100;

while ( $acc < $x ) {
    use integer;
    my $add = $acc / 100;
    $acc += $add;
    $count++;
}

say $count;

exit;
