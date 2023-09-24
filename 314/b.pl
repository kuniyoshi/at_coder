#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my %orders;

for ( my $i = 0; $i < $n; ++$i ) {
    chomp( my $c = <> );
    my @a = do { chomp( my $l = <> ); split m{\s}, $l };

    push @{ $orders{ $_ } }, [ $i, $c ]
        for @a;
}

chomp( my $x = <> );

my @candidates = sort { $a->[1] <=> $b->[1] } @{ $orders{ $x } };

unless ( @candidates ) {
    say 0;
    say q{};
    exit;
}

my @results = map { $_->[0] + 1 }
              grep { $_->[1] == $candidates[0][1] }
              @candidates;

say scalar @results;
say join q{ }, @results;

exit;
