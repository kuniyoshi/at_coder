#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $line = <> );
my( $s, $k ) = split m{\s}, $line;

my @words = ( );

dfs( [ ], [ split m{}, $s ] );

my $previous = q{};
@words = grep { my $is_same = $_ eq $previous; $previous = $_; !$is_same }
         sort @words;

say $words[ $k - 1 ];

exit;

sub dfs {
    my( $buffers_ref, $remains_ref ) = @_;

    if ( !@{ $remains_ref } ) {
        push @words, join q{}, @{ $buffers_ref };
    }

    for ( my $i = 0; $i < @{ $remains_ref }; ++$i ) {
        my @buffers = @{ $buffers_ref };
        my @remains = @{ $remains_ref };
        push @buffers, splice @remains, $i, 1;
        dfs( \@buffers, \@remains );
    }
}
