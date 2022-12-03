#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $k = <> );

my @factors = factors( $k );
my $max = max( @factors );
warn "\$max: $max";

my %count;
$count{ $_ }++
    for @factors;

my @f = factors( kaijo( $max ) );
for my $f ( @f ) {
    $count{ $f }--
        if $count{ $f };
    delete $count{ $f }
        if exists $count{ $f } && $count{ $f } == 0;
}

my $cursor = $max;

while ( %count ) {
    my @f = factors( $cursor + 1 );
    for my $f ( @f ) {
        $count{ $f }--
            if $count{ $f };
        delete $count{ $f }
            if exists $count{ $f } && $count{ $f } == 0;
    }
    $cursor++;
}

say $cursor;


exit;

sub kaijo {
    my $x = shift;
    return 1
        if $x == 1;
    return $x * kaijo( $x - 1 );
}

sub factors {
    my $k = shift;
    my @factors;
    my $sqrt = sqrt $k;

    my $acc = $k;
    my %used;

    for ( my $i = 2; $i <= $sqrt; ++$i ) {
        next
            if $used{ $i }++;

        while ( ( $acc % $i ) == 0 ) {
            $acc /= $i;
            push @factors, $i;
        }
    }

    push @factors, $acc
        if $acc;

    return @factors;
}
