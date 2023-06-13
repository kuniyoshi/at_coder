#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $c, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @arrives = map { chomp; $_ }
              map { scalar <> }
              1 .. $n;

my %arrive;
$arrive{ $_ }++
    for @arrives;

my $size = 0;
my $limit = 0;
my $busses = 0;

for my $t ( sort { $a <=> $b } keys %arrive ) {
    if ( $t == $limit ) {
        $size += $arrive{ $t };
        ship( \$size );

        $limit = 0;
        $size = 0;
    }
    elsif ( $t > $limit ) {
        ship( \$size );

        $limit = $t + $k;
        $size = $arrive{ $t };
    }
    else {
        $size += $arrive{ $t };
    }
}

ship( \$size );

say $busses;

exit;

sub ship {
    my $size_ref = shift;
    return
        unless $$size_ref;
    $busses += int( $$size_ref / $c );
    if ( $$size_ref % $c ) {
        $busses++;
    }
    $$size_ref = 0;
}
