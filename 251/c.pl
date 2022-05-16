#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );
my @posts = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n;

my %prized;
my $max = -1;
my $who;

for my $i ( 0 .. $#posts ) {
    my( $post, $total ) = @{ $posts[ $i ] };
    next
        if $prized{ $post }++;

    if ( $total > $max ) {
        $who = $i + 1;
        $max = $total;
    }
}


say $who;

exit;
