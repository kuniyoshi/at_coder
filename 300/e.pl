#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

#chomp( my $n = <> );
#my( $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };
#my @s = do { chomp( my $l = <> ); split m{\s}, $l };
#my @l = map { chomp; [ split m{\s} ] }
#        map { scalar <> }
#        1 .. $n;
#my %factor = factor( 1e18 );
my $mod = Mod->new;
$mod->add( 7 );
$mod->divide( 25 );
say $mod->value;

exit;

sub factor {
    my $n = shift;
    my %factor;

    for ( my $i = 2; $i * $i <= $n; ++$i ) {
        next
            if $n % $i;
        my $count = 0;
        while ( $n % $i == 0 ) {
            $n /= $i;
            $count++;
        }
        $factor{ $i } = $count;
    }

    return %factor;
}

package Mod {
    sub mod { 998244353 }

    sub new {
        my $class = shift;
        my $value = shift // 0;
        return bless \$value, $class;
    }

    sub value {
        return ${ shift( ) };
    }

    sub add {
        my $self = shift;
        my $value = shift;
        ${ $self } += $value;
        ${ $self } %= mod( );
        return $self;
    }

    sub subtract {
        my $self = shift;
        my $value = shift;
        ${ $self } -= $value;
        ${ $self } %= mod( );
        return $self;
    }

    sub multiply {
        my $self = shift;
        my $value = shift;
        ${ $self } *= $value;
        ${ $self } %= mod( );
        return $self;
    }

    sub divide {
        my $self = shift;
        my $value = shift;
        return $self->multiply( _pow( $value, mod( ) - 2 ) );
    }

    sub _pow {
        my $base = shift;
        my $power = shift;
        return $base
            if $power == 1;
        return $base * _pow( $base, $power - 1 ) % mod( )
            if $power % 2;
        my $value = _pow( $base, $power / 2 );
        return( ( $value * $value ) % mod( ) );
    }
}
