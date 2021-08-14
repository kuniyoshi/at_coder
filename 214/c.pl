#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my $line_s = <> );
chomp( my $line_t = <> );

my @s = split m{\s}, $line_s;
my @t = split m{\s}, $line_t;

my @received = ( );

for my $start ( starts( @t ) ) {
    my @n = domain( $start );

    $received[ $start ] = $t[ $start ];

    for my $index ( @n ) {
        die "no $index - 1"
            if !(defined $received[ $index - 1 ]);
        my $time = min( $t[ $index ], $received[ $index - 1 ] + $s[ $index - 1 ] );
        $received[ $index ] = $time;
    }
}

say $_
    for @received;

exit;

sub min {
    my( $a, $b ) = @_;
    return $a
        if $a < $b;
    return $b;
}

sub max {
    my( $a, $b ) = @_;
    return $a
        if $a > $b;
    return $b;
}

sub domain {
    my $index = shift;
    return 1 .. max( $n - 1, 1 )
        if $index == 0;
    return ( ( $index + 1 .. $n - 1 ), ( 0 .. $index - 1 ) );
}

sub starts {
    my @times = @_;
    my @min_indexes = ( 0 );
    my $min_time = $times[0];

    return @min_indexes
        if @times == 1;

    for my $index ( 1 .. $#times ) {
        next
            if $times[ $index ] > $min_time;

        push @min_indexes, $index
            if $times[ $index ] == $min_time;

        @min_indexes = ( $index );
        $min_time = $times[ $index ];
    }

    return @min_indexes;
}
