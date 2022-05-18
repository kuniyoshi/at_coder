#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @b = do { chomp( my $l = <> ); split m{\s}, $l };
chomp( my $q = <> );
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

my %unique_counts;
my %count;

for my $i ( 0 .. $#a ) {
    $count{ $a[ $i ] }++;
    push @{ $unique_counts{a} }, scalar %count;
}

%count = ( );

for my $i ( 0 .. $#b ) {
    $count{ $b[ $i ] }++;
    push @{ $unique_counts{b} }, scalar %count;
}

my @equals;

my $unique_count = min( map { scalar @{ $_ } } values %unique_counts );

%count = ( );
my $j = 0;
my $k = 0;
my $bads = 0;

for my $i ( 1 .. $unique_count ) {
    while ( $j < @a && $unique_counts{a}[ $j ] <= $i ) {
        $count{a}{ $a[ $j ] }++;
        if ( $count{a}{ $a[ $j ] } == 1 ) {
            $count{both}{ $a[ $j ] }++;
            $bads += ( $count{both}{ $a[ $j ] } % 2 ) ? 1 : -1;
        }
        $j++;
    }
    while ( $k < @b && $unique_counts{b}[ $k ] <= $i ) {
        $count{b}{ $b[ $k ] }++;
        if ( $count{b}{ $b[ $k ] } == 1 ) {
            $count{both}{ $b[ $k ] }++;
            $bads += ( $count{both}{ $b[ $k ] } % 2 ) ? 1 : -1;
        }
        $k++;
    }
    push @equals, !$bads;
}

for my $query_ref ( @queries ) {
    my( $x, $y ) = @{ $query_ref };
    $x--;
    $y--;
    if ( $unique_counts{a}[ $x ] != $unique_counts{b}[ $y ]) {
        say "No";
        next;
    }
    my $uc = $unique_counts{a}[ $x ];
    say $equals[ $uc - 1 ] ? "Yes" : "No";
}

exit;
