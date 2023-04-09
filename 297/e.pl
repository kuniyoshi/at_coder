#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my %values;
$values{ $_ }++
    for @a;

my @values = sort { $a <=> $b } keys %values;

my $ac = $values[0];
my $wa = $values[-1] * $k + 1;

while ( $wa - $ac > 1 ) {
    my $wj = int( ( $wa + $ac ) / 2 );
    if ( t( $wj ) ) {
        $ac = $wj;
    }
    else {
        $wa = $wj;
    }
}

say $ac;

exit;

sub t {
    my $v = shift;
    my %set = ( 0 => 1 );
    for my $value ( @values ) {
        for my $key ( keys %set ) {
            my $w = $key + $value;
            while ( $w < $v ) {
                $set{ $w }++;
                $w += $value;
            }
        }
    }
    delete $set{0};
    return( scalar( %set ) <= $k );
}
