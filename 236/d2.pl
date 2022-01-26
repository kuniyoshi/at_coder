#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. ( 2 * $n - 1 );

say dfs( [ ], [ 0 .. ( 2 * $n - 1 ) ] );

exit;

sub dfs {
    my $selectins_ref = shift;
    my $buffer_ref = shift;

    unless ( @{ $buffer_ref } ) {
        die "should be 2n"
            unless @{ $selectins_ref } == 2 * $n;

        my $acc = 0;

        for ( my $i = 0; $i < $n; ++$i ) {
            my( $x, $y ) = @{ $selectins_ref }[ 2 * $i, 2 * $i + 1 ];
            die "access violation"
                unless defined $a[ $x ][ $y - $x - 1 ];
            $acc = $acc ^ $a[ $x ][ $y - $x - 1 ];
        }

        return $acc;
    }

    push @{ $selectins_ref }, shift @{ $buffer_ref };

    my $max = 0;

    for ( my $i = 0; $i < @{ $buffer_ref }; ++$i ) {
        my $candidate = dfs(
            [ @{ $selectins_ref }, $buffer_ref->[ $i ] ],
            [ @{ $buffer_ref }[ 0 .. $i - 1, $i + 1 .. $#{ $buffer_ref } ] ]
        );

        $max = $candidate > $max ? $candidate : $max;
    }

    return $max;
}
