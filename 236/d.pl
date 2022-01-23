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

say dfs( [ ], [ 0 .. ( $n - 1 ) ] );

exit;

sub dfs {
    my $selectins_ref = shift;
    my $buffer_ref = shift;

    unless ( @{ $buffer_ref } ) {
        return 
    }

    for ( my $i = 0; $i < @{ $buffer_ref }; ++$i ) {
        my @c = ( @{ $selectins_ref }, $buffer_ref->[ $i ] );
        my @d = @{ $buffer_ref }[ 0 .. $i, ( $i + 1 ) .. $#{ $buffer_ref } ];
        dfs( \@c, \@d );
    }
}
