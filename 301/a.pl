#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @s = do { chomp( my $l = <> ); split m{}, $l };

my $t = grep { m{T} } @s;
my $a = grep { m{A} } @s;

if ( $t > $a ) {
    say q{T};
    exit;
}

if ( $a > $t ) {
    say q{A};
    exit;
}

say $s[-1] eq q{A} ? q{T} : q{A};


exit;
