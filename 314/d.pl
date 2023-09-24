#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $is_lower = 1;
my $is_upper = 2;

chomp( my $n = <> );
my @s = do { chomp( my $l = <> ); split m{}, $l };
chomp( my $q = <> );
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

my $last_size = [ undef, undef ];
my @buffers = map { [ $_, 0 ] } @s;

for ( my $i = 0; $i < @queries; ++$i ) {
    my $query = $queries[ $i ];
    my( $t, $x, $c ) = @{ $query };

    if ( $t == 1 ) {
        $buffers[ $x - 1 ] = [ $c, $i ];
    }
    elsif ( $t == 2 ) {
        $last_size = [ $is_lower, $i ];
    }
    elsif ( $t == 3 ) {
        $last_size = [ $is_upper, $i ];
    }
}

say join q{}, map {
    if ( $last_size->[0] && $last_size->[1] > $_->[1] ) {
        $last_size->[0] == $is_lower ? lc( $_->[0] ) : uc( $_->[0] );
    }
    else {
        $_->[0];
    }
} @buffers;

exit;
