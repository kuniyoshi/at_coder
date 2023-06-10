#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $h;

my %width;

for my $i ( 0 .. $h - 1 ) {
    $width{ $i } = grep { $s[ $i ][ $_ ] eq q{#} } 0 .. $w - 1;
}

my $i = find_fews( %width );

my %height;

for my $j ( 0 .. $w - 1 ) {
    $height{ $j } = grep { $s[ $_ ][ $j ] eq q{#} } 0 .. $h - 1;
}

my $j = find_fews( %height );

printf "%d %d\n", $i + 1, $j + 1;

exit;

sub find_fews {
    my %size = @_;
    my %count = reverse %size;
    delete $count{0};
    my $few_count = min( keys %count );
    my( $result ) = grep { $size{ $_ } == $few_count } keys %size;

    return $result;
}
