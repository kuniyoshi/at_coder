#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @links = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $m;
my @s = do { chomp( my $l = <> ); split m{\s}, $l };

my %switch;
$switch{ $_ }++
    for @s;

my %connection;

for my $ref ( @links ) {
    my( $from, $to, $s ) = @{ $ref };
    push @{ $connection{ $s }{ $from } }, $to;
    push @{ $connection{ $s }{ $to } }, $from;
}

my $count = bfs( );

say $count // -1;

exit;

sub bfs {
    my %visited;
    $visited{1}{1}++;
    my @queue = ( [ 1, 0, 1 ] );

    while ( @queue ) {
        my $ref = shift @queue;
        my( $u, $c, $s ) = @{ $ref };
        #warn "### ($u, $c, $s)";

        return $c
            if $u == $n;

        for my $v ( @{ $connection{ $s }{ $u } } ) {
            #warn "--- $v ($s)";
            next
                if $visited{ $s }{ $v }++;
                #warn "!!! push [ $v, $c + 1, $s ]";
            push @queue, [ $v, $c + 1, $s ];
        }

        my $r = $s ? 0 : 1;

        if ( $switch{ $u } ) {
            #warn "!!! has switch: $u";
            for my $v ( @{ $connection{ $r }{ $u } } ) {
                #warn "--- $v ($r)";
                #warn Dumper \%visited;
                next
                    if $visited{ $r }{ $v }++;
                    #warn "!!! push [ $v, $c + 1, $r ]";
                push @queue, [ $v, $c + 1, $r ];
            }
        }
    }

    return;
}
