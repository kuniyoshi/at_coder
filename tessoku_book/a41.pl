#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

chomp( my $n = <> );
my @s = do { chomp( my $l = <> ); split m{}, $l };

my @t;

for ( my $i = 0; $i < min( 6, $n ); ++$i ) {
    last
        if $i + 2 >= $n;
    $t[ $i + $_ ] = $s[ $i ]
        for 0 .. 2;
}

for ( my $i = $n - 1; $i >= 0; --$i ) {
    last
        if $i < 2;

    next
        if defined $t[ $i ] && $t[ $i ] eq $s[ $i ];

    $t[ $i - $_ ] = $s[ $i ]
        for 0 .. 2;
}

say YesNo::get( join( q{}, @t ) eq join( q{}, @s ) );

exit;

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
