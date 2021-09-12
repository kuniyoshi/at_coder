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

    return
        if @{ $t_ref } != @{ $s_ref };

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

        @vertexes = rotate( @vertexes );
        @vertexes = transform( @vertexes );
    }

    return;
}

sub rotate {
    my @vertexes = @_;

    return map { [ -$_->[1], $_->[0] ] }
           @vertexes;
}

sub transform {
    my @vertexes = @_;

    my( $min ) = sort { $a->[0] <=> $b->[0] }
                 sort { $a->[1] <=> $b->[1] }
                 @vertexes;

    my @result = map { [ $_->[0] - $min->[0], $_->[1] - $min->[1] ] }
                 @vertexes;

    return @result;
}
