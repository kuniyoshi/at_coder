#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
chomp( my $m = <> );
my @b = do { chomp( my $l = <> ); split m{\s}, $l };
chomp( my $x = <> );

my %mochi;
$mochi{ $_ }++
    for @b;

my @dp = ( 1 );

for my $i ( 0 .. $x ) {
    next
        if $mochi{ $i };

    $dp[ $i ]++
        if grep { $dp[ $_ ] } grep { $_ >= 0 } map { $i - $_ } @a;
}

say YesNo::get( $dp[ $x ] );

exit;

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
