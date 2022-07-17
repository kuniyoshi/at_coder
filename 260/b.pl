#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $x, $y, $z ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @b = do { chomp( my $l = <> ); split m{\s}, $l };

my @students;

for my $i ( 0 .. $n - 1 ) {
    push @students, {
       index => $i,
       a     => $a[ $i ],
       b     => $b[ $i ],
       ab    => $a[ $i ] + $b[ $i ],
   };
}

my %passed;
my @passes;

for my $ref ( sort { $b->{a} <=> $a->{a} } @students ) {
    last
        if scalar( @passes ) == $x;

    next
        if $passed{ $ref->{index} }++;

    push @passes, $ref->{index} + 1;
}

for my $ref ( sort { $b->{b} <=> $a->{b} } @students ) {
    last
        if scalar( @passes ) == $x + $y;

    next
        if $passed{ $ref->{index} }++;

    push @passes, $ref->{index} + 1;
}

for my $ref ( sort { $b->{ab} <=> $a->{ab} } @students ) {
    last
        if scalar( @passes ) == $x + $y + $z;

    next
        if $passed{ $ref->{index} }++;

    push @passes, $ref->{index} + 1;
}

print map { $_, "\n" } sort { $a <=> $b } @passes;

exit;
