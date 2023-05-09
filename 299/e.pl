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

my %distance;

for my $v ( 0 .. $n - 1 ) {
    my @queue = ( [ $v, 0 ] );
    my %visited;

    while ( @queue ) {
        my $ref = shift @queue;
        next
            if $visited{ $ref->[0] }++;
        $distance{ $v }{ $ref->[0] } = $ref->[1];
        push @queue, [ $_, $ref->[1] + 1 ]
            for grep { !$visited{ $_ } }
                @{ $link{ $v } };
    }
}

my @colors;
$#colors = $n - 1;

for my $cond_ref ( @conditions ) {
    my( $v, $d ) = @{ $cond_ref };

    $colors[ $v ] = 0;

    while ( my( $neighbor, $distance ) = each %{ $distance{ $v } } ) {
        next
            if $distance > $d;
        $colors[ $neighbor ] = 0;
    }
}

$_ = 1
    for grep { !defined } @colors;

my $blacks = grep { $_ } @colors;

if ( !$blacks ) {
    say YesNo::get( 0 );
    exit;
}

say YesNo::get( 1 );
say join q{}, @colors;

exit;
use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
