#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $c = 0;

for my $i ( 0 .. 1000 ) {
    for my $j ( 0 .. $i - 1 ) {
        for my $k ( 0 .. $j - 1 ) {
            $c++;
        }
    }
}

say $c;

__END__

chomp( my $n = <> );
my( $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = do { chomp( my $l = <> ); split m{\s}, $l };
my @l = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $n;

exit;
