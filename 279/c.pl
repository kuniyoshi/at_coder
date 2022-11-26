#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $height, $width ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $height;
my @t = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $height;

my @sw = map { my $j = $_; join q{}, map { $s[ $_ ][ $j ] } 0 .. $height - 1 } 0 .. $width - 1;
my @tw = map { my $j = $_; join q{}, map { $t[ $_ ][ $j ] } 0 .. $height - 1 } 0 .. $width - 1;

my %count;
$count{ $_ }++
    for @tw;

for my $s ( @sw ) {
    $count{ $s }--
        if $count{ $s };
    delete $count{ $s }
        if exists $count{ $s } && $count{ $s } == 0;
}

say YesNo::get( !scalar %count );

exit;

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
