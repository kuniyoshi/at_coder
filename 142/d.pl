#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };

my %da = divisors( $a );
my %db = divisors( $b );

my %set;
$set{ $_ }++
    for keys %da, keys %db;

say scalar grep { $set{ $_ } == 2 } keys %set;

exit;

sub divisors {
    my $n = shift;
    my %result;
    my $sqrt = sqrt( $n );
    for my $v ( 2 .. $sqrt ) {
        while ( $n % $v == 0 ) {
            $result{ $v }++;
            $n /= $v;
        }
    }
    $result{ $n }++;
    $result{1} = 1;
    return %result;
}
