#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $x, $y ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @edges = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n - 1;

$x--;
$y--;

my %link;

for my $ref ( @edges ) {
    my( $u, $v ) = @{ $ref };
    $u--;
    $v--;
    $link{ $u }{ $v }++;
    $link{ $v }{ $u }++;
}

my @d;

for my $i ( 0 .. $n - 1 ) {
    for my $j ( 0 .. $n - 1 ) {
        $d[ $i ][ $j ] = $link{ $i }{ $j } ? 1 : 2 * $n;
    }
}

#my @passes;

for my $k ( 0 .. $n - 1 ) {
    for my $i ( 0 .. $n - 1 ) {
        for my $j ( 0 .. $n - 1 ) {
            if ( $d[ $i ][ $j ] > $d[ $i ][ $k ] + $d[ $k ][ $j ] ) {
                $d[ $i ][ $j ] = $d[ $i ][ $k ] + $d[ $k ][ $j ];
                #                push @{ $passes[ $i ][ $j ] }, $k;
            }
        }
    }
}

#say join q{ }, map { $_ + 1 } ( $x, @{ $passes[ $x ][ $y ] }, $y );

say join q{ }, map { $_ + 1 } djkstra( );

exit;

sub djkstra {
    my @queue = ( $x );
    my @passes = ( $x );
    my %visited;

    while ( @queue ) {
        my $v = shift @queue;
        next
            if $visited{ $v }++;

        for my $u ( grep { !$visited{ $_ } } keys %{ $link{ $v } } ) {
            if ( $u == $y ) {
                return @passes, $u;
            }

            #            warn "($v -> $u) if $d[ $u ][ $y ] < $d[ $v ][ $y ]";
            if ( $d[ $u ][ $y ] < $d[ $v ][ $y ] ) {
                push @queue, $u;
                push @passes, $u;
            }
        }
    }

    die "Could not found passes";
}



__END__

my @passes = bfs( );
say join q{ }, map { $_ + 1 } @passes;

exit;

sub bfs {
    my @queue = map { [ $_, [ $x ] ] }
                @{ $link{ $x } };
    my %visited = ( $x => 1 );

    if ( grep { $_ == $y } @{ $link{ $x } } ) {
        return $x, $y;
    }

    while ( @queue ) {
        my $ref = shift @queue;
        my $v = $ref->[0];
        next
            if $visited{ $v }++;

        if ( grep { $_ == $y } @{ $link{ $v } } ) {
            return @{ $ref->[1] }, $v, $y;
        }

        for my $u ( @{ $link{ $v } } ) {
            next
                if $visited{ $u };
            push @queue, [ $u, [ @{ $ref->[1] }, $v ] ];
        }
    }

    die "Could not find passes";
}
__END__

#for ( my $k = 0; $k < $n - 1; ++$k ) {
#    for ( my $i = 0; $i < $n - 1; ++$i ) {
#        for ( my $j = 0; $j < $n - 1; ++$j ) {
#            if ( $d[ $i ][ $j ] > $d[ $i ][ $k ] + $d[ $k ][ $j ] ) {
#                $d[ $i ][ $j ] = $d[ $i ][ $k ] + $d[ $k ][ $j ];
#            }
#        }
#    }
#}

die Dumper \@d;

my @passes = djkstra( );

exit;

sub djkstra {
    my @queue = ( $x );
    my @passes = ( $x );
    my %visited;

    while ( @queue ) {
        my $v = shift @queue;
        next
            if $visited{ $v }++;

        if ( $v == $y ) {
            return @passes;
        }

        for my $u ( grep { !$visited{ $_ } } keys %{ $link{ $v } } ) {
            warn "($v -> $u)";
            warn "$d[ $u ][ $y ], $d[ $v ][ $y ]";
            if ( $d[ $u ][ $y ] < $d[ $v ][ $y ] ) {
                push @queue, $u;
                push @passes, $u;
            }
        }
    }

    die "Could not found passes";
}



__END__

my @passes = bfs( );
say join q{ }, map { $_ + 1 } @passes;

exit;

sub bfs {
    my @queue = map { [ $_, [ $x ] ] }
                @{ $link{ $x } };
    my %visited = ( $x => 1 );

    if ( grep { $_ == $y } @{ $link{ $x } } ) {
        return $x, $y;
    }

    while ( @queue ) {
        my $ref = shift @queue;
        my $v = $ref->[0];
        next
            if $visited{ $v }++;

        if ( grep { $_ == $y } @{ $link{ $v } } ) {
            return @{ $ref->[1] }, $v, $y;
        }

        for my $u ( @{ $link{ $v } } ) {
            next
                if $visited{ $u };
            push @queue, [ $u, [ @{ $ref->[1] }, $v ] ];
        }
    }

    die "Could not find passes";
}
