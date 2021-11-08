#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

chomp( my $n = <> );
my @lines = map { chomp; my @l = split m{\s}; { time => $l[0], dependencies => [ @l[ 2 .. $#l ] ] } }
            map { scalar <> }
            1 .. $n;

my @queue = @{ $lines[ $n - 1 ]{dependencies} };
my %count = ( $n => 1 );

while ( @queue ) {
    #    warn Dumper \@queue;
    my @nexts;
    for my $arts ( @queue ) {
        next
            if $count{ $arts }++;
        push @nexts, @{ $lines[ $arts - 1 ]{dependencies} };
    }
    @queue = @nexts;
}

my $total_time = sum
                 map { $lines[ $_ - 1 ]{time} }
                 keys %count;

                 #warn Dumper \%count;
say $total_time;

exit;
