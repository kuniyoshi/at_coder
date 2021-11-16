#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );

my $count = 0;

use integer;

for ( my $a = 1; $a * $a * $a < $n; ++$a ) {
    for ( my $b = $a; $a * $b * $b <= $n; ++$b ) {
        my $max = $n / ( $a * $b );
        my $patterns = $max - $b + 1;
        $count = $count + $patterns;
    }
}

say $count;

exit;
