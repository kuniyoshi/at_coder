#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @sets;

my $remain = $m;

while ( $remain-- ) {
    chomp( my $unuse = <> );
    my @a = do { chomp( my $l = <> ); split m{\s}, $l };
    my %set;
    $set{ $_ }++
        for @a;
    push @sets, \%set;
}

my $answer = 0;

OUTER:
for my $i ( 0 .. ( 2 ** $m - 1 ) ) {
    my @bits = reverse split m{}, sprintf "%b", $i;
    my @selections = grep { $bits[ $_ ] } 0 .. $#bits;
    die "somehow"
        if $i == 0 && @selections;
    for my $j ( 1 .. $n ) {
        next OUTER
            if !grep { $_->{ $j } } @sets[ @selections ];
    }
    #warn join q{, }, @bits;
    #warn join q{, }, @selections;
    #die Dumper [ @sets[ @selections ] ];
    $answer++;
}

say $answer;

exit;
