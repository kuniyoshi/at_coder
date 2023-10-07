#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

my $a = read_grid( );
my $b = read_grid( );
my $c = read_grid( );

my @a = patterns( $a );
#die Dumper \@a;
my @b = patterns( $b );
my @c = patterns( $c );

for my $a ( @a ) {
    for my $b ( @b ) {
        for my $c ( @c ) {
            if ( can( $a, $b, $c ) ) {
                say YesNo::get( 1 );
                exit;
            }
        }
    }
}

say YesNo::get( 0 );

exit;

sub can {
    my @inputs = @_;
    my @results = ( 0 ) x 4;

    for my $input ( @inputs ) {
        for ( my $i = 0; $i < 4; ++$i ) {
            return
                if $results[ $i ] & $input->[ $i ];
            $results[ $i ] |= $input->[ $i ];
        }
    }

    return 4 == grep { $_ == 2 ** 4 - 1 } @results;
}

sub patterns {
    my $ref = shift;
    my @chars = ( $ref );

    for ( my $i = 0; $i < 3; ++$i ) {
        push @chars, rotate( $chars[-1] );
    }

    #    die Dumper \@chars;

    my @numbers = map { numbers( $_ ) } @chars;
    #    die Dumper \@numbers;
    my @results;

    for my $n ( @numbers ) {
        for ( my $i = -4; $i < 4; ++$i ) {
            for ( my $j = -4; $j < 4; ++$j ) {
                my $moved = move( $n, $i, $j );
                push @results, $moved
                    if $moved;
            }
        }
    }

    return @results;
}

sub numbers {
    my $ref = shift;
    my @results = ( 0 ) x 4;

    for ( my $i = 0; $i < @{ $ref }; ++$i ) {
        for ( my $j = 0; $j < @{ $ref->[ $i ] }; ++$j ) {
            next
                if $ref->[ $i ][ $j ] ne q{#};
            $results[ $i ] |= 1 << $j;
        }
    }

    return \@results;
}

sub move {
    my $ref = shift;
    my $di = shift;
    my $dj = shift;
    my @results = @{ $ref };

    for ( my $i = 0; $i < $di; ++$i ) {
        pop @results;
        unshift @results, 0;
    }

    for ( my $i = 0; $i < -$di; ++$i ) {
        shift @results;
        push @results, 0;
    }

    for ( my $i = 0; $i < @results; ++$i ) {
        for ( my $j = 0; $j < $dj; ++$j ) {
            $results[ $i ] >>= 1;
        }
        for ( my $j = 0; $j < $dj; ++$j ) {
            $results[ $i ] <<= 1;
            $results[ $i ] &= 2 ** 4 - 1;
        }
    }

    return
        unless sum( @results ) != sum( @{ $ref } );

    return \@results;
}

sub dump_grid {
    my $ref = shift;
    print map { $_, "\n" } map { join q{}, @{ $_ } } @{ $ref };
}

sub rotate {
    my $ref = shift;
    my $result;

    for ( my $i = 0; $i < @{ $ref }; ++$i ) {
        for ( my $j = 0; $j < @{ $ref->[0] }; ++$j ) {
            $result->[ $i ][ $j ] = $ref->[ $#{ $ref->[0] } - $j ][ $i ];
        }
    }

    return $result;
}

sub read_grid {
    my @grids = map { chomp; [ split m{} ] }
                map { scalar <> }
                1 .. 4;
    return \@grids;
}

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;

