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

YesNo::get( 0 );

exit;

sub update {
    my $result_ref = shift;
    my $ref = shift;
    my $i = shift;
    my $j = shift;

    for my $u ( 0 .. 3 ) {
        if ( $result_ref->[ $i + $u ] & ( ( $ref->[ $u ] // 0 ) << $j ) ) {
            return;
        }

        $result_ref->[ $i + $u ] |= $ref->[ $u ] << $j;
    }
}

sub test {
    my( $a, $b, $c ) = @_;

    for ( my $i = 0; $i < 16 * 9; ++$i ) {
        my( $ai, $aj ) = ( int( $i / 3 * 16 ), $i % ( 3 * 16 ) );

        for ( my $j = 0; $j < 16 * 9; ++$j ) {
            my( $bi, $bj ) = ( int( $j / 3 * 16 ), $j % ( 3 * 16 ) );

            for ( my $k = 0; $k < 16 * 9; ++$k ) {
                my( $ci, $cj ) = ( int( $k / 3 * 16 ), $k % ( 3 * 16 ) );

                my @result = ( 0 ) x ( 4 * 3 );

                if ( update( \@result, $a, $ai, $aj ) ) {
                    return;
                }

                if ( update( \@result, $b, $bi, $bj ) ) {
                    return;
                }

                if ( update( \@result, $c, $ci, $cj ) ) {
                    return;
                }

                return
                    if grep { $_ } @result[ 0 .. 3, 8 .. 11 ];

                for my $bits ( @result[ 4 .. 7 ] ) {
                    return
                        if $bits & 2 ** 4 - 1;
                    $bits >>= 4;
                    return
                        if ( ( $bits & 2 ** 4 - 1 ) != 2 ** 4 - 1 );
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
