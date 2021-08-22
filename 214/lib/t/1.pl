#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
require "../PriorityQueue.pm";
use Test::More tests => 99;

my $queue = PriorityQueue::PriorSmall->new;

my @numbers = map { int( 100 * rand ) - 50 } ( 1 .. 99 );

$queue->push( $_ )
    for @numbers;

my @sorted = sort { $a <=> $b } @numbers;

my @buffer = ( );

for my $i ( 1 .. 59 ) {
    push @buffer, $queue->pop;

    next
        if 0.5 < rand;

    $queue->push( $_ )
        for @buffer;
    @buffer = ( );
}

$queue->push( $_ )
    for @buffer;

for my $i ( 1 .. 99 ) {
    is( $queue->peek, shift @sorted );
    $queue->pop;
}

exit;

