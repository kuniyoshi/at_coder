#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $q ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @x = do { chomp( my $l = <> ); split m{\s}, $l };
my @e = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. ( $n - 1 );
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

my @edges;
for my $ref ( @e ) {
    my( $from, $to ) = @{ $ref };
    $from--;
    $to--;
    push @{ $edges[ $from ] }, $to;
    push @{ $edges[ $to ] }, $from;
}

my @sorted = topo_sort( );
die Dumper \@sorted;


my @answers;
#my @orders = 

exit;

sub topo_sort {
    my @vertexes = 0 .. ( $n - 1 );
    my @queue = ( 0 );
    my @result;

    my @in_degrees;

    for my $index ( 0 .. $#edges ) {
        $in_degrees[ $index ] = $edges[ $index ] ? @{ $edges[ $index ] } : 0;
    }

    while ( @queue ) {
        warn join ", ", @queue;
        my $v = shift @queue;

        push @result, $v;
        if ( !$edges[ $v + 1 ] ) {
            next;
        }

        for my $neighbor ( @{ $edges[ $v + 1 ] } ) {
            $in_degrees[ $neighbor ]--;
            do { push @queue, $neighbor; warn "pushed: $neighbor by $v" }
                if $in_degrees[ $neighbor ] == 0;
        }
    }

    return @result;
}
