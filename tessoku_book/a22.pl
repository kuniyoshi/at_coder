#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );
use Memoize;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @b = do { chomp( my $l = <> ); split m{\s}, $l };

my @dp = ( -1e9 ) x ( $n + 1 );
$dp[1] = 0;

for ( my $i = 1; $i < $n; ++$i ) {
    u( \$dp[ $a[ $i - 1 ] ], $dp[ $i ] + 100 );
    u( \$dp[ $b[ $i - 1 ] ], $dp[ $i ] + 150 );
}

say $dp[ $n ];

exit;

sub u {
    my $ref = shift;
    my $new = shift;
    $$ref = max( $$ref, $new );
}

__END__

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @b = do { chomp( my $l = <> ); split m{\s}, $l };

my @dp = ( -1e6 ) x ( $n + 1 );
$dp[1] = 0;

for ( my $i = 1; $i < $n; ++$i ) {
    $dp[ $a[ $i ] ] = max( $dp[ $a[ $i ] ], $dp[ $i ] + 100 );
    $dp[ $b[ $i ] ] = max( $dp[ $b[ $i ] ], $dp[ $i ] + 150 );
}

say $dp [ $n ];


__END__

memoize( "dfs" );

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @b = do { chomp( my $l = <> ); split m{\s}, $l };

my @to = map { [ ] } 1 .. $n;

for ( my $i = 0; $i < $n - 1; ++$i ) {
    push @{ $to[ $a[ $i ] ] }, [ $i + 1, 100 ];
    push @{ $to[ $b[ $i ] ] }, [ $i + 1, 150 ];
}

say dfs( $n );

exit;


sub dfs {
    my $cursor = shift;
    return max( map { $_->[1] + dfs( $_->[0] ) } @{ $to[ $cursor ] } ) // 0;
}

__END__

my @dp = ( 0 ) x ( $n + 1 );

for ( my $i = 1; $i < $n; ++$i ) {
    u( \$dp[ $a[ $i - 1 ] ], $dp[ $i ] + 100 );
    u( \$dp[ $b[ $i - 1 ] ], $dp[ $i ] + 150 );
}

die Dumper \@dp;
say $dp[ $n ];

exit;

sub u {
    my $ref = shift;
    my $new = shift;
    $$ref = max( $$ref, $new );
}
