#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $x ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @pairs = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n;

my $bits = Bitset->new( $x + 1 )->one;

for my $ref ( @pairs ) {
    my( $a, $b ) = @{ $ref };
    my $c = $bits->clone;
    for my $i ( 1 .. $b ) {
        $c->shift_left( $a );
        $bits->or( $c );
    }
}

my $can = $bits->at( $x );

say YesNo::get( $can );

exit;

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

use utf8;
use strict;
use warnings;

package Bitset;
use POSIX qw( ceil );

sub BITS_PER_VARIABLE { 64 }

#
# index:      n, n - 1, ... 0
# expression: high bit, ... low bit, ... 0
#

sub new {
    my $class = shift;
    my $length = shift
        or die "length required";
    my $size = ceil( $length / $class->BITS_PER_VARIABLE );
    return bless { length => $length, bits => [ ( 0 ) x $size ] }, $class;
}

sub clone {
    my $self = shift;
    my $class = ref $self;
    return bless { length => $self->{length}, bits => [ @{ $self->{bits} } ] }, $class;
}

sub one {
    my $self = shift;
    for ( my $i = 0; $i < @{ $self->{bits} }; ++$i ) {
        $self->{bits}[ $i ] = 0;
    }
    $self->{bits}[0] = 1;
    return $self;
}

sub dump {
    my $self = shift;
    my $remain = $self->{length};
    my @partitions;

    for ( my $i = 0; $i < @{ $self->{bits} }; ++$i ) {
        my $width = $remain > $self->BITS_PER_VARIABLE ? $self->BITS_PER_VARIABLE : $remain;
        $remain = $remain - $self->BITS_PER_VARIABLE;
        push @partitions, sprintf "%0${width}b", $self->{bits}[ $i ];
    }

    return join q{_}, reverse @partitions;
}

sub is_zero {
    my $self = shift;

    return !grep { $_ } @{ $self->{bits} };
}

sub at {
    my $self = shift;
    my $at = shift;

    return
        if $at >= $self->{length};

    my $chunk_position = int( $at / $self->BITS_PER_VARIABLE );
    my $bit_position = 1 << ( $at % $self->BITS_PER_VARIABLE );

    return $self->{bits}[ $chunk_position ] & $bit_position;
}

sub shift_left {
    my $self = shift;
    my $length = shift
        or return;

    my $chunk_size = int( $length / $self->BITS_PER_VARIABLE );

    pop @{ $self->{bits} }
        for 1 .. $chunk_size;
    unshift @{ $self->{bits} }, 0
        for 1 .. $chunk_size;

    my $remain = $length - $chunk_size * $self->BITS_PER_VARIABLE;

    for ( my $i = $#{ $self->{bits} }; $i > 0; --$i ) {
        $self->{bits}[ $i ] <<= $remain;
        $self->{bits}[ $i ] |= $self->{bits}[ $i - 1 ] >> ( $self->BITS_PER_VARIABLE - $remain );
    }

    $self->{bits}[ 0 ] <<= $remain;

    my $require = $self->{length} % $self->BITS_PER_VARIABLE;
    my $mask = ( 1 << $require ) - 1;

    $self->{bits}[-1] &= $mask;
}

sub or {
    my $self = shift;
    my $other = shift;

    # test other's class

    for ( my $i = 0; $i < @{ $self->{bits} }; ++$i ) {
        last
            if $i == @{ $other->{bits} };

        $self->{bits}[ $i ] |= $other->{bits}[ $i ];
    }

    return
        if ( ( $self->{length} % $self->BITS_PER_VARIABLE ) == 0 );

    my $omit = $self->BITS_PER_VARIABLE - ( $self->{length} % $self->BITS_PER_VARIABLE );
    my $mask = ( -1 << $omit ) >> $omit;
    $self->{bits}[-1] &= $mask;
}

sub and {
    my $self = shift;
    my $other = shift;

    # test other's class

    for ( my $i = 0; $i < @{ $self->{bits} }; ++$i ) {
        last
            if $i == @{ $other->{bits} };

        $self->{bits}[ $i ] &= $other->{bits}[ $i ];
    }

    # ignore higher chunk, it will not change
}

1;
