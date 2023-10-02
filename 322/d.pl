#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min max );

my @inputs = map { chomp; [ split m{} ] }
             map { scalar <> }
             1 .. ( 3 * 4 );

my @a = map { bits( $_ ) } patterns( @inputs[ 0 .. 3 ] );
my @b = map { bits( $_ ) } patterns( @inputs[ 4 .. 7 ] );
my @c = map { bits( $_ ) } patterns( @inputs[ 8 .. 11 ] );

for my $a ( @a ) {
    for my $b ( @b ) {
        for my $c ( @c ) {
            if ( test( $a, $b, $c ) ) {
                say YesNo::get( 1 );
                exit;
            }
        }
    }
}

say YesNo::get( 0 );

exit;

sub update {
    my $result_ref = shift;
    my $ref = shift;
    my $i = shift;
    my $j = shift;

    return
        if $i + 3 >= @{ $result_ref };

    for my $u ( 0 .. 3 ) {
        if ( $result_ref->[ $i + $u ] & ( $ref->[ $u ] << $j ) ) {
            return;
        }

        $result_ref->[ $i + $u ] |= $ref->[ $u ] << $j;
    }
}

sub is_center {
    my $a = shift;
    my( $i, $j ) = @_;

    for ( my $u = 0; $u < 4; ++$u ) {
        if ( $i + $u < 4 && $a->[ $u ] ) {
            return;
        }

        if ( $i + $u > 7 && $a->[ $u ] ) {
            return;
        }

        my $mask = 2 ** 4 - 1;

        if ( ( $a->[ $u ] << $j ) & $mask ) {
            return;
        }

        if ( ( $a->[ $u ] << $j ) & ( $mask << 8 ) ) {
            return;
        }
    }

    return 1;
}

sub test {
    my( $a, $b, $c ) = @_;

    LOOP_I:
    for ( my $i = 0; $i < 16 * 9; ++$i ) {
        my( $ai, $aj ) = ( int( $i / ( 3 * 4 ) ), $i % ( 3 * 4 ) );

        next LOOP_I
            if !is_center( $a, $ai, $aj );

        LOOP_J:
        for ( my $j = 0; $j < 16 * 9; ++$j ) {
            my( $bi, $bj ) = ( int( $j / ( 3 * 4 ) ), $j % ( 3 * 4 ) );

            next LOOP_J
                if !is_center( $b, $bi, $bj );

            LOOP_K:
            for ( my $k = 0; $k < 16 * 9; ++$k ) {
                my( $ci, $cj ) = ( int( $k / ( 3 * 4 ) ), $k % ( 3 * 4 ) );

                next LOOP_K
                    if !is_center( $c, $ci, $cj );

                my @result = ( 0 ) x ( 4 * 3 );

                if ( update( \@result, $a, $ai, $aj ) ) {
                    next;
                }

                if ( update( \@result, $b, $bi, $bj ) ) {
                    next;
                }

                if ( update( \@result, $c, $ci, $cj ) ) {
                    next;
                }

                next
                    if grep { $_ } @result[ 0 .. 3, 8 .. 11 ];

                for my $bits ( @result[ 4 .. 7 ] ) {
                    next LOOP_K
                        if $bits & ( 2 ** 4 - 1 );
                    $bits >>= 4;
                    next LOOP_K
                        if ( ( $bits & ( 2 ** 4 - 1 ) ) != ( 2 ** 4 - 1 ) );
                    $bits >>= 4;
                    next LOOP_K
                        if $bits;
                }

                return 1;
            }
        }
    }
}

sub bits {
    my $ref = shift;
    my @result = ( 0 ) x 4;

    for ( my $i = 0; $i < @{ $ref }; ++$i ) {
        for ( my $j = 0; $j < @{ $ref->[ $i ] }; ++$j ) {
            next
                unless $ref->[ $i ][ $j ];
            $result[ $i ] |= 1 << $j;
        }
    }

    return \@result;
}

sub rotation {
    my $ref = shift;
    my @buffer = map { [ ( 0 ) x 8 ] } 1 .. 4;
    my $sin90 = 1;
    my $cos90 = 0;
    for ( my $i = 0; $i < @{ $ref }; ++$i ) {
        for ( my $j = 0; $j < @{ $ref->[ $i ] }; ++$j ) {
            next
                unless $ref->[ $i ][ $j ];

            my $x = $cos90 * $j - $sin90 * $i;
            my $y = $sin90 * $j + $cos90 * $i;
            $buffer[ $y ][ $x + 4 ]++;
        }
    }

    my $min = 7;
    my $max = 0;

    for ( my $i = 0; $i < @buffer; ++$i ) {
        for ( my $j = 0; $j < @{ $buffer[0] }; ++$j ) {
            if ( $buffer[ $i ][ $j ] ) {
                $min = min( $min, $j );
                $max = max( $max, $j );
            }
        }
    }

    my @result = map { [ ( 0 ) x 4 ] } 1 .. 4;

    for ( my $i = 0; $i < @buffer; ++$i ) {
        for ( my $j = 0; $j < @{ $buffer[0] }; ++$j ) {
            if ( $buffer[ $i ][ $j ] ) {
                $result[ $i ][ $j - $min ]++;
            }
        }
    }

    return \@result;
}

sub patterns {
    my @lines = @_;
    my @base = map { [ map { $_ eq q{#} } @{ $_ } ] } @lines;
    my @patterns = ( \@base );
    for ( my $i = 0; $i < 3; ++$i ) {
        push @patterns, rotation( $patterns[-1] );
    }
    return @patterns;
}

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
