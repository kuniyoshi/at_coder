#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Memoize;
memoize( "size" );
memoize( "p" );

my( $n, $x ) = do { chomp( my $l = <> ); split m{\s}, $l };

say f( $n, $x );

exit;

sub f {
    my $level = shift;
    my $x = shift;

    return 1
        if $level == 0;
    return p( $level )
        if $x >= size( $level );

    if ( $x < 2 ) {
        return 0;
    }
    elsif ( $x <= 1 + size( $level - 1 ) ) {
        return f( $level - 1, $x - 1 );
    }
    elsif ( $x == 2 + size( $level - 1 ) ) {
        return 1 + p( $level - 1 );
    }
    else {
        return p( $level - 1 ) + 1 + f( $level - 1, $x - ( size( $level - 1 ) + 2 ) );
    }
}

sub solve {
    my $level = shift;
    my $x = shift;

    return 1
        if $level == 0;

    if ( $x < 2 ) {
        return 0;
    }
    elsif ( $x <= size( $level - 1 ) + 1 ) {
        return p( $level );
    }
    elsif ( $x == size( $level - 1 ) + 2 ) {
        return p( $level ) + 1;
    }
    else {
        return p( $level ) + 1 + solve( $level - 1, $x - ( size( $level - 1 ) + 2 ) );
    }
}

sub r {
    my( $n, $x ) = @_;

    if ( $x <= 1 ) {
    }

    return { p => p( $n ), total => size( $n ) }
        if size( $n ) <= $x;

    my $ref = r( $n - 1, $x );
    $x -= $ref->{total};

    return { p => $ref->{p}, total => size( $n - 1 ) }
        if $x <= 0;
    return { p => $ref->{p} + 1, total => size( $n - 1 ) + 1 }
        if $x == 1;

    my $right = r( $n - 1, $x - 1 );

    return { p => $ref->{p} + 1 + $right->{p}, total => $ref->{total} + 1 + $right->{total} };
}

sub size {
    my $level = shift;
    return 1
        if $level == 0;
    return 3 + 2 * size( $level - 1 );
}

sub p {
    my $level = shift;
    return 1
        if $level == 0;
    return 1 + 2 * p( $level - 1 );
}

__END__

my $level = 0;
$level++
    while size( $level ) < $x;

my $eat = 0;
my $total = 0;

r( $n );

say $eat;

exit;

sub size {
    my $level = shift;
    return 1
        if $level = 0;
    return 3 + size( $level - 1 );
}

sub p {
    my $level = shift;
    return 1
        if $level = 0;
    return 1 + 2 * p( $level - 1 );
}

sub r {
    my $level = shift;
    return q{P}
        if $level == 0;
    return r( $level - 1 ) . q{P} . r( $level - 1 );
}

__END__
L(n) = B L(n-1) P L(n-1) B
L(0) = P
L(1) = B L0 P L0 B
L(2) = B L1 P L1 B
