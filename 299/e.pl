#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @edges = map { chomp; [ map { $_ - 1 } split m{\s} ] }
            map { scalar <> }
            1 .. $m;
chomp( my $k = <> );
my @conditions = map { chomp; [ map { $_ - 1 } split m{\s} ] }
                 map { scalar <> }
                 1 .. $k;

my %link;

for my $ref ( @edges ) {
    my( $u, $v ) = @{ $ref };
    push @{ $link{ $u } }, $v;
    push @{ $link{ $v } }, $u;
}

my @colors;
$#colors = $n - 1;
my %blacks;

for my $cond_ref ( @conditions ) {
    my( $v, $d ) = @{ $cond_ref };

    my @queue = ( [ $v, 0 ] );

    if ( $d == 0 ) {
        if ( defined $colors[ $d ] && !$colors[ $d ] ) {
            say YesNo::get( 0 );
            exit;
        }
        $colors[ $d ] = 1;
    }

    my %visited;

    while ( @queue ) {
        my $ref = shift @queue;
        next
            if $visited{ $ref->[0] }++;
        next
            if $ref->[1] >= $d;

        if ( defined $colors[ $ref->[0] ] && $colors[ $ref->[0] ] ) {
            say YesNo::get( 0 );
            exit;
        }
        $colors[ $ref->[0] ] = 0;
        my @neighbors = grep { !$visited{ $_ } } @{ $link{ $ref->[0] } // [ ] };
        push @queue, map { [ $_, $ref->[1] + 1 ] } @neighbors;

        if ( $ref->[1] + 1 == $d ) {
            $blacks{ $v } = \@neighbors;
        }
    }
}

for my $cond_ref ( @conditions ) {
    my( $v, $d ) = @{ $cond_ref };

    my @blacks = @{ $blacks{ $v } // [ ] };
    if ( !@blacks ) {
        say YesNo::get( 0 );
        exit;
    }
    @colors[ $_ ] = 1
        for @blacks;
}

say YesNo::get( 1 );
say join q{}, map { defined ? $_ : 1 } @colors;

exit;
use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
