#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
chomp( my $d = <> );
my @ranges = map { chomp; [ split m{\s} ] }
             map { scalar <> }
             1 .. $d;

my %set;
$set{ $_ }++
    for @a;

my @sizes = sort { $b <=> $a } keys %set;

my %acc = map { $_ => [ 0 ] } @sizes;

for my $size ( @sizes ) {
    for my $j ( 1 .. $n ) {
        $acc{ $size }[ $j ] = $acc{ $size }[ $j - 1 ] + ( 0 + $a[ $j - 1 ] == $size );
    }
}

#die Dumper \%acc;

LOOP_DAY:
for my $i ( 0 .. $d - 1 ) {
    my( $l, $r ) = @{ $ranges[ $i ] };

    for my $size ( @sizes ) {
        if ( $acc{ $size }[ $l - 1 ] || $acc{ $size }[ $r ] < $acc{ $size }[ $n ] ) {
            say $size;
            next LOOP_DAY;
        }
    }

    die "No viable size found: ($l, $r)";
}

exit;
