#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $w, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my( $x1, $y1, $x2, $y2 ) = do { chomp( my $l = <> ); split m{\s}, $l };

my @dp = map { Mod->new } 1 .. 4;

my $index = ( $x1 != $x2 ) << 1 | ( $y1 != $y2 ) << 0;
$dp[ $index ]->set( 1 );

for ( my $i = 1; $i <= $k; ++$i ) {
    my @values = map { $_->value } @dp;
    $dp[0]->set( $values[1] )->add( $values[2] );
    $dp[1]->set( $h - 1 )->multiply( $values[0] )->add( ( $h - 2 ) * $values[1] )->add( $values[3] );
    $dp[2]->set( $w - 1 )->multiply( $values[0] )->add( ( $w - 2 ) * $values[2] )->add( $values[3] );
    $dp[3]->set( $w - 1 )->multiply( $values[1] )->add( ( $h - 1 ) * $values[2] )->add( ( $h - 2 + $w - 2 ) * $values[3] );

    #    $dp[ $i ][0] = $dp[ $i - 1 ][1] + $dp[ $i - 1 ][2];
    #    $dp[ $i ][1] = ( $h - 1 ) * $dp[ $i - 1 ][0] + ( $h - 2 ) * $dp[ $i - 1 ][1] + $dp[ $i - 1 ][3];
    #    $dp[ $i ][2] = ( $w - 1 ) * $dp[ $i - 1 ][0] + ( $w - 2 ) * $dp[ $i - 1 ][2] + $dp[ $i - 1 ][3];
    #    $dp[ $i ][3] = ( $w - 1 ) * $dp[ $i - 1 ][1] + ( $h - 1 ) * $dp[ $i - 1 ][2] + ( $h - 2 + $w - 2 ) * $dp[ $i - 1 ][3];
}

say $dp[0]->value;

exit;

package Mod;

use utf8;
use strict;
use warnings;

sub mod {
    return 998244353;
}

sub new {
    my $class = shift;
    my $value = shift // 0;
    return bless \$value, $class;
}

sub multiply {
    my $self = shift;
    my $value = shift;
    $$self = ( $$self * $value ) % $self->mod;
    return $self;
}

sub add {
    my $self = shift;
    my $value = shift;
    $$self = ( $$self + $value ) % $self->mod;
    return $self;
}

sub value {
    my $self = shift;
    return $$self;
}

sub set {
    my $self = shift;
    my $value = shift;
    $$self = $value;
    return $self;
}
