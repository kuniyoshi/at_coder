use 5.10.0;
use utf8;
use strict;
use warnings;

package Vector2 {
    our $width;
    our $height;

    sub new {
        my $class = shift;
        my $x = shift // 0;
        my $y = shift // 0;
        return bless [ $x, $y ], $class;
    }

    sub dump {
        my $self = shift;
        return "($self->[0], $self->[1])";
    }

    sub is_origin {
        my $self = shift;
        return $self->[0] == 0 && $self->[1] == 0;
    }

    sub addition {
        my $a = shift;
        my $b = shift;
        return Vector2->new( $a->[0] + $b->[0], $a->[1] + $b->[1] );
    }

    sub add_other {
        my $self = shift;
        my $other = shift;
        return Vector2->new( $self->[0] + $other->[0], $self->[1] + $other->[1] );
    }

    sub add_xy {
        my $self = shift;
        return Vector2->new( $self->[0] + shift, $self->[1] + shift );
    }

    sub y {
        shift->[1];
    }

    sub x {
        shift->[0];
    }

    sub is_in {
        my $self = shift;
        die "No width or height set"
            if !defined $width || !defined $height;
        return $self->[0] >= 0 && $self->[0] < $width && $self->[1] >= 0 && $self->[1] < $height;
    }
}
