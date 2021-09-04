#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $head = <> );
my( $l, $q ) = split m{\s}, $head;
my @q = map { chomp( my $line = <> ); [ split m{\s}, $line ] }
        1 .. $q;

my $root = [ 0, undef, undef ];
my $last = [ $l, undef, undef ];
$root->[2] = $last;
$last->[1] = $root;

for my $query ( @q ) {
    my( $operation, $x ) = @{ $query };
    if ( $operation == 2 ) {
        my $wood = find_wood( $root, $x );
        my $next = $wood->[2];
        say $next->[0] - $wood->[0];
    }
    if ( $operation == 1 ) {
        my $wood = find_wood( $root, $x );
        my $cut = [ $x, undef, undef ];
        $cut->[1] = $wood;
        $cut->[2] = $wood->[2];
        $wood->[2][1] = $cut;
        $wood->[2] = $cut;
    }
}

exit;

sub find_wood {
    my $wood = shift;
    my $x = shift;

    return $wood
        if $x > $wood->[0] && $x < $wood->[2][0];

    return find_wood( $wood->[2], $x );
}
