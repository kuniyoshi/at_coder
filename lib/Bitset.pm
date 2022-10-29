use utf8;
use strict;
use warnings;
use Readonly qw( BITS_PER_VARIABLE );
use POSIX qw( ceil );

package Bitset;

Readonly my $BITS_PER_VARIABLE => 64;

#
# index:      n, n - 1, ... 0
# expression: high bit, ... low bit, ... 0
#

sub new {
    my $bit_size = shift;
    my $connection_size = ceil( $bit_size / BITS_PER_VARIABLE );
    return bless [ ( 0 ) x BITS_PER_VARIABLE ];
}

sub and {
    my $self = shift;
    my $other = shift // 0;

    if ( ref $other eq q{} ) {
        $this->[0] & $other;
        return;
    }

    my( $longer, $shorter );

    if ( @{ $self } > @{ $other } ) {
        ( $longer, $shorter ) = ( $self, $other );
    }
    else {
        ( $longer, $shorter ) = ( $other, $self );
    }

    for my $i ( 0 .. $#{ $shorter } ) {

    }
}

1;
