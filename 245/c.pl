#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Memoize qw( memoize );

my( $n, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @b = do { chomp( my $l = <> ); split m{\s}, $l };

my $k2 = $k * $k;

my @dp;

for my $index ( 0 .. $n - 1 ) {
    $dp[ $index ][0] = 1;
    $dp[ $index ][1] = 1;
}

for my $index ( 1 .. $n - 1 ) {
    my @candidates;

    if ( $dp[ $index - 1 ][0] ) {
        push @candidates, \@a;
    }
    if ( $dp[ $index - 1 ][1] ) {
        push @candidates, \@b;
    }

    $dp[ $index ][0] = grep { with_in( $_->[ $index - 1 ] - $a[ $index ] ) } @candidates;
    $dp[ $index ][1] = grep { with_in( $_->[ $index - 1 ] - $b[ $index ] ) } @candidates;
}

my $can = $dp[ $n - 1 ][0] || $dp[ $n - 1 ][1];
say $can ? "Yes" : "No";

exit;

sub with_in {
    my $value = shift;
    return $value * $value <= $k2;
}

__END__
my $can = dfs( 0, 0 ) || dfs( 0, 1 );
say $can ? "Yes" : "No";

exit;

sub dfs {
    my( $index, $previous ) = @_;

    return 1
        if $index == $n - 1;

    my $ref = $previous == 0 ? \@a : \@b;

    my $x = $ref->[ $index ] - $a[ $index + 1 ];
    my $y = $ref->[ $index ] - $b[ $index + 1 ];

    return
        if $x * $x > $k2 && $y * $y > $k2;

    if ( $x * $x > $k2 ) {
        return dfs( $index + 1, 1 );
    }

    if ( $y * $y > $k2 ) {
        return dfs( $index + 1, 0 );
    }

    return dfs( $index + 1, 0 ) || dfs( $index + 1, 1 );
}

__END__
my $k2 = $k * $k;

for my $index ( 0 .. $n - 2 ) {
    my $v = $a[ $index ] - $a[ $index + 1 ];
    my $w = $a[ $index ] - $b[ $index + 1 ];
    my $x = $b[ $index ] - $a[ $index + 1 ];
    my $y = $b[ $index ] - $b[ $index + 1 ];

    if ( $v * $v > $k2 && $w * $w > $k2 && $x * $x > $k2 && $y * $y > $k2 ) {
        say "No";
        exit;
    }
}

say "Yes";

exit;

__END__

my $can = dfs( 1 );
say $can ? "Yes" : "No";

exit;

sub dfs {
    my $index = shift;

    return 1
        if $index == $n - 1;

    my $x = $a[ $index - 1 ] - $a[ $index ];
    my $y = $a[ $index - 1 ] - $b[ $index ];

    return
        if $x * $x > $k2 && $y * $y > $k2;

    return dfs( $index + 1 );
}
