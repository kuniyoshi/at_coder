#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $n;

my %distance;

for my $i ( 0 .. $n - 1 ) {
    for my $j ( 0 .. $i - 1 ) {
        $distance{ $i }{ $j } = $distance{ $j }{ $i } = delta( $s[ $i ], $s[ $j ] );
    }
}

for my $i ( 0 .. $n - 1 ) {
    my @queue = ( [ $i, { } ] );

    while ( @queue ) {
        my( $v, $visited_ref ) = @{ shift @queue };
        next
            if $visited_ref->{ $v }++;
        if ( %{ $visited_ref } == $n ) {
            say YesNo::get( 1 );
            exit;
        }
        for my $u ( keys %{ $distance{ $v } } ) {
            next
                if $distance{ $v }{ $u } != 1;
            next
                if $visited_ref->{ $u };
            push @queue, [ $u, { %{ $visited_ref } } ];
        }
    }
}

say YesNo::get( 0 );

exit;

sub delta {
    my( $s, $t ) = @_;
    my $delta = 0;
    for my $i ( 0 .. $#{ $s } ) {
        $delta++
            if $s->[ $i ] ne $t->[ $i ];
    }
    return $delta;
}

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
