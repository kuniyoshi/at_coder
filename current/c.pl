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

my @t = transform( @t_vertexes );
my @s = transform( @s_vertexes );

my $result = is_same( \@t, \@s );

say $result ? "Yes" : "No";

exit;

sub is_same {
    my( $t_ref, $s_ref ) = @_;
    my @vertexes = @{ $s_ref };

    for my $tries ( 1 .. 4 ) {
        my %exists = ( );
        $exists{ $_->[0] }{ $_->[1] }++
            for @{ $t_ref };

        for my $vertex_ref ( @vertexes ) {
            delete $exists{ $vertex_ref->[0] }{ $vertex_ref->[1] };
            delete $exists{ $vertex_ref->[0] }
                if !%{ $exists{ $vertex_ref->[0] } };
        }

        if ( !%exists ) {
            return 1;
        }

        rotate( \@vertexes );
        @vertexes = transform( @vertexes );
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

sub transform {
    my @vertexes = @_;

    my %min = ( );
    ( $min{x} ) = sort { $a <=> $b }
                  map { $_->[0] }
                  @vertexes;
    ( $min{y} ) = sort { $a <=> $b }
                  map { $_->[1] }
                  @vertexes;

    my @result = map { [ $_->[0] - $min{x}, $_->[1] - $min{y} ] }
                 @vertexes;

    return @result;
}
