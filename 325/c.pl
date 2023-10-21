#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $h;

my @deltas = (
    [ -1, -1 ],
    [ -1, 0 ],
    [ -1, 1 ],
    [ 0, -1 ],
    #    [ 0, 0 ],
    [ 0, 1 ],
    [ 1, -1 ],
    [ 1, 0 ],
    [ 1, 1 ],
);

my %visited;
my $count = 0;

for ( my $i = 0; $i < $h; ++$i ) {
    for ( my $j = 0; $j < $w; ++$j ) {
        next
            if $visited{ $i }{ $j };
        next
            if $s[ $i ][ $j ] ne q{#};

        $count++;
        #        warn "($i, $j)";

        my @queue = map { [ $i + $_->[0], $j + $_->[1] ] } @deltas;

        while ( @queue ) {
            my $ref = shift @queue;
            my( $r, $c ) = @{ $ref };
            next
                if $r < 0 || $r >= $h || $c < 0 || $c >= $w;
            next
                if $s[ $r ][ $c ] ne q{#};
            next
                if $visited{ $r }{ $c }++;
            push @queue, map { [ $r + $_->[0], $c + $_->[1] ] } @deltas;
        }
    }
}

say $count;


__END__

my $tree = UnionFindTree->new( $h * $w );

for ( my $i = 0; $i < $h * $w; ++$i ) {
    my $row = int( $i / $w );
    my $col = $i % $w;

    next
        if $s[ $row ][ $col ] ne q{#};

    for my $ref ( @deltas ) {
        my( $dr, $dc ) = @{ $ref };
        next
            if ( $row + $dr < 0 || $row + $dr >= $h || $col + $dc < 0 || $col + $dc >= $w );
        next
            if $s[ $row + $dr ][ $col + $dc ] ne q{#};
        my $u = ( $row + $dr ) * $w + $col + $dc;
        #        warn sprintf "(%d, %d) <=> (%d, %d)", $row, $col, $row + $dr, $col + $dc;
        $tree->unite( $i, $u );
    }
}

my %root;

for ( my $i = 0; $i < $h * $w; ++$i ) {
    my $row = int( $i / $w );
    my $col = $i % $w;

    next
        if $s[ $row ][ $col ] ne q{#};

    $root{ $tree->root( $i ) }++;
    #    warn "root: ", $tree->root( $i );
}

say scalar %root;

exit;

package UnionFindTree;
use 5.10.0;
use utf8;
use strict;
use warnings;

sub count {
    my $self = shift;
    my %count;
    $count{ $_ }++
        for map { $self->root( $_ ) }
            0 .. $#{ $self->{sizes} };
    return %count;
}

sub size {
    my $self = shift;
    my $u = shift;
    return $self->{sizes}[ $self->root( $u ) ];
}

sub unite {
    my $self = shift;
    my( $u, $v ) = @_;
    my( $root_u, $root_v ) = ( $self->root( $u ), $self->root( $v ) );

    return
        if $root_u == $root_v;

    my( $size_u, $size_v ) = @{ $self->{sizes} }[ $root_u, $root_v ];
    $self->{sizes}[ $root_v ] = $size_u + $size_v;
    $self->{sizes}[ $root_u ] = $size_u + $size_v;
    $self->{parents}[ $root_u ] = $root_v;
}

sub root {
    my $self = shift;
    my $v = shift;
    my $parent = $self->{parents}[ $v ];

    return $v
        if $parent == $v;

    return $self->{parents}[ $v ] = $self->root( $parent );
}

sub new {
    my $class = shift;
    my $n = shift;
    my @sizes = ( 1 ) x $n;
    return bless { parents => [ 0 .. ( $n - 1 ) ], sizes => \@sizes }, $class;
}

1;
