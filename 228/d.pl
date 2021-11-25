#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $q = <> );
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

my $n = 2 ** 20;
my @a = ( -1 ) x $n;
my @points = 0 .. ( $n - 1 );

for my $query_ref ( @queries ) {
    my( $operation, $x ) = @{ $query_ref };

    if ( $operation == 1 ) {
        my $index = dfs( $x );
        die "somehow \$index: $index"
            if $a[ $index ] != -1;
        $a[ $index ] = $x;
    }

    if ( $operation == 2 ) {
        say $a[ $x % $n ];
    }
}

exit;

sub dfs {
    my $h = shift;

    if ( $a[ $points[ $h % $n ] ] == -1 ) {
        return $points[ $h % $n ];
    }

    my $index = dfs( $points[ $h % $n ] + 1 );

    $points[ $h % $n ] = $index;

    return $index;
}
