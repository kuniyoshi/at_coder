#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min max );

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $n;
chomp( my $q = <> );
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

my $max = max( @a );

my @d;

for my $i ( 0 .. $n - 1 ) {
    for my $j ( 0 .. $n - 1 ) {
        $d[ $i ][ $j ] = 2 * $n;
    }
}

for ( my $i = 0; $i < @s; ++$i ) {
    for my $j ( 0 .. $n - 1 ) {
        next
            unless $s[ $i ][ $j ] eq q{Y};
        $d[ $i ][ $j ] = 1;
    }
}

for my $k ( 0 .. $n - 1 ) {
    for my $i ( 0 .. $n - 1 ) {
        for my $j ( 0 .. $n - 1 ) {
            my $curr = $d[ $i ][ $j ];
            my $new = $d[ $i ][ $k ] + $d[ $k ][ $j ];

            $d[ $i ][ $j ] = min( $curr, $new );
        }
    }
}

my %links;

for ( my $i = 0; $i < @s; ++$i ) {
    for my $j ( 0 .. $n - 1 ) {
        next
            unless $s[ $i ][ $j ] eq q{Y};
        push @{ $links{ $i } }, $j;
    }
}

for my $ref ( @queries ) {
    my( $from, $to ) = @{ $ref };
    $from--;
    $to--;
    my $cost = $d[ $from ][ $to ];

    if ( !defined $cost || $cost > $n ) {
        say "Impossible";
        next;
    }

    my @queue = ( [ $from, 0, 0 ] );
    my %visited;

    my $total = 0;

    #warn "($from, $to)";

    while ( @queue ) {
        my( $v, $sum, $count ) = @{ shift @queue };
        next
            if $v != $to && $visited{ $v }++;
        $sum += $a[ $v ];

        if ( $v == $to ) {
            #            warn "\$v: $v";
            $total = max( $total, $sum );
            next;
        }

        next
            if $count == $cost;

            #warn join q{, }, map { "$v -> $_" } grep { !$visited{ $_ } } @{ $links{ $v } };
        push @queue, map { [ $_, $sum, $count + 1 ] } grep { !$visited{ $_ } } @{ $links{ $v } };
    }

    say "$cost $total";
}

exit;
