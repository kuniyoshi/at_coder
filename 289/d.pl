#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Memoize;

memoize( "r" );

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
chomp( my $m = <> );
my @b = do { chomp( my $l = <> ); split m{\s}, $l };
chomp( my $x = <> );

my %mochi;
$mochi{ $_ }++
    for @b;

say YesNo::get( r( $x ) );

exit;

sub r {
    my $v = shift;
    return 1
        if $v == 0;
    return
        if $v < 0;
    return grep { r( $_ ) } grep { !$mochi{ $_ } } map { $v - $_ } @a;
}

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
