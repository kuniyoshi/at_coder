#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $head = <> );
my( $l, $q ) = split m{\s}, $head;
my @q = map { chomp( my $line = <> ); [ split m{\s}, $line ] }
        1 .. $q;

my $btree = BTree::Tree->new( 60 );

for my $query ( @q ) {
    my( $operation, $x ) = @{ $query };
    if ( $operation == 1 ) {
        $btree->insert( $x );
    }
    if ( $operation == 2 ) {
        my $left = $btree->lower_bound( $x ) // 0;
        #        warn "\$x: $x";
        #warn "\$left: $left";
        my $right = $btree->upper_bound( $x ) // $l;
        #warn "\$right: $right";
        say $right - $left;
    }
}

exit;

package BTree::Tree;

sub new {
    my( $class, $t ) = @_;
    my %data = (
        t => $t,
        root => undef,
    );

    return bless \%data, $class;
}

sub lower_bound {
    my $self = shift;
    my $value = shift;

    return
        unless $self->{root};

    return $self->{root}->lower_bound( $value );
}

sub upper_bound {
    my $self = shift;
    my $value = shift;

    return
        unless $self->{root};

    return $self->{root}->upper_bound( $value );
}

sub search {
    my $self = shift;
    my $value = shift;

    return
        unless $self->{root};

    return $self->{root}->search( $value );
}

sub insert {
    my $self = shift;
    my $value = shift;

    if ( !$self->{root} ) {
        my $root = BTree::Node->new( $self->{t}, 1 );
        $root->{keys}[0] = $value;
        $root->{key_size} = 1;

        $self->{root} = $root;

        return;
    }

    if ( $self->{root}->is_full ) {
        my $new_root = BTree::Node->new( $self->{t}, 0 );
        $new_root->{children}[0] = $self->{root};
        $new_root->split( 0, $self->{root} );

        my $index = $new_root->{keys}[0] > $value ? 0 : 1;
        $new_root->{children}[ $index ]->insert( $value );

        $self->{root} = $new_root;

        return;
    }

    $self->{root}->insert( $value );
}

package BTree::Node;

sub new {
    my( $class, $t, $is_leaf ) = @_;
    my %data = (
        t => $t,
        key_size => 0,
        keys => [ ],
        children => [ ],
        is_leaf => $is_leaf,
    );

    return bless \%data, $class;
}

sub is_full {
    my $self = shift;

    return $self->{key_size} == 2 * $self->{t} - 1;
}

sub search {
    my $self = shift;
    my $value = shift;
    my $key_size = $self->{key_size};

    my $index = 0;
    $index++
        while $index < $key_size && $value > $self->{keys}[ $index ];

    return $self
        if $index < $key_size && $self->{keys}[ $index ] == $value;

    return
        if $self->{is_leaf};

    return $self->{children}[ $index ]->search( $value );
}

sub insert {
    my $self = shift;
    my $value = shift;

    my $index = 0;
    $index++
        while $index < $self->{key_size} && $value > $self->{keys}[ $index ];

    if ( $self->{is_leaf} ) {
        for ( my $i = $self->{key_size}; $i > $index; --$i ) {
            $self->{keys}[ $i ] = $self->{keys}[ $i - 1 ];
        }
        $self->{keys}[ $index ] = $value;
        $self->{key_size}++;

        return;
    }


    if ( $self->{children}[ $index ]->is_full ) {
        $self->split( $index, $self->{children}[ $index ] );
        my $child_index = $self->{keys}[ $index ] > $value
            ? $index
            : $index + 1;

        return $self->{children}[ $child_index ]->insert( $value );
    }

    return $self->{children}[ $index ]->insert( $value );
}

sub lower_bound {
    my $self = shift;
    my $value = shift;
    my $parent_left = shift;

    my $index = 0;
    $index++
        while $index < $self->{key_size} && $self->{keys}[ $index ] < $value;

    if ( $self->{is_leaf} ) {
        if ( $index == 0 ) {
            my $new_left = $parent_left // $self->{keys}[0];
            return
                if $new_left > $value;
            return $new_left;
        }
        return $self->{keys}[ $index - 1 ];
    }

    return $self->{chidren}[ $index ]->lower_bound( $value, $index == 0 ? undef : $self->{keys}[ $index ] );
}

sub upper_bound {
    my $self = shift;
    my $value = shift;
    my $parent_right = shift;

    my $index = $self->{key_size} - 1;
    $index--
        while $index >= 0 && $self->{keys}[ $index ] > $value;

    if ( $self->{is_leaf} ) {
        return $self->{keys}[0]
            if $index == -1;
        if ( $index == $self->{key_size} - 1 ) {
            my $new_right = $parent_right // $self->{keys}[ $self->{key_size} - 1 ];
            return
                if $new_right < $value;
            return $new_right;
        }
        return $self->{keys}[ $index + 1 ];
    }

    return $self->{chidren}[ $index + 1 ]->upper_bound( $value, $index == $self->{key_size} - 1 ? undef : $self->{keys}[ $index + 1 ] );
}

sub split {
    my( $self, $index, $child ) = @_;

    #    die "Leaf could not be split"
    #        if $self->{is_leaf};

    my $t = $self->{t};
    my $new_child = BTree::Node->new( $t, $child->{is_leaf} );
    $new_child->{key_size} = $t - 1;

    for ( my $i = 0; $i < $t - 1; ++$i ) {
        $new_child->{keys}[ $i ] = $child->{keys}[ $t + $i ];
    }

    if ( !$child->{is_leaf} ) {
        for ( my $i = 0; $i < $t; ++$i ) {
            $new_child->{children}[ $i ] = $child->{children}[ $t + $i ];
        }
    }

    $child->{key_size} = $t - 1;

    for ( my $i = $self->{key_size}; $i >= $index + 1; --$i ) {
        $self->{children}[ $i + 1 ] = $self->{children}[ $i ];
    }

    $self->{children}[ $index + 1 ] = $new_child;

    for ( my $i = $self->{key_size} - 1; $i >= $index; --$i ) {
        $self->{keys}[ $i + 1 ] = $self->{keys}[ $i ];
    }

    $self->{keys}[ $index ] = $child->{keys}[ $t - 1 ];

    $self->{key_size}++;
}
