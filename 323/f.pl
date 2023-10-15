#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $xa, $ya, $xb, $yb, $xc, $yc ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = ( $xa, $ya );
my @b = ( $xb, $yb );
my @c = ( $xc, $yc );

# C が原点になるように移動する
$a[0] -= $c[0];
$a[1] -= $c[1];
$b[0] -= $c[0];
$b[1] -= $c[1];
@c = ( 0, 0 );

# B の x, y が 0 以上になるように移動する
if ( $b[0] < 0 ) {
    $b[0] *= -1;
    $a[0] *= -1;
}

if ( $b[1] < 0 ) {
    $b[1] *= -1;
    $a[1] *= -1;
}

my %link;
my %distance;


$link{ "0:0" } = [ join( q{:}, 

# A が B の右上にいる場合
if ( $a[0] > $b[0] && $a[1] > $b[1] ) {
    # 答え: distance( 原点, B ) + distance( A, B )
    {
        my $md = abs( $b[0] - $a[0] ) + abs( $b[1] - $a[1] );
    }
    exit;
}
elsif ( 

my @dbc = ( abs( $c[0] - $b[0] ), abs( $c[1] - $b[1] ) );
my 

my $dcbx = $c[0] - $b[0];
my $dcby = $c[1] - $b[1];

my @candidates;

if ( $dcbx > 0 ) {
    push @candidates, "left";
}
elsif ( $dcbx < 0 ) {
    push @candidates, "right";
}

if ( $dcby > 0 ) {
    push @candidates, "bottom";
}
elsif ( $dcby < 0 ) {
    push @candidates, "top";
}

die "somehow"
    unless @candidates;

my( undef, $candidate, $point ) = select_position( @candidates );

my $steps = delta2( \@a, $point, \@b );
#warn "\$steps: $steps";
#warn "\$candidate: $candidate";
#warn Dumper $point;

if ( $candidate eq "left" ) {
    $steps += abs $dcbx;
    $steps += 2
        if abs $dcby;
    $steps += abs $dcby;
}
elsif ( $candidate eq "right" ) {
    $steps += abs $dcbx;
    $steps += 2
        if abs $dcby;
    $steps += abs $dcby;
}
elsif ( $candidate eq "bottom" ) {
    $steps += abs $dcby;
    $steps += 2
        if abs $dcbx;
    $steps += abs $dcbx;
}
else {
    $steps += abs $dcby;
    $steps += 2
        if abs $dcbx;
    $steps += abs $dcbx;
}

say $steps;

exit;

sub delta2 {
    my( $a, $p, $b ) = @_;
    if ( $a->[0] == $p->[0] == $b->[0] ) {
        return delta( $a, $p ) + 2;
    }

    if ( $a->[1] == $p->[1] == $b->[1] ) {
        return delta( $a, $p ) + 2;
    }

    return delta( $a, $p );
}

sub select_position {
    my @directions = @_;

    my @zip;

    for ( my $i = 0; $i < @directions; ++$i ) {
        my @n = @b;
        if ( $directions[ $i ] eq "left" ) {
            $n[0]--;
            my $cost = delta( \@a, \@n );
            $cost += 4
                if $a[0] == $n[0] == $b[0];
            push @zip, [ $cost, $directions[ $i ], \@n ];
        }
        elsif ( $directions[ $i ] eq "right" ) {
            $n[0]++;
            my $cost = delta( \@a, \@n );
            $cost += 4
                if $a[0] == $n[0] == $b[0];
            push @zip, [ $cost, $directions[ $i ], \@n ];
        }
        elsif ( $directions[ $i ] eq "bottom" ) {
            $n[1]--;
            my $cost = delta( \@a, \@n );
            $cost += 4
                if $a[1] == $n[1] == $b[1];
            push @zip, [ $cost, $directions[ $i ], \@n ];
        }
        else {
            $n[1]++;
            my $cost = delta( \@a, \@n );
            $cost += 4
                if $a[1] == $n[1] == $b[1];
            push @zip, [ $cost, $directions[ $i ], \@n ];
        }
    }

    @zip = sort { $a->[0] <=> $b->[0] } @zip;

    return @{ $zip[0] };
}

sub delta {
    my( $a, $b ) = @_;
    return abs( $a->[0] - $b->[0] ) + abs( $a->[1] - $b->[1] );
}
