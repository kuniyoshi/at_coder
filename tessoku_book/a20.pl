#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

my @s = do { chomp( my $l = <> ); split m{}, $l };
my @t = do { chomp( my $l = <> ); split m{}, $l };

my @dp = map { [ ( 0 ) x ( @t + 1 ) ] } 0 .. @s;

for ( my $i = 1; $i <= @s; ++$i ) {
    for ( my $j = 1; $j <= @t; ++$j ) {
        $dp[ $i ][ $j ] = max(
            $dp[ $i ][ $j - 1 ],
            $dp[ $i - 1 ][ $j - 1 ] + ( $s[ $i - 1 ] eq $t[ $j - 1 ] ),
            $dp[ $i - 1 ][ $j ],
        );
    }
}

#print map { join( qq{\t}, @{ $_ } ), "\n" } @dp;
say max( map { @{ $_ } } $dp[-1] );

exit;


__END__
 mynavi
 monday

0000000
0111111
0111112


0	0	0	0	0	0	0
0	1	1	1	1	1	1
0	1	1	1	1	1	1
0	2	2	2	2	2	2
0	2	2	2	2	2	2
0	2	2	2	2	2	2
0	2	2	2	2	2	2
