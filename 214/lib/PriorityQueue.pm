package PriorityQueue::PriorSmall;

sub new {
    my $class = shift;
    return bless { items => [ ] }, $class;
}

sub push {
    my $self = shift;
    my $value = shift;
    Heap::reverse_push_to( $self->{items}, $value );
}

sub pop {
    my $self = shift;

    die "Could not pop while buffer is empty"
        unless @{ $self->{items} };

    return Heap::reverse_pop_from( $self->{items} );
}

sub peek {
    return shift->{items}[0];
}

sub size {
    return @{ shift->{items} };
}

package PriorityQueue::PriorLarge;

sub new {
    my $class = shift;
    return bless { items => [ ] }, $class;
}

sub push {
    my $self = shift;
    my $value = shift;
    Heap::push_to( $self->{items}, $value );
}

sub pop {
    my $self = shift;

    die "Could not pop while buffer is empty"
        unless @{ $self->{items} };

    return Heap::pop_from( $self->{items} );
}

sub peek {
    return shift->{items}[0];
}

sub size {
    return @{ shift->{items} };
}

package Heap;

sub push_to {
    my( $array, $item ) = @_;

    push @{ $array }, $item;

    my $parent_sub = sub {
        my $value = shift;
        return int( $value / 2 - 1 );
    };

    my $index = $#{ $array };

    while ( $parent_sub->( $index ) >= 0 && $array->[ $parent_sub->( $index ) ] > $array->[ $index ] ) {
        @{ $array }[ $parent_sub->( $index ), $index ] = @{ $array }[ $index, $parent_sub->( $index ) ];
        $index = $parent_sub->( $index );
    }
}

sub pop_from {
    my $array = shift;
    my $n = @{ $array } - 1;
    $array->[0] = $array->[ $n ];
    $#{ $array }--;

    my $left = sub { my $index = shift; return 2 * $index + 1; };
    my $right = sub { my $index = shift; return 2 * $index + 2; };
    my $top = sub {
        my $index = shift;
        return $right->( $index ) < @{ $array }
            && $array->[ $left->( $index ) ] > $array->[ $right->( $index ) ]
            ? $right->( $index )
            : $left->( $index );
    };

    my $curr = 0;

    while ( $left->( $curr ) < @{ $array } && $array->[ $curr ] > $top->( $curr ) ) {
        my $next = $top->( $curr );
        @{ $array }[ $next, $curr ] = @{ $array }[ $curr, $next ];
        $curr = $next;
    }
}

sub reverse_push_to {
    my( $buffer_ref, $item ) = @_;

    push @{ $buffer_ref }, $item;

    my $cursor = $#{ $buffer_ref };

    while ( $cursor != 0 ) {
        my $parent = int( ( $cursor - 1 ) / 2 );
        @{ $buffer_ref }[ $parent, $cursor ] = @{ $buffer_ref }[ $cursor, $parent ]
            if $buffer_ref->[ $parent ] >= $buffer_ref->[ $cursor ];
        $cursor = $parent;
    }
}

sub reverse_pop_from {
    my $buffer_ref = shift;

    my $last_root = $buffer_ref->[0];
    $buffer_ref->[0] = $buffer_ref->[-1];
    $#{ $buffer_ref }--;

    my $cursor = 0;

    while ( ( my $left = 2 * $cursor + 1 ) < @{ $buffer_ref } ) {
        my $right = $left + 1;

        my $child = $right < @{ $buffer_ref } && $buffer_ref->[ $left ] >= $buffer_ref->[ $right ]
            ? $right
            : $left;

        @{ $buffer_ref }[ $cursor, $child ] = @{ $buffer_ref }[ $child, $cursor ]
            if $buffer_ref->[ $cursor ] >= $buffer_ref->[ $child ];

        $cursor = $child;
    }

    return $last_root;
}

1;
