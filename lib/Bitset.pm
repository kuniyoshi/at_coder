use utf8;
use strict;
use warnings;

package Bitset;
use Readonly;
use POSIX qw( ceil );

use Readonly;

Readonly my $BITS_PER_VARIABLE => 4;

#
# index:      n, n - 1, ... 0
# expression: high bit, ... low bit, ... 0
#

sub new {
    my $class = shift;
    my $length = shift;
    my $size = ceil( $length / $BITS_PER_VARIABLE );
    return bless { length => $length, bits => [ ( 0 ) x $size ] };
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
        my $width = $remain > $BITS_PER_VARIABLE ? $BITS_PER_VARIABLE : $remain;
        $remain = $remain - $BITS_PER_VARIABLE;
        push @partitions, sprintf "%0${width}b", $self->{bits}[ $i ];
    }

    return join q{_}, reverse @partitions;
}

sub is_zero {
    my $self = shift;

    return !grep { $_ } @{ $self->{bits} };
}

sub shift_left {
    my $self = shift;
    my $length = shift
        or return;

    my $chunk_size = int( $length / $BITS_PER_VARIABLE );

    pop @{ $self->{bits} }
        for 1 .. $chunk_size;
    unshift @{ $self->{bits} }, 0
        for 1 .. $chunk_size;

    my $remain = $length - $chunk_size * $BITS_PER_VARIABLE;

    for ( my $i = $#{ $self->{bits} }; $i > 0; --$i ) {
        $self->{bits}[ $i ] <<= $remain;
        $self->{bits}[ $i ] |= $self->{bits}[ $i - 1 ] >> ( $BITS_PER_VARIABLE - $remain );
    }

    $self->{bits}[ 0 ] <<= $remain;

    my $omit = $BITS_PER_VARIABLE - $self->{length} % $BITS_PER_VARIABLE;

    $self->{bits}[-1] &= ( 1 << ( $omit + 1 ) - 1 );
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
        if ( ( $self->{length} % $BITS_PER_VARIABLE ) == 0 );

    my $omit = $BITS_PER_VARIABLE - $self->{length} % $BITS_PER_VARIABLE;

    $self->{bits}[-1] &= ( 1 << ( $omit + 1 ) - 1 );
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
