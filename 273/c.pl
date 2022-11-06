#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @numbers = do { chomp( my $l = <> ); split m{\s}, $l };

my @values;

for my $number ( sort { $a <=> $b } @numbers ) {
    if ( !@values || $values[-1][0] != $number ) {
        push @values, [ $number, 1 ];
    }
    else {
        $values[-1][1]++;
    }
}

my %count;

for my $i ( 0 .. $#values ) {
    my $kinds = $#values - $i;
    $count{ $kinds } = $values[ $i ][1];
}

for my $i ( 0 .. $n - 1 ) {
    say $count{ $i } // 0;
}

exit;
