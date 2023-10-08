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
my @b = patterns( $b );
my @c = patterns( $c );

for my $a ( @a ) {
    for my $b ( @b ) {
        next
            if is_overlap( $a, $b );

        for my $c ( @c ) {
            next
                if is_overlap( $b, $c ) || is_overlap( $a, $c );
            if ( can( $a, $b, $c ) ) {
                say YesNo::get( 1 );
                exit;
            }
        }
    }
}

say YesNo::get( 0 );

exit;

sub dump_grid {
    my $ref = shift;
    warn map { $_, "\n" } map { sprintf "%04b", $_ } @{ $ref };
}

sub is_overlap {
    my( $a, $b ) = @_;
    for ( my $i = 0; $i < 4; ++$i ) {
        return 1
            if $a->[ $i ] & $b->[ $i ];
    }
}

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

    #    dump_grid( \@results );

    return 4 == grep { $_ == ( 2 ** 4 - 1 ) } @results;
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
                #                if ( $moved ) {
                #                    warn "-" x 80;
                #                    dump_grid( $moved );
                #                }
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

    for ( my $i = 0; $i < @results; ++$i ) {
        for ( my $j = 0; $j < $dj; ++$j ) {
            return
                if $results[ $i ] & 1;
            $results[ $i ] >>= 1;
        }
        for ( my $j = 0; $j < -$dj; ++$j ) {
            return
                if $results[ $i ] & ( 1 << 3 );
            $results[ $i ] <<= 1;
            $results[ $i ] &= 2 ** 4 - 1;
        }
    }

    return \@results;
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

