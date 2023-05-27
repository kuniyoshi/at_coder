#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @edges = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. ( $n - 1 );

my %link;

for my $ref ( @edges ) {
    my( $u, $v ) = @{ $ref };
    $link{ $u }{ $v }++;
    $link{ $v }{ $u }++;
}

for my $i ( 1 .. $n ) {
    #    warn "links: ", scalar %{ $link{ $i } };
    next
        unless %{ $link{ $i } // { } } > 1;
    my @vertexes = keys %{ $link{ $i } };
    my @candidates = grep { 1 < %{ $link{ $_ } } } @vertexes;
    next
        if @candidates != 1;
        #warn "\$i: $i";

    my( $to_be_removed_with ) = grep { $_ != $i } keys %{ $link{ $candidates[0] } };

    delete $link{ $candidates[0] }{ $to_be_removed_with };
    delete $link{ $to_be_removed_with }{ $candidates[0] };
}

my %count;
my %visited;
my @levels;

#die Dumper \%link;

for my $i ( 1 .. $n ) {
    next
        if $visited{ $i };

    my $before = %visited;
    my @queue = ( $i );

    while ( @queue ) {
        my $u = shift @queue;
        next
            if $visited{ $u }++;
        push @queue, grep { !$visited{ $_ } } keys %{ $link{ $u } // { } };
    }

    push @levels, %visited - $before - 1;
    #    $count{ %visited - $before - 1 }++;
}

#print map { sprintf "$_ $count{ $_ }\n" } sort { $a <=> $b } keys %count;
say join q{ }, sort { $a <=> $b } @levels;

exit;
