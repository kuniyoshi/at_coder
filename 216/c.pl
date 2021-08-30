#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use bigint;

chomp( my $n = <> );

my @answer_operations = bfs( );

die "Could not find answer"
    if @answer_operations > 120;

say join q{}, map { chr( ord( "A" ) + $_ ) } @answer_operations;

exit;

sub bfs {
    my %generated;
    my @operations = ( 0, 1 );
    my $value = 0;
    $generated{ $value }++;
    my @histories = ( );


    while ( @operations ) {
        my $op = shift @operations;
        my $next = $op ? 2 * $value : 1 + $value;
        next
            if $generated{ $next }++;

        bfs( [ @{ $op_histories_ref }, $op ], $op_ref, $next );
    }

    return @histories;
}
