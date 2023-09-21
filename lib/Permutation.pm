package Permutation;
use utf8;
use strict;
use warnings;

sub new {
    my $class = shift;
    my $array_ref = shift;

    return bless {
        array => $array_ref,
        first => 1,
    }, $class;
}

sub next {
    my $self = shift;

    if ( $self->{first} ) {
        $self->{first} = 0;
        return $self->{array};
    }

    for ( my $i = @{ $self->{array} } - 1; $i > 0; --$i ) {
        if ( $self->{array}[ $i ] > $self->{array}[ $i - 1 ] ) {
            for ( my $j = @{ $self->{array} } - 1; $j >= $i; --$j ) {
                if ( $self->{array}[ $j ] > $self->{array}[ $i - 1 ] ) {
                    @{ $self->{array} }[ $j, $i - 1 ] = @{ $self->{array} }[ $i - 1, $j ];
                    @{ $self->{array} }[ $i .. $#{ $self->{array} } ] = reverse @{ $self->{array} }[ $i .. $#{ $self->{array} } ];
                    return $self->{array};
                }
            }
        }
    }

    return;
}

1;
