#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @a = moves( bits( rotations( read_input( ) ) ) );
my @b = moves( bits( rotations( read_input( ) ) ) );
my @c = moves( bits( rotations( read_input( ) ) ) );

for my $a ( @a ) {
    for my $b ( @b ) {
        next
            if is_overlap( $a, $b );

        for my $c ( @c ) {
            next
                if is_overlap( $a, $c ) || is_overlap( $b, $c );

            if ( is_fulfill( $a, $b, $c ) ) {
                say YesNo::get( 1 );
                exit;
            }
        }
    }
}

say YesNo::get( 0 );

exit;

sub dump_grids {
    my @grids = @_;
    for my $ref ( @grids ) {
        warn join "\n", map { sprintf "%04b", $_ } @{ $ref };
        warn "-" x 80;
    }
}

sub is_fulfill {
    my( $a, $b, $c ) = @_;

    for ( my $i = 0; $i < 4; ++$i ) {
        my $v = $a->[ $i ] | $b->[ $i ] | $c->[ $i ];
        if ( $v != 15 ) {
            return;
        }
    }

    return 1;
}

sub is_overlap {
    my( $a, $b ) = @_;

    for ( my $i = 0; $i < 4; ++$i ) {
        return 1
            if $a[ $i ] & $b[ $i ];
    }
}

sub move {
    my $ref = shift;
    my $di = shift;
    my $dj = shift;
    my @results = @{ $ref };

    for ( my $i = 0; $i < $di; ++$i ) {
        my $poped = pop @results;
        return
            if $poped;
        unshift @results, 0;
    }

    for ( my $i = 0; $i < -$di; ++$i ) {
        my $shifted = shift @results;
        return
            if $shifted;
        push @results, 0;
    }

    for ( my $j = 0; $j < $dj; ++$j ) {
        for ( my $i = 0; $i < 4; ++$i ) {
            return
                if $results[ $i ] & 1;
            $results[ $i ] >>= 1;
        }
    }

    for ( my $j = 0; $j < -$dj; ++$j ) {
        for ( my $i = 0; $i < 4; ++$i ) {
            return
                if $results[ $i ] & 1 << 3;
            $results[ $i ] <<= 1;
        }
    }

    return \@results;
}

sub moves {
    my $list_ref = shift;
    my @results;

    for my $ref ( @{ $list_ref } ) {
        for ( my $i = -4; $i < 4; ++$i ) {
            for ( my $j = -4; $j < 4; ++$j ) {
                my $moved = move( $ref, $i, $j );
                push @results, $moved
                    if $moved;
            }
        }
    }

    return @results;
}

sub bits {
    my $ref = shift;
    my @results;

    for my $r ( @{ $ref } ) {
        my @bits = ( 0 ) x 4;

        for ( my $i = 0; $i < 4; ++$i ) {
            for ( my $j = 0; $j < 4; ++$j ) {
                next
                    unless $r->[ $i ][ $j ] ne q{#};
                $bits[ $i ] |= 1 << $j;
            }
        }

        push @results, \@bits;
    }

    return \@results;
}

sub rotate {
    my $ref = shift;
    my $result;

    for ( my $i = 0; $i < 4; ++$i ) {
        for ( my $j = 0; $j < 4; ++$j ) {
            $result->[ $i ][ $j ] = $ref->[ $j ][ $i ];
        }
    }

    return [ reverse @{ $result } ];
}

sub rotations {
    my $ref = shift;
    my @rotations = ( $ref );

    for ( my $i = 0; $i < 3; ++$i ) {
        push @rotations, rotate( $rotations[-1] );
    }

    return \@rotations;
}

sub read_input {
    my @grid = map { chomp; [ split m{} ] }
               map { scalar <> }
               1 .. 4;
    return \@grid;
}

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
