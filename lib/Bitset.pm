use utf8;
use strict;
use warnings;
use Readonly qw( BITS_PER_VARIABLE );

package Bitset;

Readonly my $BITS_PER_VARIABLE => 64;

sub new {
    my $bit_size = shift;
    my $connection_size = int( $bit_size / BITS_PER_VARIABLE );
    return bless [ ( 0 ) x BITS_PER_VARIABLE ];
}

sub and {
    my $self = shift;
    my $other = shift // 0;

}

1;
