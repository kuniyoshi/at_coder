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

my %next = (
    s => q{n},
    n => q{u},
    u => q{k},
    k => q{e},
    e => q{s},
);
my @deltas = (
    [ 1, 0 ],
    [ 0, -1 ],
    [ -1, 0 ],
    [ 0, 1 ],
);

my @queue;
my %can_be;

if ( $s[0][0] eq q{s} ) {
    push @queue, [ 0, 0 ];
}

while ( @queue ) {
    my $ref = shift @queue;
    next
        if $can_be{ $ref->[0] }{ $ref->[1] }++;

    push @queue, grep { !$can_be{ $_->[0] }{ $_->[1] } } moves( $ref );
}

say YesNo::get( $can_be{ $h - 1 }{ $w - 1 } );

exit;

sub moves {
    my $ref = shift;
    my $next = $next{ $s[ $ref->[0] ][ $ref->[1] ] };
    return
        unless $next;
    my @moves;

    for my $delta ( @deltas ) {
        my $i = $ref->[0] + $delta->[0];
        my $j = $ref->[1] + $delta->[1];

        next
            if $i < 0 || $i >= $h || $j < 0 || $j >= $w;

        push @moves, [ $i, $j ]
            if $s[ $i ][ $j ] eq $next;
    }

    return @moves;
}

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
