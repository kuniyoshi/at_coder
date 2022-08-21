#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @cells = map { chomp; [ split m{} ] }
            map { scalar <> }
            1 .. $h;

my $pos = simulate( );
say $pos ? join( q{ }, @{ $pos } ) : -1;

exit;

sub simulate {
    my $row = 0;
    my $col = 0;
    my %visited;

    while ( ( my $next = move( $row, $col ) ) ) {
        ( $row, $col ) = @{ $next };
        return
            if $visited{ $row }{ $col }++;
    }

    return [ $row + 1, $col + 1 ];
}

sub move {
    my( $row, $col ) = @_;
    if ( $cells[ $row ][ $col ] eq q{U} ) {
        return $row > 0 ? [ $row - 1, $col ] : undef;
    }
    elsif ( $cells[ $row ][ $col ] eq q{D} ) {
        return $row < ( $h - 1 ) ? [ $row + 1, $col ] : undef;
    }
    elsif ( $cells[ $row ][ $col ] eq q{L} ) {
        return $col > 0 ? [ $row, $col - 1 ] : undef;
    }
    elsif ( $cells[ $row ][ $col ] eq q{R} ) {
        return $col < ( $w - 1 ) ? [ $row, $col + 1 ] : undef;
    }
    else {
        die "somehow";
    }
}
