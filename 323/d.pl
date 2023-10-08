#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

chomp( my $n = <> );
my @slimes = map { chomp; [ split m{\s} ] }
             map { scalar <> }
             1 .. $n;

my %count;

for my $ref ( @slimes ) {
    my( $size, $count ) = @{ $ref };
    $count{ $size } += $count;
}

my @keys = sort { $a <=> $b } keys %count;

for my $size ( @keys ) {
    my $count = $count{ $size };

    while ( $count > 1 ) {
        my $next_size_count = int( $count / 2 );
        $count{ $size } = $count % 2;
        $size *= 2;
        $count = $next_size_count + ( $count{ $size } // 0 );
        $count{ $size } = $count;
    }
}

say sum( values %count ) // 0;

exit;
