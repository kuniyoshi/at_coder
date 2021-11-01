#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $q ) = do { chomp( my $h = <> ); split m{\s}, $h };
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

my @trains = map { [ undef, undef ] }
             1 .. $n;

my %operation = (
    1 => sub {
        my( $x, $y ) = @_;
        $x--;
        $y--;
        $trains[ $x ][1] = $y;
        $trains[ $y ][0] = $x;
    },
    2 => sub {
        my( $x, $y ) = @_;
        $x--;
        $y--;
        $trains[ $x ][1] = undef;
        $trains[ $y ][0] = undef;
    },
    3 => sub {
        my $x = shift;
        $x--;
        my @connections;

        my $cursor = $x;

        while ( defined $trains[ $cursor ][0] ) {
            unshift @connections, $trains[ $cursor ][0];
            $cursor = $trains[ $cursor ][0];
        }

        push @connections, $x;

        $cursor = $x;

        while ( defined $trains[ $cursor ][1] ) {
            push @connections, $trains[ $cursor ][1];
            $cursor = $trains[ $cursor ][1];
        }

        say join q{ }, ( scalar( @connections ), map { $_ + 1 } @connections );
    },
);

for my $query_ref ( @queries ) {
    my $op = shift @{ $query_ref };
    $operation{ $op }->( @{ $query_ref } );
}

exit;
