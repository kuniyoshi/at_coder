#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $head = <> );
my( $n, $m ) = split m{\s}, $head;
my @edges = map { chomp; [ split m{\s} ] }
            map { <> }
            1 .. $m;

my %graph;
$graph{ $_ } = undef
    for 1 .. $m;

for my $edge_ref ( @edges ) {
    my( $from, $to ) = @{ $edge_ref };
    push @{ $graph{ $to } }, $from;
}

my @s;

while ( grep { !defined $graph{ $_ } } keys %graph ) {
    my( $u ) = sort { $a <=> $b }
               grep { !defined $graph{ $_ } }
               keys %graph;
    push @s, $u;
    delete $graph{ $u };

    for my $key ( keys %graph ) {
        next
            unless defined $graph{ $key };
        $graph{ $key } = [ grep { $_ != $u } @{ $graph{ $key } } ];
        undef $graph{ $key }
            unless @{ $graph{ $key } };
    }
}

if ( %graph ) {
    say -1;
    exit;
}

say join q{ }, @s;

exit;
