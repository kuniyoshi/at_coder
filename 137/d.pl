#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @jobs = sort { $b->[1] <=> $a->[1] }
           sort { $b->[0] <=> $a->[0] }
           map { chomp; [ split m{\s} ] }
           map { scalar <> }
           1 .. $n;

my $money = 0;
my $min_days = $m + 1;

while ( @jobs && $m ) {
    shift @jobs
        while @jobs && $jobs[0][0] > $min_days;
    last
        if !@jobs;
    warn "($jobs[0][0], $jobs[0][1])";
    $min_days = min( $min_days, $jobs[0][0] );
    $m--;
    $money += $jobs[0][1];
    shift @jobs;
}

say $money;

exit;
