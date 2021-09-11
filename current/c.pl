#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );

my @s_vertexes = ( );

for my $row ( 1 .. $n ) {
    chomp( my $line = <> );
    my @chars = split m{}, $line;
    my @vertexes = map { [ $_, $row ] }
                   grep { $chars[ $_ - 1 ] eq q{#} }
                   ( 1 .. @chars );

    push @s_vertexes, @vertexes;
}

my @t_vertexes = ( );

for my $row ( 1 .. $n ) {
    chomp( my $line = <> );
    my @chars = split m{}, $line;
    my @vertexes = map { [ $_, $row ] }
                   grep { $chars[ $_ - 1 ] eq q{#} }
                   ( 1 .. @chars );

    push @t_vertexes, @vertexes;
}

my @s1 = transform_x( @s_vertexes );
my @t1 = transform_x( @t_vertexes );
my @s2 = transform_y( @s_vertexes );
my @t2 = transform_y( @t_vertexes );

my $result = is_same( \@t1, \@s1, \@s2 );

if ( $result ) {
    say "Yes";
    exit;
}

my $result2 = is_same( \@t2, \@s1, \@s2 );

if ( $result2 ) {
    say "Yes";
    exit;
}

say "No";

exit;

sub is_same {
    my( $t_ref, $s1_ref, $s2_ref ) = @_;

    for my $tries ( 1 .. 4 ) {
        my %exists = ( );
        $exists{ $_->[0] }{ $_->[1] }++
            for @{ $t_ref };

        for my $vertex_ref ( @{ $s1_ref } ) {
            delete $exists{ $vertex_ref->[0] }{ $vertex_ref->[1] };
            delete $exists{ $vertex_ref->[0] }
                if !%{ $exists{ $vertex_ref->[0] } };
        }

        if ( !%exists ) {
            return 1;
        }

        rotate( $s1_ref );
    }

    for my $tries ( 1 .. 4 ) {
        my %exists = ( );
        $exists{ $_->[0] }{ $_->[1] }++
            for @{ $t_ref };

        for my $vertex_ref ( @{ $s2_ref } ) {
            delete $exists{ $vertex_ref->[0] }{ $vertex_ref->[1] };
            delete $exists{ $vertex_ref->[0] }
                if !%{ $exists{ $vertex_ref->[0] } };
        }

        if ( !%exists ) {
            return 1;
        }

        rotate( $s2_ref );
    }

    return;
}

sub rotate {
    my $vertexes_ref = shift;

    for my $vertex_ref ( @{ $vertexes_ref } ) {
        my( $x, $y ) = @{ $vertex_ref };
        my $after_x = -$y;
        my $after_y = $x;
        $vertex_ref->[0] = $after_x;
        $vertex_ref->[1] = $after_y;
    }
}

sub transform_y {
    my @vertexes = @_;

    my( $min ) = sort { $a->[1] <=> $b->[1] }
                 sort { $a->[0] <=> $b->[0] }
                 @vertexes;

    my @result = map { [ $_->[0] - $min->[0], $_->[1] - $min->[1] ] }
                 @vertexes;

    return @result;
}

sub transform_x {
    my @vertexes = @_;

    my( $min ) = sort { $a->[0] <=> $b->[0] }
                 sort { $a->[1] <=> $b->[1] }
                 @vertexes;

    my @result = map { [ $_->[0] - $min->[0], $_->[1] - $min->[1] ] }
                 @vertexes;

    return @result;
}
