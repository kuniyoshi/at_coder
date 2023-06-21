package AVLTree;
use utf8;
use strict;
use warnings;

sub new {
    my ($class, $key, $value) = @_;
    return bless {
        key     => $key,
        value   => $value,
        height  => 1,
        left    => undef,
        right   => undef
    }, $class;
}

sub insert {
    my ($self, $key, $value) = @_;

    return AVLTree->new($key, $value) unless defined $self;

    if ($key < $self->{key}) {
        $self->{left} = $self->{left}->insert($key, $value);
    } elsif ($key > $self->{key}) {
        $self->{right} = $self->{right}->insert($key, $value);
    } else {
        $self->{value} = $value;
    }

    return $self->_balance();
}

sub search {
    my ($self, $key) = @_;

    return unless defined $self;

    if ($key < $self->{key}) {
        return $self->{left}->search($key);
    } elsif ($key > $self->{key}) {
        return $self->{right}->search($key);
    } else {
        return $self->{value};
    }
}

sub delete {
    my ($self, $key) = @_;
    return unless defined $self;

    if ($key < $self->{key}) {
        $self->{left} = $self->{left}->delete($key);
    } elsif ($key > $self->{key}) {
        $self->{right} = $self->{right}->delete($key);
    } else {
        # If the node has no children, return undef
        return if (!defined $self->{left} && !defined $self->{right});

        # If the node has only one child, return the child
        if (!defined $self->{left}) {
            return $self->{right};
        }
        if (!defined $self->{right}) {
            return $self->{left};
        }

        # If the node has two children, replace the node's key and value with the key and value of the in-order predecessor
        # (could also use in-order successor)
        my $tmp = $self->{left};
        while (defined $tmp->{right}) {
            $tmp = $tmp->{right};
        }
        $self->{key} = $tmp->{key};
        $self->{value} = $tmp->{value};
        $self->{left} = $self->{left}->delete($tmp->{key});
    }
    return $self->_balance();
}

sub _height {
    my $self = shift;
    return defined $self ? $self->{height} : 0;
}

sub _balance_factor {
    my $self = shift;
    return $self->_height($self->{right}) - $self->_height($self->{left});
}

sub _update_height {
    my $self = shift;
    $self->{height} = 1 + max($self->_height($self->{left}), $self->_height($self->{right}));
}

sub _rotate_right {
    my $self = shift;
    my $left = $self->{left};

    $self->{left} = $left->{right};
    $left->{right} = $self;

    $self->_update_height();
    $left->_update_height();

    return $left;
}

sub _rotate_left {
    my $self = shift;
    my $right = $self->{right};

    $self->{right} = $right->{left};
    $right->{left} = $self;

    $self->_update_height();
    $right->_update_height();

    return $right;
}

sub _balance {
    my $self = shift;

    $self->_update_height();

    if ($self->_balance_factor() == -2) {
        if ($self->{left}->_balance_factor() > 0) {
            $self->{left} = $self->{left}->_rotate_left();
        }
        return $self->_rotate_right();
    }
    if ($self->_balance_factor() == 2) {
        if ($self->{right}->_balance_factor() < 0) {
            $self->{right} = $self->{right}->_rotate_right();
        }
        return $self->_rotate_left();
    }

    return $self;
}

1;
