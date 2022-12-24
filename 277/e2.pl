#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @edges = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $m;
my @s = do { chomp( my $l = <> ); split m{\s}, $l };

my %id;
my %links;

for my $ref ( @edges ) {
    my( $u, $v, $s ) = @{ $ref };
    my $id_u = ( $id{ $u }{ $s } //= [ $u, $s ] );
    my $id_v = ( $id{ $v }{ $s } //= [ $v, $s ] );
    push @{ $links{ $id_u } }, $id_v;
    push @{ $links{ $id_v } }, $id_u;
}

push @s, $n;

for my $s ( @s ) {
    my $id_u = ( $id{ $s }{ 0 } //= [ $s, 0 ] );
    my $id_v = ( $id{ $s }{ 1 } //= [ $s, 1 ] );
    push @{ $links{ $id_u } }, $id_v;
    push @{ $links{ $id_v } }, $id_u;
}

my @queue = ( [ 0, $id{1}{1} ] );
my %cost = ( $id{1}{1} => 0 );

while ( @queue ) {
    my( $cost, $id ) = @{ shift @queue };
    #warn "$cost: $id->[0], $id->[1]";
    next
        if exists $cost{ $id } && $cost != $cost{ $id };

    for my $v ( @{ $links{ $id } } ) {
        my $new = $cost + !!( $id->[0] != $v->[0] );
        #        warn "\$new: $new";
        next
            if exists $cost{ $v } && $new >= $cost{ $v };
        $cost{ $v } //= $new;
        if ( $v->[0] == $id->[0] ) {
            unshift @queue, [ $new, $v ];
        }
        else {
            push @queue, [ $new, $v ];
        }
    }
}

say $cost{ $id{ $n }{0} } // -1;

exit;

